import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  
  const MainPage({super.key});
  


  @override
  Widget build(BuildContext context) {
    

   final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;

    double baseFontSize(double size) => size * (screenWidth / 1440);
    double basePadding(double size) => size * (screenWidth / 1440);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/Background.png", fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}