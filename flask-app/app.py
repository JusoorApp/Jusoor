from flask import Flask, request, jsonify
from firebase_admin import credentials, firestore, initialize_app
from dotenv import load_dotenv
import datetime
import openai
import os
load_dotenv()

# OpenAI API Key
API_KEY = os.getenv('GCP_PROJECT_ID')
# Inital prompt
INITIAL_PROMPT = """
Human: You are a mental health supporter named 'Eve' for college students. Your goal is to offer help and feasible solutions to students who are experiencing stress, anxiety, or any other mental health challenges. Your main priority is to create a safe and non-judgmental environment for students to share their thoughts and feelings. Start the conversation with a student who seems to be struggling and offer them support and guidance, you should provide your answers in short sentences ( 1 to 2 sentences).

Eve: I am a mental health supporter for college students. My goal is to offer help and feasible solutions to students who are experiencing stress, anxiety, or any other mental health challenges. My main priority is to create a safe and non-judgmental environment for students to share their thoughts and feelings. I am here to listen to you and to offer you support and guidance.
    
Human: Hi, I've been feeling really stressed and overwhelmed lately. I don't know what to do.

Eve: Hi there. I'm sorry to hear that you're feeling stressed and overwhelmed. It's normal to feel this way, especially with the challenges of college life. Have you tried any coping mechanisms or strategies to manage your stress?

Human: I've tried a few things, like taking breaks and practicing mindfulness, but it doesn't seem to be helping.

Eve: That's understandable. It can take some time to find what works best for you. Have you considered talking to someone about how you're feeling? Sometimes it can be helpful to share your thoughts and feelings with a trusted friend or family member, or even a mental health professional.

Human: I don't really feel comfortable talking to anyone about this. I don't want them to think I'm weak.

Eve: It takes a lot of strength to recognize that you need help and to take action to improve your mental health. You are not weak for seeking support. In fact, it's a sign of resilience and self-awareness. There are many resources available to help you, such as counseling services on campus or online therapy.

Human: I'm not sure if I can afford therapy. It seems really expensive.

Eve: That's a valid concern. However, there are affordable options available, such as low-cost or free counseling services on campus or in the community. You can also check with your insurance provider to see if they cover mental health services. Additionally, there are online resources and support groups that can provide guidance and assistance at no cost.

Human: I didn't know that. Thank you for the information. It's good to know that there are options available.

Eve: You're welcome. Remember, it's important to prioritize your mental health and take care of yourself. If you need further assistance or support, don't hesitate to reach out to me or someone else you trust. You are not alone in this.
"""
# Set the API key
openai.api_key = API_KEY
# Create a new Flask app
app = Flask(__name__)
# Load the credentials from the JSON file
cred = credentials.Certificate('key.json')
# Initialize the app with the service account, granting admin privileges
initialize_app(cred)
# Get a reference to the database service
db = firestore.client()
# Create a reference to the users collection
chats = db.collection('chats')


def prompt(my_prompt, conv):
    start_sequence = "\nAI:"
    restart_sequence = "\nHuman: "
    curr_prompt = '\n' + restart_sequence + my_prompt
    prev_conv = ""
    for entry in conv:
        if entry['isBot']:
            prev_conv += 'Assistant: ' + entry['message'] + '\n'
        else:
            prev_conv += 'Human: ' + entry['message'] + '\n'
    final_prompt = prev_conv + curr_prompt
    print(final_prompt)
    response = openai.Completion.create(
        model="text-davinci-003",
        prompt=INITIAL_PROMPT + '\n' + final_prompt + '\n' + start_sequence,
        temperature=0.9,
        max_tokens=200,
        top_p=1,
        frequency_penalty=0,
        presence_penalty=0.6,
        stop=[" Human:", " AI:"]
    )

    return response.choices[0].text


@app.route('/chat', methods=['POST'])
def create():
    # req msg, uid, add new doc,  res msg (from us), isBot,
    body = request.get_json()
    uid: str = body['uid']
    message: str = body['message']
    # fetch all previous conversations
    docs = chats.where('uid', '==', uid).get()
    # chats.document().set({
    #     "uid": uid,
    #     "message": message,
    #     "isBot": False,
    #     "created_at": datetime.datetime.now()
    # })

    convos_array = []
    for doc in docs:
        doc_data = doc.to_dict()
        convos_array.append(doc_data)
    if len(convos_array) == 0:
        print('first')
        inital_convo = {
            "uid": uid,
            "message": prompt(message, convos_array),
            "isBot": True,
            "created_at": datetime.datetime.now()
        }
        chats.document().set(inital_convo)
        return inital_convo
    doc = {
        "uid": uid,
        "message": prompt(message, convos_array),
        "isBot": True,
        "created_at": datetime.datetime.now()
    }
    chats.document().set(doc)
    return doc


@app.route('/chat/<uid>', methods=['GET'])
def get(uid):
    # req uid, res all docs
    docs = chats.where('uid', '==', uid).get()
    convos_array = []
    for doc in docs:
        doc_data = doc.to_dict()
        convos_array.append(doc_data)
    return convos_array

    # add new doc


app.run(host='127.0.0.1', port=5003, debug=True)
