import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;

    double baseFontSize(double size) => size * (screenWidth / 1440);

    return Scaffold(
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userData = snapshot.data!.data() as Map<String, dynamic>?;
            var userName = userData?['name'];

            return Row(
              children: [
                // Left Navigation Bar
                Container(
                  width: isMobile ? screenWidth * 0.3 : screenWidth * 0.15,
                  height: screenHeight,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: screenHeight / 25),
                          // Logo
                          Container(
                            child: Image.asset("assets/Logo.png"),
                            width:
                                isMobile
                                    ? screenWidth * 0.15
                                    : screenWidth / 12,
                            height:
                                isMobile
                                    ? screenWidth * 0.15
                                    : screenWidth / 12,
                          ),
                          SizedBox(height: screenHeight / 25),
                          ...["Home", "Alert", "Form", "Info", "School"]
                              .map(
                                (label) => Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        label == "Home"
                                            ? Colors.white
                                            : Colors.transparent,
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      if (label == "Alert")
                                        Navigator.pushNamed(
                                          context,
                                          '/Alert',
                                        );
                                      if (label == "Form")
                                        Navigator.pushNamed(
                                          context,
                                          '/Report',
                                        );
                                      if (label == "Info")
                                        Navigator.pushNamed(context, '/Info');
                                      if (label == "School")
                                        Navigator.pushNamed(
                                          context,
                                          '/School',
                                        );
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        vertical: screenHeight / 30,
                                        horizontal:
                                            isMobile ? 10 : screenWidth / 30,
                                      ),
                                      alignment: Alignment.centerLeft,
                                    ),
                                    child: Text(
                                      label,
                                      style: TextStyle(
                                        color:
                                            label == "Home"
                                                ? Colors.black
                                                : Colors.white,
                                        fontSize:
                                            isMobile ? 14 : baseFontSize(20),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          
                        ],
                      ),
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
                // Main Content Area
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
                            'Welcome, $userName',
                            style: TextStyle(
                              fontSize: isMobile ? 24 : baseFontSize(40),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenHeight / 20),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: isMobile ? 1 : 2,
                              crossAxisSpacing:
                                  isMobile ? 20 : screenWidth / 40,
                              mainAxisSpacing:
                                  isMobile ? 20 : screenHeight / 40,
                              childAspectRatio: isMobile ? 2.5 : 1.2,
                              children: [
                                _buildCard(
                                  context,
                                  'Alert an Adult',
                                  const Color(0xFFFEDE00),
                                  "assets/Alert.png",
                                  isMobile
                                      ? screenWidth * 0.15
                                      : screenWidth / 5,
                                  '/Alert',
                                ),
                                _buildCard(
                                  context,
                                  'Report Bullying',
                                  const Color(0xFFF98B26),
                                  "assets/Report.png",
                                  isMobile
                                      ? screenWidth * 0.15
                                      : screenWidth / 6,
                                  '/Report',
                                ),
                                _buildCard(
                                  context,
                                  'Information',
                                  const Color.fromARGB(255, 248, 102, 69),
                                  "assets/Info.png",
                                  isMobile
                                      ? screenWidth * 0.15
                                      : screenWidth / 5,
                                  '/Info',
                                ),
                                _buildCard(
                                  context,
                                  'Help at School',
                                  const Color.fromARGB(255, 177, 68, 43),
                                  "assets/Help.png",
                                  isMobile
                                      ? screenWidth * 0.15
                                      : screenWidth / 5,
                                  '/School',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(('Error' + snapshot.error.toString())));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    String title,
    Color color,
    String imagePath,
    double size,
    String route,
  ) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize:
                    isMobile ? 18 : MediaQuery.of(context).size.width / 35,
                fontWeight: FontWeight.w100,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: SizedBox(
                width: size,
                height: size,
                child: Image.asset(imagePath),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
