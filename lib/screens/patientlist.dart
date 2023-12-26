// import 'dart:ui';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class PatientDetailsPage extends StatelessWidget {
//   final List<Map<String, dynamic>> patientDetails;
//
//   PatientDetailsPage({required this.patientDetails});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Patient Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Patient Details:',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             // Display each patient's details
//             for (int i = 0; i < patientDetails.length; i++)
//               _buildPatientDetailsContainer(i),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPatientDetailsContainer(int index) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       margin: EdgeInsets.only(bottom: 16.0),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Patient ${index + 1} Details:',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 8.0),
//           // Display each field of patient details
//           for (var entry in patientDetails[index].entries)
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   entry.key,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 4.0),
//                 Text(
//                   entry.value.toString(),
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           SizedBox(height: 16.0),
//         ],
//       ),
//     );
//   }
// }