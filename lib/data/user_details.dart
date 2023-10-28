import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/users.dart';

class UserDataProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Users? _userData;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<Users?> getUserData() async {
    final userEmail = await getUserEmail();
    if (userEmail != null) {
      final userDoc = await _firestore.collection('users').doc(userEmail).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        _userData = Users(
          userName: userData['userName'],
          fullName: userData['fullName'],
          email: userData['email'],
          phoneNumber: userData['phoneNumber'],
          userDateOfBirth: userData['userDateOfBirth'],
          userImage: userData['userImage'],
        );
        return _userData;
      }
    }
    return null;
  }

  Future<String?> getUserEmail() async {
    final user = _auth.currentUser;
    return user?.email;
  }

// You can add methods to update user data here.
}
