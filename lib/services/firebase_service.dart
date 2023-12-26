import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart'; // Import the uuid package

// ...

class FirebaseService {
  final CollectionReference appointments =
  FirebaseFirestore.instance.collection('appointments');
  final Uuid uuid = Uuid(); // Create an instance of the uuid package

  Future<void> addAppointment({
    required String name,
    required String phoneNumber,
    required String gender,
    required String location,
    required String otherlocation,
    required String disease,
    required String otherDisease,
    required int patientId, required String age,
  }) async {
    try {
      String patientId = uuid.v4(); // Generate a unique patient_id
      Timestamp timestamp = Timestamp.now(); // Get the current timestamp

      await appointments.add({
        'patient_id': patientId,
        'name': name,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'timestamp': timestamp,
        'location':location,
        'location': otherlocation,
        // Replace date and time with timestamp
        'disease': disease,
        'otherDisease': otherDisease,
        'age': age,
      });

      // Successfully stored in Firebase
      print('Appointment added to Firebase');
    } catch (e) {
      // Failed to store in Firebase
      print('Failed to add appointment to Firebase: $e');
    }
   }
}