import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _store = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StorageData {
  Future<String> uploadVideos(String videoURL) async {
    Reference ref = _store.ref().child('videos/${DateTime.now()}.mp4');
    await ref.putFile(File(videoURL));
    String dowloadURL = await ref.getDownloadURL();
    return dowloadURL;
  }

  Future<void> saveVideoData(String videoDownloadURL) async {
    CollectionReference videosRef = _firestore.collection('videos');

    return videosRef.doc().set({
      'url': videoDownloadURL,
      'timeStamp': FieldValue.serverTimestamp(),
      'name': 'User video'
    });
  }
}
