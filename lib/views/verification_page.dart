import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool isEmailVerified = false;
  bool isLoading = true;
  late User user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    isEmailVerified = user.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();
      checkEmailVerified();
    } else {
      setState(() => isLoading = false);
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      await user.sendEmailVerification();
    } catch (e) {
      debugPrint("Error sending verification email: $e");
    }
  }

  Future<void> checkEmailVerified() async {
    while (!isEmailVerified) {
      await Future.delayed(const Duration(seconds: 3));
      await user.reload();
      user = FirebaseAuth.instance.currentUser!;
      if (user.emailVerified) {
        setState(() {
          isEmailVerified = true;
          isLoading = false;
        });
        debugPrint("Verified");
        break;
      }
    }
  }

  double baseFontSize(double size, double screenWidth) => size * (screenWidth / 1440);
  double basePadding(double size, double screenWidth) => size * (screenWidth / 1440);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/Background.png", fit: BoxFit.cover),
          ),
          Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: screenHeight),
                child: IntrinsicHeight(
                  child: Flex(
                    direction: isMobile ? Axis.vertical : Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: !isMobile,
                        child: Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(basePadding(40, screenWidth)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bully Alert',
                                  style: TextStyle(
                                    fontSize: baseFontSize(48, screenWidth),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: basePadding(10, screenWidth)),
                                Text(
                                  'An Aditya Birla World Academy initiative',
                                  style: TextStyle(
                                    fontSize: baseFontSize(24, screenWidth),
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Container(
                            width: isMobile ? screenWidth * 0.9 : screenWidth * 0.3,
                            padding: EdgeInsets.all(basePadding(30, screenWidth)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Verify',
                                  style: TextStyle(
                                    fontSize: baseFontSize(24, screenWidth),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "An email has been sent to your address to verify your account.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14, color: Colors.black54),
                                ),
                                const SizedBox(height: 20),
                                if (isLoading)
                                  const CircularProgressIndicator(
                                    color: Colors.orange,
                                  )
                                else if (isEmailVerified)
                                  const Text(
                                    "Email Verified!",
                                    style: TextStyle(color: Colors.green, fontSize: 18),
                                  ),
                                const SizedBox(height: 20),
                                if (!isEmailVerified)
                                  ElevatedButton(
                                    onPressed: sendVerificationEmail,
                                    child: const Text("Resend Email", style: TextStyle(color: Colors.black),),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
