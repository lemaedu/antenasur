import 'package:antenasur/apis/shared_prefs_api.dart';
import 'package:antenasur/models/radio_station.dart';
import 'package:antenasur/providers/radio_provider.dart';
import 'package:antenasur/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:antenasur/theme/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final radioStation = await SharedPrefsApi.getInitialRadioStation();
  runApp(MyApp(
    initialStation: radioStation,
  ));
}

class MyApp extends StatelessWidget {
  final RadioStation initialStation;
  const MyApp({required this.initialStation, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: ((context) => RadioProvider(initialStation))),
      ],
      child: MaterialApp(        
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
