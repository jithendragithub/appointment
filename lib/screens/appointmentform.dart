// import 'dart:ui';
//
// import 'package:appointment/screens/patientlist.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class AppointmentForm extends StatefulWidget {
//   const AppointmentForm({Key? key}) : super(key: key);
//
//   @override
//   _AppointmentFormState createState() => _AppointmentFormState();
// }
//
// class _AppointmentFormState extends State<AppointmentForm> {
//   // Controllers for TextFormFields
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _phoneController = TextEditingController();
//   TextEditingController _dateController = TextEditingController();
//   TextEditingController _timeController = TextEditingController();
//   TextEditingController _reasonController = TextEditingController();
//   TextEditingController _otherDiseaseController = TextEditingController();
//   String? _selectedDisease;
//   String? _selectedGender;
//
//   final List<String> diseaseList = [
//     'Fever',
//     'Common Cold',
//     'Headache',
//     'Stomachache',
//     'Others',
//   ];
//   final List<String> genderList = ['Male', 'Female', 'Other'];
//
//   List<Map<String, dynamic>> patientDetails = [];
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != DateTime.now()) {
//       _dateController.text = picked.toLocal().toString().split(' ')[0];
//     }
//   }
//
//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null) {
//       _timeController.text = picked.format(context);
//     }
//   }
//
//   void _addPatientDetails() {
//     Map<String, dynamic> patientData = {
//       'Name': _nameController.text,
//       'Phone Number': _phoneController.text,
//       'Selected Gender': _selectedGender,
//       'Date': _dateController.text,
//       'Time': _timeController.text,
//       'Selected Disease': _selectedDisease,
//       'Other Disease': _otherDiseaseController.text,
//       'Reason': _reasonController.text,
//     };
//
//     setState(() {
//       patientDetails.add(patientData);
//       // Clear the form fields for the next patient
//       _nameController.clear();
//       _phoneController.clear();
//       _dateController.clear();
//       _timeController.clear();
//       _reasonController.clear();
//       _otherDiseaseController.clear();
//       _selectedDisease = null;
//       _selectedGender = null;
//     });
//   }
//
//   void _navigateToPatientDetails() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) =>
//             PatientDetailsPage(patientDetails: patientDetails),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(100.0),
//         child: AppBar(
//           centerTitle: true,
//           title: Column(
//             children: [
//               SizedBox(height: 20), // Adjust the height as needed
//               Text(
//                 'Appointment Form',
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           backgroundColor: Colors.greenAccent,
//         ),
//       ),
//       body:
//       Container(
//         height: MediaQuery.of(context).size.height,
//         child: SingleChildScrollView(
//           child: Stack(
//           children: [
//             Stack(
//               children: [
//                /* Image.asset(
//                   'assets/images/doctorimg.jpeg', // Replace with your image asset
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: double.infinity,
//                 ),*/
//                 BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
//                   child: Container(
//                     color: Colors.black.withOpacity(0.1),
//                     width: double.infinity,
//                     //height: double.infinity,
//                     child: Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             controller: _nameController,
//                             decoration:
//                             InputDecoration(labelText: 'PatientName'),
//                           ),
//                           TextFormField(
//                             controller: _phoneController,
//                             decoration:
//                             InputDecoration(labelText: 'Phonenumber'),
//                             keyboardType: TextInputType.phone,
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly,
//                             ],
//                           ),
//                           DropdownButtonFormField<String>(
//                             value: _selectedGender,
//                             onChanged: (value) {
//                               setState(() {
//                                 _selectedGender = value;
//                               });
//                             },
//                             items: genderList.map((gender) {
//                               return DropdownMenuItem<String>(
//                                 value: gender,
//                                 child: Text(gender),
//                               );
//                             }).toList(),
//                             decoration:
//                             InputDecoration(labelText: 'Gender'),
//                           ),
//                           InkWell(
//                             onTap: () => _selectDate(context),
//                             child: IgnorePointer(
//                               child: TextFormField(
//                                 controller: _dateController,
//                                 decoration:
//                                 InputDecoration(labelText: 'Date'),
//                               ),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () => _selectTime(context),
//                             child: IgnorePointer(
//                               child: TextFormField(
//                                 controller: _timeController,
//                                 decoration:
//                                 InputDecoration(labelText: 'Time'),
//                               ),
//                             ),
//                           ),
//                           DropdownButtonFormField<String>(
//                             value: _selectedDisease,
//                             onChanged: (value) {
//                               setState(() {
//                                 _selectedDisease = value;
//                               });
//                             },
//                             items: diseaseList.map((disease) {
//                               return DropdownMenuItem<String>(
//                                 value: disease,
//                                 child: Text(disease),
//                               );
//                             }).toList(),
//                             decoration: InputDecoration(
//                               labelText: 'Select appointment type(s)',
//                             ),
//                           ),
//                           if (_selectedDisease == 'Others')
//                             TextFormField(
//                               controller: _otherDiseaseController,
//                               decoration:
//                               InputDecoration(labelText: 'Others'),
//                             ),
//                           TextFormField(
//                             controller: _reasonController,
//                             decoration: InputDecoration(
//                                 labelText: 'Reason for Appointment'),
//                             maxLines: 3,
//                           ),
//                           SizedBox(height: 50.0),
//                           ElevatedButton(
//                             onPressed: () {
//                               _addPatientDetails();
//                               _navigateToPatientDetails();
//                             },
//                             style: ElevatedButton.styleFrom(
//                               minimumSize: Size(double.infinity, 50),
//                               primary: Colors.greenAccent,
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20)),
//                             ),
//                             child: Text(
//                               'Submit',
//                               style: TextStyle(fontSize: 20),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // Display Patient Details using ListView.builde
//           ],
//         ),
//       ),
//     ));
//   }
// }
