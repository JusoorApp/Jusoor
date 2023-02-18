import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

const appId = 'a16cee9f3e3e4378a13dc886078c0913';
String channelName = 'test1';
String token =
    '007eJxTYPh7zGTFwfhDWrsuTViw2fKh095PW5k3/Xt1MVR83yTL0pfPFRgSDc2SU1Mt04xTjVNNjM0tEg2NU5ItLMwMzC2SDSwNjScsfJ/cEMjI8E/5EAsjAyMDCxCD+ExgkhlMskDJktTiEgYGAERyJrY=';
int uid = 0; // uid of the local user

/// JoinChannelAudio Example
class JoinChannelAudio extends StatefulWidget {
  /// Construct the [JoinChannelAudio]
  const JoinChannelAudio({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelAudio> {
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: appId,
      channelName: "test",
      tempToken: token,
      uid: uid,
    ),
  );

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
    print(client.users);
  }

  //Build

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: client,
              ),
              AgoraVideoButtons(
                disconnectButtonChild: GestureDetector(
                    onTap: () {
                      print("hi");
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.phone)),
                onDisconnect: () {},
                client: client,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
