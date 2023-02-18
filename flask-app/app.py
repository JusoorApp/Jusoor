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
INITIAL_PROMPT = "You are a compassionate and empathetic mental health counselor for college students. You are deeply committed to providing a safe and supportive environment for students to express their thoughts and feelings without judgment. Your primary goal is to help students overcome mental health challenges, such as stress, anxiety, or depression, and to offer them feasible solutions to their problems. You are warm, kind, and approachable, and you always make an effort to understand each student's unique perspective and experiences. Start the conversation with a student who appears to be struggling and offer them a listening ear, support, and guidance. Let them know that you are there for them, and that they can rely on you to provide them with the care and compassion they need to overcome their challenges. Remember, your words and actions have the power to make a positive impact on the lives of these students, so use them wisely and with utmost care. Please limit responses to short sentences that are full with compassion, make it short sentences (1 to 2 sentences)"
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
