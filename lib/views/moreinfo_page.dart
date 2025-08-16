import 'package:bully_alert/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoreinfoPage extends StatefulWidget {
  MoreinfoPage({super.key});

  @override
  State<MoreinfoPage> createState() => _MoreinfoPageState();
}

class _MoreinfoPageState extends State<MoreinfoPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController parentname = TextEditingController();
  final TextEditingController phoneno = TextEditingController();
  String? selectedGrade;

  final List<String> grades = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'];
  late Future<void> _firebaseInit;

  @override
  void initState() {
    super.initState();
    _firebaseInit = Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;

    double baseFontSize(double size) => size * (screenWidth / 1440);
    double basePadding(double size) => size * (screenWidth / 1440);

    return FutureBuilder(
      future: _firebaseInit,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold();
        }

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
                          if (!isMobile)
                            Expanded(
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
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Container(
                                width: isMobile ? screenWidth * 0.9 : screenWidth * 0.3,
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
                                    Text(
                                      'Tell us more',
                                      style: TextStyle(
                                        fontSize: baseFontSize(24),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: basePadding(20)),
                                    TextField(
                                      controller: name,
                                      style: TextStyle(fontSize: baseFontSize(16)),
                                      decoration: InputDecoration(
                                        labelText: 'Name',
                                        labelStyle: TextStyle(fontSize: baseFontSize(14)),
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: basePadding(20)),
                                    GradeDropdown(
                                      grades: grades,
                                      selectedGrade: selectedGrade,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGrade = value;
                                        });
                                      },
                                      baseFontSize: baseFontSize,
                                    ),
                                    SizedBox(height: basePadding(20)),
                                    TextField(
                                      controller: parentname,
                                      style: TextStyle(fontSize: baseFontSize(16)),
                                      decoration: InputDecoration(
                                        labelText: 'Parent\'s Name',
                                        labelStyle: TextStyle(fontSize: baseFontSize(14)),
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: basePadding(20)),
                                    TextField(
                                      controller: phoneno,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                      style: TextStyle(fontSize: baseFontSize(16)),
                                      decoration: InputDecoration(
                                        labelText: 'Parent\'s Phone Number',
                                        labelStyle: TextStyle(fontSize: baseFontSize(14)),
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: basePadding(20)),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (name.text.isEmpty || selectedGrade == null || parentname.text.isEmpty || phoneno.text.isEmpty) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('All fields are required to be filled.'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                            return;
                                          }
                                          final user = FirebaseAuth.instance.currentUser;
                                          try {
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(user?.email)
                                                .set({
                                              'email': user?.email,
                                              'name': name.text,
                                              'grade': selectedGrade,
                                              'parentname': parentname.text,
                                              'phone': phoneno.text,
                                            });
                                            Navigator.pushNamed(context, '/Authentication');
                                          } catch (e) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text("Error: $e")),
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.yellow[700],
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          padding: EdgeInsets.symmetric(vertical: basePadding(18)),
                                          elevation: 0,
                                        ),
                                        child: Text(
                                          'Continue',
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
      },
    );
  }
}

class GradeDropdown extends StatefulWidget {
  final List<String> grades;
  final String? selectedGrade;
  final ValueChanged<String?> onChanged;
  final double Function(double) baseFontSize;

  const GradeDropdown({
    required this.grades,
    required this.selectedGrade,
    required this.onChanged,
    required this.baseFontSize,
    super.key,
  });

  @override
  State<GradeDropdown> createState() => _GradeDropdownState();
}

class _GradeDropdownState extends State<GradeDropdown> {
  String? localSelectedGrade;

  @override
  void initState() {
    super.initState();
    localSelectedGrade = widget.selectedGrade;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: localSelectedGrade,
      decoration: InputDecoration(
        labelText: 'Grade',
        labelStyle: TextStyle(fontSize: widget.baseFontSize(14)),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      items: widget.grades
          .map((grade) => DropdownMenuItem(
                value: grade,
                child: Text(grade),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          localSelectedGrade = value;
        });
        widget.onChanged(value);
      },
    );
  }
}

