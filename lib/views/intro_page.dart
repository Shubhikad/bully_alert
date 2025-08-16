import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isSignUp = true;
  bool obscurePassword = true;

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
                            padding: EdgeInsets.all(basePadding(40)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bully Alert',
                                  style: TextStyle(
                                    fontSize: baseFontSize(48),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: basePadding(10)),
                                Text(
                                  'An Aditya Birla World Academy initiative',
                                  style: TextStyle(
                                    fontSize: baseFontSize(24),
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
                            width:
                                isMobile
                                    ? screenWidth * 0.9
                                    : screenWidth * 0.3,
                            padding: EdgeInsets.all(basePadding(30)),
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
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                          decoration: BoxDecoration(
                                            color:
                                                isSignUp
                                                    ? Colors.orange[400]
                                                    : Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() => isSignUp = true);
                                            },
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                vertical: basePadding(15),
                                              ),
                                            ),
                                            child: AnimatedDefaultTextStyle(
                                              duration: Duration(
                                                milliseconds: 300,
                                              ),
                                              curve: Curves.easeInOut,
                                              style: TextStyle(
                                                color:
                                                    isSignUp
                                                        ? Colors.white
                                                        : Colors.black54,
                                                fontSize: baseFontSize(16),
                                              ),
                                              child: Text('Sign Up'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeInOut,
                                          decoration: BoxDecoration(
                                            color:
                                                !isSignUp
                                                    ? Colors.orange[400]
                                                    : Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() => isSignUp = false);
                                            },
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                vertical: basePadding(15),
                                              ),
                                            ),
                                            child: AnimatedDefaultTextStyle(
                                              duration: Duration(
                                                milliseconds: 300,
                                              ),
                                              curve: Curves.easeInOut,
                                              style: TextStyle(
                                                color:
                                                    !isSignUp
                                                        ? Colors.white
                                                        : Colors.black54,
                                                fontSize: baseFontSize(16),
                                              ),
                                              child: Text('Log In'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: basePadding(30)),
                                Text(
                                  isSignUp
                                      ? 'Create an account'
                                      : 'Welcome back',
                                  style: TextStyle(
                                    fontSize: baseFontSize(24),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: basePadding(20)),
                                SizedBox(
                                  width: double.infinity,
                                  child: OutlinedButton.icon(
                                    onPressed: () async {
                                      try {
                                        GoogleAuthProvider googleProvider =
                                            GoogleAuthProvider();
                                        final FirebaseAuth _auth =
                                            FirebaseAuth.instance;

                                        // Sign in on the web
                                        await _auth.signInWithPopup(googleProvider);

                                        if (FirebaseAuth.instance.currentUser !=
                                            null) {
                                          Navigator.pushNamed(
                                            context,
                                            '/Authentication',
                                          );
                                        }

                                        Navigator.pushNamed(
                                          context,
                                          '/Authentication',
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(content: Text("Error: $e")),
                                        );
                                      }
                                    },
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      side: BorderSide(
                                        color: Colors.grey[300]!,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: basePadding(10),
                                      ),
                                    ),
                                    label: Padding(
                                      padding: EdgeInsets.all(basePadding(8)),
                                      child: Text(
                                        isSignUp
                                            ? 'Sign Up using Google'
                                            : 'Sign In using Google',
                                        style: TextStyle(
                                          fontSize: baseFontSize(16),
                                        ),
                                      ),
                                    ),
                                    icon: Padding(
                                      padding: EdgeInsets.all(basePadding(8)),
                                      child: SizedBox(
                                        width: baseFontSize(30),
                                        height: baseFontSize(30),
                                        child: Image.asset('assets/Google.png'),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: basePadding(20)),
                                Row(
                                  children: [
                                    const Expanded(child: Divider()),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: basePadding(10),
                                      ),
                                      child: Text(
                                        'or use email',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: baseFontSize(14),
                                        ),
                                      ),
                                    ),
                                    const Expanded(child: Divider()),
                                  ],
                                ),
                                SizedBox(height: basePadding(20)),
                                TextField(
                                  controller: emailController,
                                  style: TextStyle(fontSize: baseFontSize(16)),
                                  decoration: InputDecoration(
                                    labelText: 'email',
                                    labelStyle: TextStyle(
                                      fontSize: baseFontSize(14),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: basePadding(15)),
                                TextField(
                                  controller: passwordController,
                                  obscureText: obscurePassword,
                                  style: TextStyle(fontSize: baseFontSize(16)),
                                  decoration: InputDecoration(
                                    labelText: 'password',
                                    labelStyle: TextStyle(
                                      fontSize: baseFontSize(14),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(
                                          () =>
                                              obscurePassword =
                                                  !obscurePassword,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                if (!isSignUp) ...[
                                  SizedBox(height: basePadding(10)),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        final email =
                                            emailController.text.trim();
                                        if (email.isEmpty) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Please enter your email address.',
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        try {
                                          FirebaseAuth.instance
                                              .sendPasswordResetEmail(
                                                email: email,
                                              );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Password reset email sent.',
                                              ),
                                            ),
                                          );
                                        } on FirebaseAuthException catch (e) {
                                          String errorMessage =
                                              'An error occurred. Please try again.';
                                          if (e.code == 'user-not-found') {
                                            errorMessage =
                                                'No account found for that email.';
                                          }
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(errorMessage),
                                            ),
                                          );
                                        }
                                      },
                                      child: Text(
                                        "Forgot password?",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: baseFontSize(14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                SizedBox(height: basePadding(30)),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (isSignUp) {
                                        if (emailController.text.isEmpty ||
                                            !RegExp(
                                              r'^[^@]+@[^@]+\.[^@]+',
                                            ).hasMatch(emailController.text)) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Please enter a valid email address.',
                                              ),
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                            ),
                                          );

                                          return;
                                        }
                                        if (passwordController.text.length <
                                            6) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Password must be at least 6 characters long.',
                                              ),
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                            ),
                                          );
                                          return;
                                        }
                                        try {
                                          final userCredential =
                                              await FirebaseAuth.instance
                                                  .createUserWithEmailAndPassword(
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,
                                                  );
                                          Navigator.pushNamed(
                                            context,
                                            '/Authentication',
                                          );
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == 'weak-password') {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'The password provided is too weak.',
                                                ),
                                                duration: const Duration(
                                                  seconds: 2,
                                                ),
                                              ),
                                            );
                                          } else if (e.code ==
                                              'email-already-in-use') {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'The account already exists for that email.',
                                                ),
                                                duration: const Duration(
                                                  seconds: 2,
                                                ),
                                              ),
                                            );
                                          } else if (e.code ==
                                              'invalid-email') {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'The email address is not valid.',
                                                ),
                                                duration: const Duration(
                                                  seconds: 2,
                                                ),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Registration failed: ${e.message}',
                                                ),
                                                duration: const Duration(
                                                  seconds: 2,
                                                ),
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'An unexpected error occurred: $e',
                                              ),
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                            ),
                                          );
                                        }
                                      } else {
                                        try {
                                          await FirebaseAuth.instance
                                              .signInWithEmailAndPassword(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                              );
                                          // If login is successful, navigate to HomePage
                                          if (mounted) {
                                            // Check if the widget is still in the tree
                                            Navigator.pushNamed(
                                              context,
                                              '/Authentication',
                                            );
                                          }
                                        } on FirebaseAuthException catch (e) {
                                          String errorMessage =
                                              'Please check email or password.';
                                          if (e.code == 'user-not-found' ||
                                              e.code == 'wrong-password' ||
                                              e.code == 'invalid-email') {
                                            errorMessage =
                                                'Incorrect email or password.';
                                          } else if (e.code ==
                                              'user-disabled') {
                                            errorMessage =
                                                'This user has been disabled.';
                                          } else if (e.code ==
                                              'too-many-requests') {
                                            errorMessage =
                                                'Too many login attempts. Please try again later.';
                                          }

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(errorMessage),
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                            ),
                                          );
                                        } catch (e) {
                                          // Catch any other unexpected errors
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'An unexpected error occurred: ${e.toString()}',
                                              ),
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                            ),
                                          );
                                          ;
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.yellow[700],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: basePadding(18),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Text(
                                      isSignUp ? 'Continue' : 'Log In',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: baseFontSize(18),
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
