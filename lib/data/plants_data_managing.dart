import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plant/domain/add_sell_post_data.dart';

class PlantsDataManagement {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  final Reference _storageReference = FirebaseStorage.instance.ref();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> uploadPlantSellPost(SellPostsData addSellPost) async {
    bool firebaseOk = false;
    bool firestoreOk = false;

    String imageFileName = 'plant_images/${addSellPost.plantID}.jpg';
    await _storageReference
        .child(imageFileName)
        .putFile(File(addSellPost.plantImage));

    // Get the download URL of the image
    String imageUrl =
        await _storageReference.child(imageFileName).getDownloadURL();

    try {
      await _database.child('plants/${addSellPost.plantID}').set({
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
          .set({
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
          .child('plants/plantsIds')
          .update({'${addSellPost.plantID}': " "});
      firebaseOk = true;
    } on FirebaseException catch (e) {
      firebaseOk = false;
    }

    try {
      await _firestore.collection('plants').doc(addSellPost.plantID).set({
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
      firestoreOk = true;
    } on FirebaseException catch (e) {
      firestoreOk = false;
    }
    if (firestoreOk && firebaseOk) {
      return true;
    }
    return false;
  }

  Future<List<SellPostsData>> getPlantsInfo() async {
    List<SellPostsData> tempList = [];
    var lst = await getPlantsIdList();
    for (int i = 0; i < lst.length; i++) {
      final userDoc = await _firestore.collection('plants').doc(lst[i]).get();
      if (userDoc.exists) {
        final addSellPost = userDoc.data() as Map<String, dynamic>;
        SellPostsData sellPostsData = SellPostsData(
            plantID: addSellPost['plantID'],
            plantImage: addSellPost['plantImage'],
            plantName: addSellPost['plantName'],
            price: addSellPost['price'],
            note: addSellPost['note'],
            division: addSellPost['division'], // Store the image URL
            district: addSellPost['district'], // Store the image URL
            upzilla: addSellPost['upzilla'],
            sellerName: addSellPost['sellerName'],
            date: addSellPost['date'],
            totalPlants: addSellPost['totalPlants'],
            soldPlants: addSellPost['soldPlants'],
            location: addSellPost['location'],
            sellerID: addSellPost['sellerID']);
        tempList.add(sellPostsData);
      }
    }
    return tempList;
  }

  Future<List<String>> getPlantsIdList() async {
    List<String> temp = [];
    await _database.child("plants/plantsIds").get().then((dataSnapshot) => {
          for (final snapshot in dataSnapshot.children)
            {
              temp.add(snapshot.key.toString()),
            }
        });
    return temp;
  }
}
