import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject/features/splash/presentation/splash_screen.dart';
import 'package:graduationproject/shared/storage_helper.dart';

import 'core/di/injection_container.dart' as di;
import 'shared/firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await StorageHelper.init();

  await di.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MedVision',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Initial page is LoginPage
    );
  }
}

