import 'package:appointment/screens/patient.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/your_image.png', // Replace with the actual path to your image
                width: 200, // Adjust the width as needed
                height: 200, // Adjust the height as needed
                fit: BoxFit.contain, // Adjust the BoxFit as needed
              ),
              SizedBox(height: 20), // Optional: Add some space between the image and other widgets
              AppointmentForm(),
            ],
          ),
        ),
      ),
    );
  }
}
