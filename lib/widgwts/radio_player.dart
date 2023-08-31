import 'package:antenasur/apis/radio_api.dart';
import 'package:antenasur/providers/radio_provider.dart';
import 'package:antenasur/widgwts/radio_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volume_controller/volume_controller.dart';

class RadioPlayer extends StatefulWidget {
  const RadioPlayer({super.key});

  @override
  State<RadioPlayer> createState() => _RadioPlayerState();
}

class _RadioPlayerState extends State<RadioPlayer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late VolumeController volumeController;
  late Animation<Offset> radioOffset;
  late Animation<Offset> radioListOffset;

  bool listEnabled = false;
  bool isPlaying = true;
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    radioListOffset = Tween(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));

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
    volumeController = VolumeController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: SlideTransition(
          position: radioOffset,
          child: Column(
            children: [
              Container(
                  height: 200,
                  width: 200,
                  color: Colors.transparent,
                  child:
                      Consumer<RadioProvider>(builder: (context, value, child) {
                    return Image.network(
                      value.station.photoUrl,
                      fit: BoxFit.cover,
                    );
                  })),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          listEnabled = !listEnabled;
                        });

                        switch (animationController.status) {
                          case AnimationStatus.dismissed:
                            animationController.forward();
                            break;
                          case AnimationStatus.completed:
                            animationController.reverseDuration;
                            break;

                          default:
                        }
                      },
                      color: listEnabled ? Colors.amber : Colors.white,
                      iconSize: 30,
                      icon: const Icon(Icons.list)),
                  IconButton(
                      onPressed: () async {
                        isPlaying
                            ? RadioApi.player.stop()
                            : RadioApi.player.play();
                      },
                      color: Colors.white,
                      iconSize: 30,
                      icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow)),
                  IconButton(
                      onPressed: () async {
                        if (isMuted) {
                          volumeController.setVolume(0.5);
                        } else {
                          volumeController.muteVolume();
                        }
                        setState(() {
                          isMuted=!isMuted;
                        });
                      },
                      color: Colors.white,
                      iconSize: 30,
                      icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up))
                ],
              )
            ],
          ),
        )),
        SlideTransition(
          position: radioListOffset,
          child: Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
            child: const Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Radios',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                Divider(
                  color: Colors.black,
                  indent: 30,
                  endIndent: 30,
                ),
                Expanded(child: RadioList()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
