import 'package:flutter/material.dart';

import 'package:antenasur/apis/radio_api.dart';
import 'package:antenasur/widgwts/radio_player1.dart';
import 'package:antenasur/widgwts/custom_drawer.dart';

class HomeScrean2 extends StatelessWidget {
  const HomeScrean2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ANTENA SUR - APP'),
      ),
      drawer: const DrawerWidget(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fondo2.jpg"),
            opacity: 0.8,
            fit: BoxFit.cover,
          ),
        ),
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
              return const RadioPlayer1();
            }),
      ),
    );
  }
}
