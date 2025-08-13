import 'package:bully_alert/firebase_options.dart';
import 'package:bully_alert/views/intro_page.dart';
import 'package:bully_alert/views/main_page.dart';
import 'package:bully_alert/views/verification_page.dart';
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
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      routes: {
        '/Intro': (context) => const IntroPage(),
        '/Main': (context) => const MainPage(),
        '/Verification': (context) => const VerificationPage(),
        '/Authentication': (context) => const Authentication(),
        
      },
      theme: ThemeData(
        // Set Poppins as the default font for the entire app
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme, // Inherit existing text theme and apply Poppins
        ),
        //colorScheme: ColorScheme(brightness: Brightness.light, primary: Colors.orange, onPrimary: Colors.white, secondary: Colors.yellow, onSecondary: Colors.black, error: Colors.grey, onError: Colors.black, surface: Colors.white, onSurface: Colors.black)
      ),
      
      home: Authentication(),
    );
  }
}
class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          //initialise firebase
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              //check if firebase is connected
              case ConnectionState.done:
                final user = FirebaseAuth.instance.currentUser;
                //final emailVerified = user?.emailVerified ?? false;
                //check if a user already exists on the device

                if (user == null) {
                  
                  return const IntroPage();
                } else if (user != null) {
                    if(user.emailVerified){
                      
                      return const MainPage();
                    }
                    else
                    {
                      
                      return VerificationPage();
                      
                    }
                } else {
                  
                  return const IntroPage();
                }

              default:
                return const Text('Loading...');
            }
          } //test
          ), //FutureBuilder
    ); 
  }
}
