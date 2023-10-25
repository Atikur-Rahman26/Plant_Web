import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:plant/domain/Comments.dart';

class CommentsDataFetching {
  final DatabaseReference _firebaseDatabase =
      FirebaseDatabase.instance.reference();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<bool> addComments(
      {required String postId, required Comments comments}) async {
    try {
      _firebaseDatabase.child('comments/${postId}/${comments.commentID}').set({
        'commentorName': comments.commentorName,
        'value': comments.value,
        'commentingTime': comments.commentingTime,
        'commentingDate': comments.commentingDate,
        'commentorPhoto': comments.commentorPhoto,
        'commentDetails': comments.commentDetails,
        'postID': comments.postID,
        'commentorID': comments.commentorID,
        'commentID': comments.commentID,
      });
      return true;
    } on FirebaseDatabase catch (e) {
      return false;
    }
  }
}
