import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'body.dart';
import 'flagged.dart';
import 'report.dart';
import 'widgets.dart';
import 'mental.dart';
import 'package:google_fonts/google_fonts.dart';
import 'psytest.dart';
import 'feedback.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const SizedBox(
        width: 250,
        child: NavDrawer(),
      ),
      appBar: AppBar(
        title:Text("Home Page",style: GoogleFonts.questrial(fontSize: 28)),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const MyHomePage(title: "Home Page",);
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(-1.0, 0.0);
                    const Offset end = Offset.zero;
                    const curve = Curves.ease;

                    final tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                'images/LOGO.png',
                width: 34,
                height: 34,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.center,
              child:  RichText(
                  text: TextSpan(
                    text: 'Welcome to ',
                    style: GoogleFonts.questrial(
                        fontSize: size.height * 0.025,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                    ),
                    children: [
                      WidgetSpan(
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: [
                                Colors.blue,
                                Colors.purple,
                                Colors.pink,
                              ],
                            ).createShader(bounds);
                          },
                          child: Text(
                            'The Guardians',
                            style: GoogleFonts.questrial(
                              fontSize: size.height * 0.030,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      TextSpan(
                        text: ' where\n you can make sure your child is safe.',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.025,// Change the color of 'good' here
                        ),
                      ),
                    ],
                  )
              ),
            ),
            ),
            Container(
              width: 420,
              height: 174,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                        child: Image.asset(
                          'images/mental.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return const Mentalpage();
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const Offset begin = Offset(1.0, 0.0);
                            const Offset end = Offset.zero;
                            const curve = Curves.ease;

                            final tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 500),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                        backgroundColor: Colors.transparent
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.02,
                            left: size.width * 0.03,
                            bottom: size.height * 0.02,
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return const Mentalpage();
                                  },
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    const Offset begin = Offset(1.0, 0.0);
                                    const Offset end = Offset.zero;
                                    const curve = Curves.ease;

                                    final tween = Tween(begin: begin, end: end)
                                        .chain(CurveTween(curve: curve));

                                    return SlideTransition(
                                      position: animation.drive(tween),
                                      child: child,
                                    );
                                  },
                                  transitionDuration: const Duration(milliseconds: 500),
                                ),
                              );// Add your logic for the text's onPressed callback here
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'The mental condition \n',
                                style: GoogleFonts.questrial(
                                  fontSize: size.height * 0.035,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'of your child is: ',
                                  ),
                                  TextSpan(
                                    text: ' GOOD',
                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height * 0.045,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Divider(
                        color: Colors.white,
                        height: 1,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context)=>const PsychologyTestPage()));
                            // Add your logic for the button's onPressed callback here
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            backgroundColor: Colors.transparent
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Take Psychology Test',
                                style: GoogleFonts.questrial(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Container(
              width: 420,
              height: 174,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                      child: Image.asset(
                        "images/flag.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context)=>FlaggedEventsPage()));
                      // Add your logic for the button's onPressed callback here
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor: Colors.transparent, // Set the background color to transparent
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.02,
                            left: size.width * 0.03,
                            bottom: size.height * 0.02,
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context)=>FlaggedEventsPage()));
                              // Add your logic for the text's onPressed callback here
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Flagged cases : 1',
                                style: GoogleFonts.questrial(
                                  fontSize: size.height * 0.035,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Divider(
                        color: Colors.white,
                        height: 1,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context)=>FlaggedEventsPage()));
                            // Add your logic for the button's onPressed callback here
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Something\'s not right. \nLet\'s check to be safe.',
                                style: GoogleFonts.questrial(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Container(
              width: 420,
              height: 180,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                      child: Image.asset(
                        "images/sus.jpg",
                        fit: BoxFit.cover,
                       ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context)=>const FeedbackPage()));
                      // Add your logic for the button's onPressed callback here
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor: Colors.transparent, // Set the background color to transparent
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.02,
                            left: size.width * 0.03,
                            bottom: size.height * 0.02,
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context)=>const FeedbackPage()));
                              // Add your logic for the text's onPressed callback here
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Suspicious behaviour : 63%',
                                style: GoogleFonts.questrial(
                                  fontSize: size.height * 0.032,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Divider(
                        color: Colors.white,
                        height: 1,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context)=>const FeedbackPage()));
                            // Add your logic for the button's onPressed callback here
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Your child may be acting strange.\n                       Take action.',
                                style: GoogleFonts.questrial(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: 420,
              height: 180,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                      child: Image.asset(
                        "images/rep.jpg",
                        fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context)=>ReportActivityPage()));
                      // Add your logic for the button's onPressed callback here
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor: Colors.transparent, // Set the background color to transparent
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.145,
                            left: size.width * 0.03,
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context)=>ReportActivityPage()));
                              // Add your logic for the text's onPressed callback here
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Report unflagged activity.',
                                style: GoogleFonts.questrial(
                                  fontSize: size.height * 0.032,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            /*
            Container(
              width: 420,
              height: 180,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                        child: Image.asset(
                          "images/rep.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context)=>AnimationScreen()));
                      // Add your logic for the button's onPressed callback here
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      backgroundColor: Colors.transparent, // Set the background color to transparent
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.145,
                            left: size.width * 0.03,
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context)=>AnimationScreen()));
                              // Add your logic for the text's onPressed callback here
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Report unflagged activity.',
                                style: GoogleFonts.questrial(
                                  fontSize: size.height * 0.032,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
