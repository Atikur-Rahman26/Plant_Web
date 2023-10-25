import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plant/domain/post_details.dart';

class PostsDatabase {
  final DatabaseReference _firebaseDatabase =
      FirebaseDatabase.instance.reference();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final Reference _storageReference = FirebaseStorage.instance.ref();

  Future<bool> addPosts(PostInformation postInformation) async {
    try {
      late String imageUrl;
      if (postInformation.plantPhoto == "n") {
        imageUrl = "n";
      } else {
        try {
          String plantImageFileName =
              'post_images/${postInformation.postID}.jpg';
          print(plantImageFileName);
          await _storageReference
              .child(plantImageFileName)
              .putFile(File(postInformation.plantPhoto));
          print("uploaded");
          imageUrl = await _storageReference
              .child(plantImageFileName)
              .getDownloadURL();
          print("finished");
        } on FirebaseException catch (e) {
          print(e.message);
        }
      }

      await _firebaseDatabase.child("posts/${postInformation.postID}").set({
        'postID': postInformation.postID,
        'plantPhoto': imageUrl,
        'date': postInformation.date,
        'userName': postInformation.userName,
        'userPhoto': postInformation.userPhoto,
        'plantDescription': postInformation.plantDescription,
        'value': postInformation.value
      });

      await _firebaseDatabase
          .child('posts/postIds')
          .update({'${postInformation.postID}': ""});

      await _firebaseFirestore
          .collection('posts')
          .doc(postInformation.postID)
          .set({
        'postID': postInformation.postID,
        'plantPhoto': imageUrl,
        'date': postInformation.date,
        'userName': postInformation.userName,
        'userPhoto': postInformation.userPhoto,
        'plantDescription': postInformation.plantDescription,
        'value': postInformation.value
      });
      return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }

  Future<List<String>> getPostIds() async {
    List<String> tempList = [];
    await _firebaseDatabase.child("posts/postIds").get().then((snapshot) => {
          for (final dataSnapshot in snapshot.children)
            {
              tempList.add(dataSnapshot.key.toString()),
            }
        });
    return tempList;
  }

  void getPostsData() async {
    List<String> postIdsList = await getPostIds();
    print(postIdsList);
    for (int i = 0; i < postIdsList.length; i++) {
      var doc = _firebaseDatabase.child('posts/${postIdsList[i]}').get()
          as Map<String, dynamic>;
      print(doc);
    }
  }

  Future<List<PostInformation>> getAllPosts() async {
    List<String> postIdsList = await getPostIds();
    List<PostInformation> tempPostsList = [];
    PostInformation? _postInformation;
    for (int i = 0; i < postIdsList.length; i++) {
      var postsDoc = await _firebaseFirestore
          .collection('posts')
          .doc(postIdsList[i])
          .get();
      if (postsDoc.exists) {
        final postsData = await postsDoc.data() as Map<String, dynamic>;
        _postInformation = PostInformation(
          postID: postsData['postID'],
          plantPhoto: postsData['plantPhoto'],
          date: postsData['date'],
          userName: postsData['userName'],
          userPhoto: postsData['userPhoto'],
          plantDescription: postsData['plantDescription'],
          value: postsData['value'],
        );
        tempPostsList.add(_postInformation);
      }
    }
    return tempPostsList;
  }
}
