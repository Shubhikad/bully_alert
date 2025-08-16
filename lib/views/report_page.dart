import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 600;

    double baseFontSize(double size) => size * (screenWidth / 1440);

    InputDecoration _inputDecoration(String hintText) {
      return InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: baseFontSize(18)
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: baseFontSize(15),
          horizontal: baseFontSize(20),
        ),
      );
    }

    TextStyle _sectionTitleStyle() {
      return TextStyle(
        fontSize: baseFontSize(24),
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      );
    }

    ButtonStyle _formButtonStyle(bool isSelected) {
      return TextButton.styleFrom(
        backgroundColor: isSelected
            ? const Color.fromARGB(255, 237, 140, 53)
            : Colors.grey[200],
        foregroundColor: isSelected ? Colors.white : Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: EdgeInsets.symmetric(
          horizontal:baseFontSize(30),
          vertical: baseFontSize(30),
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
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
                      Container(
                        child: Image.asset("assets/Logo.png"),
                        width: isMobile ? screenWidth * 0.15 : screenWidth / 12,
                        height: isMobile ? screenWidth * 0.15 : screenWidth / 12,
                      ),
                      SizedBox(height: screenHeight / 25),
                      ...["Home", "Alert", "Form", "Info", "School"].map(
                        (label) => Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: label == "Form" ? Colors.white : Colors.transparent,
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (label == "Home") Navigator.pushNamed(context, '/Main');
                              if (label == "Alert") Navigator.pushNamed(context, '/Alert');
                              if (label == "Info") Navigator.pushNamed(context, '/Info');
                              if (label == "School") Navigator.pushNamed(context, '/School');
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
                                color: label == "Form" ? Colors.black : Colors.white,
                                fontSize: isMobile ? 14 : baseFontSize(20),
                              ),
                            ),
                          ),
                        ),
                      ).toList(),
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
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isMobile ? 20 : 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reporting Form',
                    style: TextStyle(
                      fontSize: baseFontSize(48),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: isMobile ? 10 : 15),
                  Text(
                    'Report any instances of bullying you have witnessed or faced yourself. Your responses are confidential.',
                    style: TextStyle(
                      fontSize: baseFontSize(20),
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: isMobile ? 30 : 60),
                  _buildWhereSection(isMobile, screenWidth, screenHeight, _sectionTitleStyle, _formButtonStyle, _inputDecoration),
                  SizedBox(height: isMobile ? 30 : 60),
                  _buildWhenSection(isMobile, _sectionTitleStyle, _inputDecoration, context),
                  SizedBox(height: isMobile ? 30 : 60),
                  _buildAdditionalQuestions(isMobile, _sectionTitleStyle, _inputDecoration),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhereSection(bool isMobile, double screenWidth, double screenHeight, TextStyle Function() _sectionTitleStyle, ButtonStyle Function(bool) _formButtonStyle, InputDecoration Function(String) _inputDecoration) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 15 : 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Where did the incident occur?', style: _sectionTitleStyle()),
          SizedBox(height: isMobile ? 15 : 25),
          Row(
            children: [
              TextButton(onPressed: () {}, style: _formButtonStyle(true), child: Text('Online')),
              SizedBox(width: isMobile ? 10 : 20),
              TextButton(onPressed: () {}, style: _formButtonStyle(false), child: Text('In person')),
            ],
          ),
          SizedBox(height: isMobile ? 20 : 30),
          Row(
            children: [
              InkWell(onTap: () {}, child: SizedBox(width: screenWidth / 15, height: screenHeight / 15, child: Image.asset('assets/snapchat_logo.png'))),
              SizedBox(width: isMobile ? 8 : 15),
              InkWell(onTap: () {}, child: SizedBox(width: screenWidth / 15, height: screenHeight / 15, child: Image.asset('assets/instagram_logo.png'))),
              SizedBox(width: isMobile ? 8 : 15),
              InkWell(onTap: () {}, child: SizedBox(width: screenWidth / 15, height: screenHeight / 15, child: Image.asset('assets/games_logo.png'))),
              SizedBox(width: isMobile ? 8 : 15),
              InkWell(onTap: () {}, child: SizedBox(width: screenWidth / 15, height: screenHeight / 15, child: Image.asset('assets/whatsapp_logo.png'))),
              SizedBox(width: isMobile ? 8 : 15),
              InkWell(onTap: () {}, child: SizedBox(width: screenWidth / 15, height: screenHeight / 15, child: Image.asset('assets/other_logo.png'))),
            ],
          ),
          SizedBox(height: isMobile ? 15 : 25),
          Row(
            children: [
              Expanded(child: TextFormField(decoration: _inputDecoration('other (name)'))),
              SizedBox(width: isMobile ? 10 : 20),
              Expanded(child: TextFormField(decoration: _inputDecoration(''))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWhenSection(bool isMobile, TextStyle Function() _sectionTitleStyle, InputDecoration Function(String) _inputDecoration, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 15 : 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('When did the incident occur?', style: _sectionTitleStyle()),
          SizedBox(height: isMobile ? 15 : 25),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  onTap: () async {
                    await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                  },
                  decoration: _inputDecoration('Select date'),
                ),
              ),
              SizedBox(width: isMobile ? 10 : 20),
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  onTap: () async {
                    await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                  },
                  decoration: _inputDecoration('Select time'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalQuestions(bool isMobile, TextStyle Function() _sectionTitleStyle, InputDecoration Function(String) _inputDecoration) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(isMobile ? 15 : 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Describe the incident in detail:', style: _sectionTitleStyle()),
              SizedBox(height: isMobile ? 15 : 25),
              TextFormField(
                maxLines: 5,
                decoration: _inputDecoration('Type your response here...'),
              ),
            ],
          ),
        ),
        SizedBox(height: isMobile ? 30 : 60),
        Container(
          padding: EdgeInsets.all(isMobile ? 15 : 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Who was involved?', style: _sectionTitleStyle()),
              SizedBox(height: isMobile ? 15 : 25),
              TextFormField(
                decoration: _inputDecoration('Names of Bullies'),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(isMobile ? 15 : 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Who was involved?', style: _sectionTitleStyle()),
              SizedBox(height: isMobile ? 15 : 25),
              TextFormField(
                decoration: _inputDecoration('Names of Victims'),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(isMobile ? 15 : 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Who was involved?', style: _sectionTitleStyle()),
              SizedBox(height: isMobile ? 15 : 25),
              TextFormField(
                decoration: _inputDecoration('Names of witnesses'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
