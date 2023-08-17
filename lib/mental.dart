import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homepage.dart';
class Mental extends StatelessWidget {
  const Mental({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Mentalpage(),
    );
  }
}

class Mentalpage extends StatefulWidget {
  const Mentalpage({Key? key}) : super(key: key);

  @override
  _MentalpageState createState() => _MentalpageState();
}

class _MentalpageState extends State<Mentalpage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Mental Health Details", style: GoogleFonts.questrial(fontSize: 28)),
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'Latest Report :\n\n',
                          style: GoogleFonts.questrial(
                            fontSize: size.height * 0.045,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                          children: [
                            TextSpan(
                              text: 'The mental condition of your child is good. You have nothing to worry about.',
                              style: GoogleFonts.questrial(
                                fontSize: size.height * 0.030,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                            )
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Image.asset(
                      'images/9.png',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.black),
                const SizedBox(height: 16),
                 Text(
                  'Report Date: June 3, 2023',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                 Text(
                  'Report Score: 8.5',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.black),
                const SizedBox(height: 16),
                 Text(
                  'Previous Reports :',
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: const Icon(Icons.attachment),
                  title: const Text('File 1'),
                  subtitle: const Text('June 1, 2023'),
                  onTap: () {
                    // Add your logic for file tapping here
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.attachment),
                  title: const Text('File 2'),
                  subtitle: const Text('May 30, 2023'),
                  onTap: () {
                    // Add your logic for file tapping here
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.attachment),
                  title: const Text('File 3'),
                  subtitle: const Text('May 28, 2023'),
                  onTap: () {
                    // Add your logic for file tapping here
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
