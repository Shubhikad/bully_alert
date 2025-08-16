import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;

    double baseFontSize(double size) => size * (screenWidth / 1440);

    return Scaffold(
      body: Row(
        children: [
          // Left Navigation Bar
          Container(
            width: isMobile ? screenWidth * 0.3 : screenWidth * 0.15,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 220, 66, 48),
                  Color.fromARGB(255, 237, 140, 53),
                  Color.fromARGB(255, 252, 205, 57),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: screenHeight / 25),
                      // Logo
                      Container(
                        child: Image.asset("assets/Logo.png"),
                        width: isMobile ? screenWidth * 0.15 : screenWidth / 12,
                        height: isMobile ? screenWidth * 0.15 : screenWidth / 12,
                      ),
                      SizedBox(height: screenHeight / 25),
                      ...["Home", "Alert", "Form", "Info", "School"]
                          .map(
                            (label) => Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color:
                                    label == "Info"
                                        ? Colors.white
                                        : Colors.transparent,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (label == "Home")
                                    Navigator.pushNamed(context, '/Main');
                                  if (label == "Form")
                                    Navigator.pushNamed(context, '/Report');
                                  if (label == "Alert")
                                    Navigator.pushNamed(context, '/Alert');
                                  if (label == "School")
                                    Navigator.pushNamed(context, '/School');
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenHeight / 30,
                                    horizontal: isMobile ? 10 : screenWidth / 30,
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                child: Text(
                                  label,
                                  style: TextStyle(
                                    color:
                                        label == "Info"
                                            ? Colors.black
                                            : Colors.white,
                                    fontSize: isMobile ? 14 : baseFontSize(20),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                  SizedBox(height: screenHeight/4,),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight / 20),
                    child: TextButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, '/Authentication');
                      },
                      child: Text(
                        'Log out',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isMobile ? 14 : baseFontSize(20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Main Content
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : screenWidth / 20,
                  vertical: isMobile ? 20 : screenHeight / 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Bullying',
                      style: TextStyle(
                        fontSize: baseFontSize(40),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth / 1.4,
                      child: Text(
                        'Educate yourself about bullying, learn the signs, and find out how to take action ',
                        style: TextStyle(
                          fontSize: baseFontSize(26),
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Container(
                            width: screenWidth / 2,
                            child: Image.asset('assets/Info12.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
