import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plant/domain/carts.dart';

class CartsData {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  final Reference _storageReference = FirebaseStorage.instance.ref();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> addInCart({required Carts carts}) async {
    try {
      await _database
          .child(
              "${Carts.firebaseCartDocumentName}/${carts.buyerId}/${carts.cartId}")
          .set({
        Carts.firebaseCartId: carts.cartId,
        Carts.firebaseCartBuyerId: carts.buyerId,
        Carts.firebaseCartBuyerName: carts.buyerName,
        Carts.firebaseCartCurrentSelectItem: carts.currentSelectItem,
        Carts.firebaseCartPerItemPrice: carts.perItemPrice,
        Carts.firebaseCartPlantImage: carts.plantImage,
        Carts.firebaseCartPlantName: carts.plantName,
        Carts.firebaseCartPlantSellerID: carts.plantSellerID,
        Carts.firebaseCartPlantSellerName: carts.plantSellerName,
        Carts.firebaseCartTotalItem: carts.totalItem,
        Carts.firebaseCartAvailableItem: carts.availableItem,
      });
      return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }

  Future<bool> deleteCart(
      {required String username, required String plantId}) async {
    try {
      await _database
          .child("${Carts.firebaseCartDocumentName}/${username}/${plantId}")
          .remove();
      return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }

  Future<bool> updateCartAndPlant(
      {required Carts carts, required int previousSold}) async {
    try {
      await _database
          .child("plants/${carts.cartId}")
          .update({'soldPlants': carts.currentSelectItem});
      await _firestore
          .collection('plants')
          .doc('${carts.cartId}')
          .update({'soldPlants': (carts.currentSelectItem + previousSold)});
      return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }
}
