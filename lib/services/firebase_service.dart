import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload image to Firebase Storage and return URL
  static Future<String> uploadImage(File imageFile) async {
    try {
      final storageRef = _storage.ref();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final imageRef = storageRef.child('payment_evidence/$timestamp.jpg');

      await imageRef.putFile(imageFile);
      return await imageRef.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      rethrow;
    }
  }

  // Insert order data into Firestore
  static Future<bool> insertOrder(
      Map<String, dynamic> orderData, File imageFile) async {
    try {
      // Upload image first
      final imageUrl = await uploadImage(imageFile);

      // Prepare order data
      final orderDoc = {
        'name': orderData['name'],
        'phone': orderData['phone'],
        'province': orderData['province'],
        'district': orderData['district'],
        'village': orderData['village'],
        'deliveryService': orderData['deliveryService'],
        'paymentImageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'pending', // You can add order status
        'items': orderData['items'], // Add cart items to the order
        'totalAmount': orderData['totalAmount']
      };

      // Add document to 'orders' collection
      await _firestore.collection('orders').add(orderDoc);
      return true;
    } catch (e) {
      print('Error inserting order: $e');
      return false;
    }
  }
}