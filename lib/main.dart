import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';
import 'package:antenasur/widgwts/custom_drawer.dart';
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
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('ANTENA SUR - APP'),
          ),
          drawer: const DrawerWidget(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder(
                  future: _radioPlayer.getArtworkImage(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    Image artwork;
                    if (snapshot.hasData) {
                      artwork = snapshot.data;
                    } else {
                      artwork = Image.asset(
                        'assets/images/logo_as_v1.0.0.png',
                        fit: BoxFit.cover,
                      );
                    }
                    return Container(
                      height: 180,
                      width: 180,
                      child: ClipRRect(
                        child: artwork,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    );
                  },
                ),
                //SizedBox(height: 20),
                const Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                  //indent: 20,
                  endIndent: 0,
                ),
                Text(
                  metadata?[0] ?? 'Pausado',
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Text(
                  metadata?[1] ?? '',
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 20),

                FloatingActionButton(
                  elevation: 20,
                  onPressed: () {
                    isPlaying ? _radioPlayer.pause() : _radioPlayer.play();
                  },
                  tooltip: 'Control',
                  child: Icon(
                    isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  ),
                ),
              ],
            ),
          ),
        ),
        theme: AppTheme.lightTheme);
  }
}
