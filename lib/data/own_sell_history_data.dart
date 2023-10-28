import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plant/domain/add_sell_post_data.dart';

class OwnSellHistoryData {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  final Reference _storageReference = FirebaseStorage.instance.ref();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> updatePreviousSellPost(
      {required SellPostsData addSellPost, required bool uploadedImage}) async {
    String imageUrl = addSellPost.plantImage;
    if (uploadedImage) {
      String imageFileName = 'plant_images/${addSellPost.plantID}.jpg';
      await _storageReference
          .child(imageFileName)
          .putFile(File(addSellPost.plantImage));

      // Get the download URL of the image
      imageUrl = await _storageReference.child(imageFileName).getDownloadURL();
    }
    print(addSellPost.plantID);
    try {
      await _database.child('plants/${addSellPost.plantID}').update({
        'plantID': addSellPost.plantID,
        'plantImage': imageUrl,
        'plantName': addSellPost.plantName,
        'price': addSellPost.price,
        'note': addSellPost.note,
        'division': addSellPost.division, // Store the image URL
        'district': addSellPost.district, // Store the image URL
        'upzilla': addSellPost.upzilla,
        'sellerName': addSellPost.sellerName,
        'date': addSellPost.date,
        'totalPlants': addSellPost.totalPlants,
        'soldPlants': addSellPost.soldPlants,
        'location': addSellPost.location,
        'sellerID': addSellPost.sellerID, // Store the image URL
      });
      await _database
          .child('ownSellPosts/${addSellPost.sellerID}/${addSellPost.plantID}')
          .update({
        'plantID': addSellPost.plantID,
        'plantImage': imageUrl,
        'plantName': addSellPost.plantName,
        'price': addSellPost.price,
        'note': addSellPost.note,
        'division': addSellPost.division, // Store the image URL
        'district': addSellPost.district, // Store the image URL
        'upzilla': addSellPost.upzilla,
        'sellerName': addSellPost.sellerName,
        'date': addSellPost.date,
        'totalPlants': addSellPost.totalPlants,
        'soldPlants': addSellPost.soldPlants,
        'location': addSellPost.location,
        'sellerID': addSellPost.sellerID, // Store the image URL
      });
      await _firestore.collection('plants').doc(addSellPost.plantID).update({
        'plantID': addSellPost.plantID,
        'plantImage': imageUrl,
        'plantName': addSellPost.plantName,
        'price': addSellPost.price,
        'note': addSellPost.note,
        'division': addSellPost.division, // Store the image URL
        'district': addSellPost.district, // Store the image URL
        'upzilla': addSellPost.upzilla,
        'sellerName': addSellPost.sellerName,
        'date': addSellPost.date,
        'totalPlants': addSellPost.totalPlants,
        'soldPlants': addSellPost.soldPlants,
        'location': addSellPost.location,
        'sellerID': addSellPost.sellerID, // Store the image URL
      });
      return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }
}
