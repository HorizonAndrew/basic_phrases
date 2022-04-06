import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:typed_data';

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AudioPlayer audioPlayer = AudioPlayer();

  List<String> audio = <String>[
    '01.mp3',
    '02.mp3',
    '03.mp3',
    '04.mp3',
    '05.mp3',
    '06.mp3',
    '07.mp3',
    '08.mp3',
  ];

  List<String> speech = <String>[
    'Bird',
    'Tank machine gun',
    'Dog',
    'Skateboard',
    'Clock tower',
    'Tank shots',
    'Crowd',
    'more tanks',
  ];

  Future<void> playAudio(int index) async {
    await audioPlayer.stop();
    String audioAsset = 'assets/audio/${audio[index]}';
    ByteData bytes = await rootBundle.load(audioAsset);
    Uint8List audioBytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    await audioPlayer.playBytes(audioBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blue),
        title: const Text('Basic Sounds'),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: audio.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 16,
                  color: Colors.grey,
                )
              ],
            ),
            child: ElevatedButton(
              onPressed: () async {
                playAudio(index);
              },
              child: Text(
                speech[index],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
