import 'package:flutter/material.dart';
import 'homepage.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  const LoginDemo({Key? key});

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  String? value;
  String errorMessage = '';

  bool isProductKeyValid(String? value) {
    if (value == null || value.isEmpty) {
      return true; // CHANGE TO FALSE
    }

    const pattern = r'^[A-Z0-9]{3}-[A-Z0-9]{3}-[A-Z0-9]{3}-[A-Z0-9]{3}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(value);
  }

  void validateProductKey(String? value) {
    if (!isProductKeyValid(value)) {
      setState(() {
        errorMessage = 'Please enter a valid product key.';
      });
    } else {
      setState(() {
        errorMessage = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Login Page",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 180.0),
              child: Center(
                child: Container(
                    width: 130,
                    height: 150,
                    child: Image.asset('images/LOGO.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                onChanged: (newValue) {
                  setState(() {
                    value = newValue;
                  });
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Enter Product Key',
                  hintText: 'Enter valid key as XXX-XXX-XXX-XXX',
                  errorText: errorMessage.isNotEmpty ? errorMessage : null,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  validateProductKey(value);
                  if (isProductKeyValid(value)) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MyHomePage(
                          title: 'Home Page',
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
