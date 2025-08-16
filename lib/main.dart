import 'package:bully_alert/firebase_options.dart';
import 'package:bully_alert/views/alert_page.dart';
import 'package:bully_alert/views/info_page.dart';
import 'package:bully_alert/views/intro_page.dart';
import 'package:bully_alert/views/main_page.dart';
import 'package:bully_alert/views/moreinfo_page.dart';
import 'package:bully_alert/views/report_page.dart';
import 'package:bully_alert/views/school_page.dart';
import 'package:bully_alert/views/verification_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCbCXz9rZi8P2g8tJBwvu39nj4-Nd9gB5E",
      authDomain: "bully-alert-application.firebaseapp.com",
      projectId: "bully-alert-application",
      storageBucket: "bully-alert-application.appspot.com",
      messagingSenderId: "218493434420",
      appId: "1:218493434420:web:e9d0ffa8f839d9de546861",
    ),
  );
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/Intro': (context) => const IntroPage(),
        '/Main': (context) => const MainPage(),
        '/Verification': (context) => const VerificationPage(),
        '/Authentication': (context) => const Authentication(),
        '/Alert': (context) => const AlertPage(),
        '/Report': (context) => const ReportPage(),
        '/Info': (context) => const InfoPage(),
        '/School': (context) => const SchoolPage(),
      },

      
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Colors.orange,
          
        ),
        scaffoldBackgroundColor: Colors.white
      ),
    
      home: const Authentication(),
    );
  }
}

Future<DocumentSnapshot<Map<String, dynamic>>> fetchData() async {
  final user = FirebaseAuth.instance.currentUser;
  if(user == null) throw Exception('User not logged in');
  final docSnapshot = await FirebaseFirestore.instance.collection('users').doc(user.email).get();
  return docSnapshot;
}

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          if(snapshot.connectionState != ConnectionState.done){
            return const Center(child: CircularProgressIndicator());
          }
          final user = FirebaseAuth.instance.currentUser;
          if(user == null){
            return const IntroPage();
          }
          if(!user.emailVerified){
            return const VerificationPage();
          }
          return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: fetchData(),
            builder: (context, userSnapshot){
              if(userSnapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              } else if(userSnapshot.hasError){
                return Center(child: Text('Error: \${userSnapshot.error}'));
              } else if(userSnapshot.hasData){
                return userSnapshot.data!.exists ? const MainPage() : MoreinfoPage();
              } else {
                return const IntroPage();
              }
            }
          );
        },
      ),
    );
  }
}
