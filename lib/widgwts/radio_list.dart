import 'package:antenasur/apis/radio_api.dart';
import 'package:antenasur/apis/shared_prefs_api.dart';
import 'package:antenasur/models/radio_station.dart';
import 'package:antenasur/providers/radio_provider.dart';
import 'package:antenasur/utils/radio_stations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RadioList extends StatefulWidget {
  const RadioList({super.key});

  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  late RadioStation selectedStation;
  late RadioProvider provider;
  @override
  void initState() {    
    super.initState();
    provider = Provider.of<RadioProvider>(context, listen: false);
    selectedStation = provider.station;
  }

  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<RadioProvider>(context, listen: false);
    return ListView.builder(
      itemCount: RadioStations.allStations.length,
      itemBuilder: (context, index) {
        final station = RadioStations.allStations[index];
        bool isSelected = station.name == provider.station.name;
        return Container(
          decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(
                      colors: [Colors.pink, Colors.deepPurple])
                  : null),
          child: ListTile(
              leading: Image.network(
                station.photoUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
              horizontalTitleGap: 50,
              title: Text(
                station.name,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected?FontWeight.bold:FontWeight.normal),
              ),
              onTap: () async {
                provider.setRadioStation(station);
                SharedPrefsApi.setStation(station);
                await RadioApi.changeStation(station);
                setState(() {
                  selectedStation = station;
                });
              }),
        );
      },
    );
  }
}
