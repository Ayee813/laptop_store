import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddProductService extends ChangeNotifier {
  Future<void> uploadImage(File? image) async {
  // Pick an image from the gallery
  if (image == null) return;

  // Create a reference to Firebase Storage
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference storageRef = storage.ref().child('uploads/${image.path}'); // You can change the path as needed

  try {
    // Upload the image file to Firebase Storage
    await storageRef.putFile(File(image.path));

    // Get the download URL after upload
    String downloadUrl = await storageRef.getDownloadURL();

    print("Image uploaded successfully. Download URL: $downloadUrl");
  } catch (e) {
    print("Failed to upload image: $e");
  }
}

}
