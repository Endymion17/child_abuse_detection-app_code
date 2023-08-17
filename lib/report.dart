import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'homepage.dart';

class ReportActivityPage extends StatefulWidget {
  @override
  _ReportActivityPageState createState() => _ReportActivityPageState();
}

class _ReportActivityPageState extends State<ReportActivityPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final CollectionReference _reportCollection = FirebaseFirestore.instance.collection('reports');

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform submission to Firestore
      String name = _nameController.text;
      String date = _dateController.text;
      String location = _locationController.text;
      String description = _descriptionController.text;

      // Store the report in Firestore
      _reportCollection.add({
        'name': name,
        'date': date,
        'location': location,
        'description': description,
      });

      // Clear form fields after submission
      _nameController.clear();
      _dateController.clear();
      _locationController.clear();
      _descriptionController.clear();

      // Show a Thank you message or perform any desired action
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thank you!'),
            content: const Text(
                'Thank you for your submission! We will make sure that your data will be handled securely and used solely for the purpose of improving our system. Thank you again for your trust and support.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MyHomePage(
                        title: 'Home Page',
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report", style: GoogleFonts.questrial(fontSize: 28)),
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
                    return const MyHomePage(
                      title: "Home Page",
                    );
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(-1.0, 0.0);
                    const Offset end = Offset.zero;
                    const curve = Curves.ease;

                    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                maxLines: 1,
                decoration: const InputDecoration(
                  labelText: 'Describe the activity',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please describe the activity';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit',style:TextStyle(fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
