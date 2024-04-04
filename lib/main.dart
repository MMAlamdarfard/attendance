import 'package:attendance/page/authentication_page.dart/login_page.dart';
import 'package:attendance/page/student_page/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> navigatorKey =GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();  
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async{
    if(navigatorKey.currentState!=null){
      Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
          builder: (context) =>  const MainPage(),
        ),
      );
    }
    
  });
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message){
   if(message !=null){
    if(navigatorKey.currentState!=null){
      Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
          builder: (context) =>  const MainPage(),
        ),
      );
    }
  } 
});
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  if (message.notification != null) {
   
  }
});

  FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async{
    await Firebase.initializeApp();
  });

 
  FirebaseMessaging.instance.getToken().then((value){
    
      //print("token: $value");
     
  });
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? data=prefs.getString('accessToken');
  runApp(MyApp(isLogged:  !(data==null || data=="")));
}

class MyApp extends StatelessWidget {
  final bool isLogged;
  const MyApp({super.key, required this.isLogged});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      title: 'AttendanceApp',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      localizationsDelegates:const [
           GlobalCupertinoLocalizations.delegate,
           GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales:const[
        Locale("fa", "IR"), 
      ],
      locale: const Locale("fa", "IR"),
      theme: ThemeData(
        useMaterial3: true,
      ),
      
      home: isLogged ? const MainPage(): const LoginPage()
    );
  }
}

