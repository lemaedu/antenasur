import 'package:antenasur/apis/radio_api.dart';
import 'package:antenasur/providers/radio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volume_controller/volume_controller.dart';

class RadioPlayer1 extends StatefulWidget {
  const RadioPlayer1({super.key});

  @override
  State<RadioPlayer1> createState() => _RadioPlayer1State();
}

class _RadioPlayer1State extends State<RadioPlayer1>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late VolumeController volumeController;
  late Animation<Offset> radioOffset;
  late Animation<Offset> radioListOffset;

  bool listEnabled = false;
  bool isPlaying = true;
  bool isMuted = false;

  List<String>? metadata;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    radioOffset = Tween(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

    RadioApi.player.stateStream.listen((event) {
      setState(() {
        isPlaying = event;        
      });
    });

    //Carga Metadata de la Canción
    RadioApi.player.metadataStream.listen((event) {
      setState(() {
        metadata = event;
      });
    });

    volumeController = VolumeController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 180,
                width: 180,
                color: Colors.transparent,
                child:
                    Consumer<RadioProvider>(builder: (context, value, child) {
                  return Image.network(
                    value.station.photoUrl,
                    fit: BoxFit.cover,
                  );
                })),
            Text(              
              metadata?[0] ?? 'Apagado',
              softWrap: false,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              metadata?[1] ?? '',
              softWrap: false,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              //indent: 20,
              endIndent: 0,
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              FloatingActionButton(
                onPressed: () async {
                  isPlaying ? RadioApi.player.stop() : RadioApi.player.play();
                  
                },
                child: Icon(
                    isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    size: 30),
              ),
              FloatingActionButton(
                onPressed: () async {
                  if (isMuted) {
                    volumeController.setVolume(0.5);
                  } else {
                    volumeController.muteVolume();
                  }
                  setState(() {
                    isMuted = !isMuted;
                  });
                },
                child: Icon(isMuted ? Icons.volume_off : Icons.volume_up,
                    size: 30),
              ),
            ]),
          ],
        ),
      ),
    ]);
  }
}
