import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../domain/users.dart';

class UserFunctionalities {
  UserFunctionalities._();
  static final UserFunctionalities _instance = UserFunctionalities._();
  factory UserFunctionalities() => _instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  final Reference _storageReference = FirebaseStorage.instance.ref();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> createAccount(Users user) async {
    try {
      // Create the user account
      await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password!,
      );

      // Upload user image to Firestore
      String imageFileName = 'user_images/${user.userName}.jpg';
      await _storageReference
          .child(imageFileName)
          .putFile(File(user.userImage));

      // Get the download URL of the image
      String imageUrl =
          await _storageReference.child(imageFileName).getDownloadURL();

      // Save user data in the Realtime Database with the image URL
      await _database.child('users/${user.userName}').set({
        'userName': user.userName,
        'fullName': user.fullName,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'userDateOfBirth': user.userDateOfBirth,
        'userImage': imageUrl, // Store the image URL
      });

      await _database
          .child('users/usernames')
          .update({'${user.userName}': " "});

      await _firestore.collection('users').doc(user.email).set({
        'userName': user.userName,
        'fullName': user.fullName,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'userDateOfBirth': user.userDateOfBirth,
        'userImage': imageUrl, // Store the image URL
      });

      bool _sentVerificationLink = await sendEmailVerification();
      if (_sentVerificationLink == false) {
        return null;
      }
      return _auth.currentUser;
    } catch (e) {
      print("Error creating account: $e");
      return null;
    }
  }

  Future<bool> updateProfile(
      {required Users user, required bool imageChanged}) async {
    try {
      // Upload user image to Firestore
      String imageUrl = user.userImage;
      if (imageChanged) {
        String imageFileName = 'user_images/${user.userName}.jpg';
        await _storageReference
            .child(imageFileName)
            .putFile(File(user.userImage));

        // Get the download URL of the image
        imageUrl =
            await _storageReference.child(imageFileName).getDownloadURL();
      }

      // Save user data in the Realtime Database with the image URL
      await _database.child('users/${user.userName}').update({
        'userName': user.userName,
        'fullName': user.fullName,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
        'userDateOfBirth': user.userDateOfBirth,
        'userImage': imageUrl, // Store the image URL
      });

      await _database
          .child('users/usernames')
          .update({'${user.userName}': " "});

      try {
        await _firestore.collection('users').doc(user.email).update({
          'userName': user.userName,
          'fullName': user.fullName,
          'email': user.email,
          'phoneNumber': user.phoneNumber,
          'userDateOfBirth': user.userDateOfBirth,
          'userImage': imageUrl,
        });
        print('Document updated successfully');
      } catch (error) {
        print('Error updating document:${error}');
      }
      return true;
    } catch (e) {
      print("Error creating account: $e");
      return false;
    }
  }

  Future<int> userValid(
      {required String email, required String password}) async {
    int a = -1;
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      a = 1;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        a = 2;
      } else if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        a = 3;
      }
    }
    print(a);
    return a;
  }

  Future<List<String>> getAllUserNames() async {
    List<String> temp = [];
    await _database.child("users/UserNames").get().then((dataSnapshot) => {
          for (final snapshot in dataSnapshot.children)
            {
              temp.add(snapshot.key.toString()),
            }
        });
    return temp;
  }

  Future<bool> sendEmailVerification() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.sendEmailVerification();
      return true;
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }
}
