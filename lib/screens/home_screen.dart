import 'package:antenasur/widgwts/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required RadioPlayer radioPlayer,
    required this.metadata,
    required this.isPlaying,
  }) : _radioPlayer = radioPlayer;

  final RadioPlayer _radioPlayer;
  final List<String>? metadata;
  final bool isPlaying;

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
        child: Center(
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
                metadata?[0] ?? 'Apagado',
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                metadata?[1] ?? '',
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              SizedBox(height: 20),

            ],
          ),
        ),
    ),
      /*
      floatingActionButton: FloatingActionButton(        
        elevation: 10,        
        onPressed: () {
          isPlaying ? _radioPlayer.pause() : _radioPlayer.play();
          },
          tooltip: 'Control',
          child: Icon(
            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, size:35
            ),            
      ),
    */
    floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: () {
          isPlaying ? _radioPlayer.pause() : _radioPlayer.play();
          },
          tooltip: 'Control',
          child: Icon(
            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, size:35
            ),          
        ),
      ),
    );
  }
}
