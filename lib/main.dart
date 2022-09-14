import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:store/Screens/BottomNavigationBar.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'AE')
        ],
        locale: const Locale('ar', 'AE'),
        debugShowCheckedModeBanner: false,
        title: 'Store',
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        home: const SafeArea(child: BottomNavigationBarScreen()));
  }
}


/**
 * 
 * SERVER STATE:Active	TRAFFIC:0.00 GB / 1,159.28 GB
CPU:4	IP:45.61.53.48
MEMORY:4 GB	SERVER USERNAME:root
STORAGE:80 GB	PASSWORD:4Nt93XD6wZ18 
SERVICE LEVEL AGREEMENT:	BACK-UP:



git config --global user.email "Hamza.nazhan097@gmail.com"
  git config --global user.name "HamzaDevLoL"
 */


