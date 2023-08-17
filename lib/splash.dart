import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context)=>const LoginDemo()));
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.lightBlueAccent,
              Colors.purpleAccent,
              Colors.pinkAccent,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 250, // Adjust the width as needed
                height: 250, // Adjust the height as needed
                child: const Image(
                  image: AssetImage("images/LOGO.png"),
              ),
              ),
              const SizedBox(height:30),
              Text(
                "The Guardians",
                style: GoogleFonts.montserrat(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}