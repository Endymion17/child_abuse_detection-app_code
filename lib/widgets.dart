import 'package:flutter/material.dart';
import 'package:group_project/psytest.dart';
import 'flagged.dart';
import 'homepage.dart';
import 'login.dart';
import 'package:google_fonts/google_fonts.dart';

import 'report.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 200,
        child: ListView(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.home_filled,color: Colors.black,size: 30,),
                title:  Text('Home',style: GoogleFonts.poppins(color: Colors.black,fontSize: 25),),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MyHomePage(title: 'Home Page')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.border_color,color: Colors.black,size: 30,),
                title:  Text('Psych Test',style: GoogleFonts.poppins(color: Colors.black,fontSize: 25),),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context)=>const PsychologyTestPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.flag,color: Colors.black,size: 30,),
                title:  Text('Flagged',style: GoogleFonts.poppins(color: Colors.black,fontSize: 25),),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context)=>FlaggedEventsPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.feedback,color: Colors.black,size: 30,),
                title:  Text('Report',style: GoogleFonts.poppins(color: Colors.black,fontSize: 25),),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context)=>ReportActivityPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app,color: Colors.black,size: 30,),
                title:  Text('Logout',style: GoogleFonts.poppins(color: Colors.black,fontSize: 25),),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginDemo()),
                  );
                },
              ),
            ],
          ),
      ),
    );
  }
}
