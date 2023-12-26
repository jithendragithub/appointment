import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/firebase_service.dart';

class AppointmentForm extends StatefulWidget {
  const AppointmentForm({Key? key}) : super(key: key);

  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _otherDiseaseController = TextEditingController();
  TextEditingController _otherLocationController = TextEditingController();
  TextEditingController _dateController = TextEditingController(); // Add this line
  TextEditingController _timeController = TextEditingController(); // Add this line
  String? _selectedDisease;
  String? _selectedGender;
  String? _selectedLocation;
  final FirebaseService _firebaseService = FirebaseService();
  final List<String> diseaseList = [
    'Fever',
    'Common Cold',
    'Headache',
    'Stomachache',
    'Others',
  ];
  final List<String> genderList = ['Male', 'Female', 'Other'];
  final List<String> locationList = ['Bangalore', 'chittoor', 'Hyderabad', 'Other'];


  int _patientCounter = 0;


  Future<void> _submitForm() async {
    // Increment the patient counter
    _patientCounter++;

    // Store the numeric part of the patient ID
    int patientId = _patientCounter;

    await _firebaseService.addAppointment(
      patientId: patientId, // Pass patient ID to the service
      name: _nameController.text,
      phoneNumber: _phoneController.text,
      gender: _selectedGender ?? '',
      age:_ageController.text,
      location:  _selectedLocation?? '',
      otherlocation: _otherLocationController.text,
      disease: _selectedDisease ?? '',
      otherDisease: _otherDiseaseController.text,
    );

    // Show a success dialog with patient ID
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Appointment submitted successfully!'),
              SizedBox(height: 8),
              Text('Your Patient ID: $patientId'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog

                // Clear text fields
                _nameController.clear();
                _phoneController.clear();
                _ageController.clear();
                _otherDiseaseController.clear();
                _otherLocationController.clear();
                _dateController.clear(); // Clear date controller
                _timeController.clear(); // Clear time controller

                // Optionally, reset dropdowns to initial values
                _selectedGender = null;
                _selectedDisease = null;


                // Force rebuild the widget tree
                setState(() {});
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [
              // Background Image (visible at the top half)
              Container(
                 decoration: BoxDecoration(
                 image:DecorationImage(
                    image:AssetImage(
                    'assets/images/doctorimg.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              // Blurred Container (covers the rest of the screen)
              Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 180.0),
                        // Your Card Widget
                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                AppBar(
                                  centerTitle: true,
                                  title: Text('Appointment Form'),
                                  backgroundColor: Colors.blueAccent,
                                  elevation: 0,
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(labelText: 'Patient Name'),
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _phoneController,
                                  decoration: InputDecoration(labelText: 'Phone number'),
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                DropdownButtonFormField<String>(
                                  value: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value;
                                    });
                                  },
                                  items: genderList.map((gender) {
                                    return DropdownMenuItem<String>(
                                      value: gender,
                                      child: Text(gender),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(labelText: 'Select Gender'),
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _ageController,
                                  decoration: InputDecoration(labelText:'Age'),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                DropdownButtonFormField<String>(
                                  value: _selectedLocation,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedLocation = value;
                                    });
                                  },
                                  items: locationList.map((location) {
                                    return DropdownMenuItem<String>(
                                      value: location,
                                      child: Text(location),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    labelText: 'Select Location',
                                  ),
                                ),
                                if (_selectedLocation == 'Others')
                                  TextFormField(
                                    controller: _otherLocationController,
                                    decoration: InputDecoration(labelText: 'Others'),
                                  ),
                                SizedBox(height: 20.0),
                                DropdownButtonFormField<String>(
                                  value: _selectedDisease,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedDisease = value;
                                    });
                                  },
                                  items: diseaseList.map((disease) {
                                    return DropdownMenuItem<String>(
                                      value: disease,
                                      child: Text(disease),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    labelText: 'Purpose of Visit',
                                  ),
                                ),
                                if (_selectedDisease == 'Others')
                                  TextFormField(
                                    controller: _otherDiseaseController,
                                    decoration: InputDecoration(labelText: 'Others'),
                                  ),
                                SizedBox(height: 30.0),
                                ElevatedButton(
                                  onPressed: () {
                                    _submitForm(); // Call the _submitForm method
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,

                                    minimumSize: Size(350, 40),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(fontSize: 20,color: Colors.white),
                                  ),
                                ),
                              ],
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
    );
    }
}