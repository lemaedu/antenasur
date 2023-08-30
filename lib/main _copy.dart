// ignore: file_names
import 'package:antenasur/screens/home_screan2.dart';
import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';
import 'package:antenasur/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final RadioPlayer _radioPlayer = RadioPlayer();
  bool isPlaying = false;
  List<String>? metadata;

  @override
  void initState() {
    super.initState();
    initRadioPlayer();
  }

  void initRadioPlayer() {
    _radioPlayer.setChannel(
      title: 'Antena Sur Digital',
      url: 'https://cast1.my-control-panel.com/proxy/antenas1/stream',
      imagePath: 'assets/images/logo_as_v1.0.0.png',
    );

    _radioPlayer.stateStream.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });

    _radioPlayer.metadataStream.listen((value) {
      setState(() {
        metadata = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScrean2(
            radioPlayer: _radioPlayer,
            metadata: metadata,
            isPlaying: isPlaying),
        theme: AppTheme.lightTheme);
  }
}
