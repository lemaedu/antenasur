import 'package:antenasur/apis/radio_api.dart';
import 'package:antenasur/widgwts/gradient_background.dart';
import 'package:antenasur/widgwts/radio_player.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Antena Sur - App'),
      ),
      body: GradientBackground(
        child: FutureBuilder(
            future: RadioApi.initPlayer(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                );
              }
              return const RadioPlayer();
            }),
      ),
    );
  }
}
