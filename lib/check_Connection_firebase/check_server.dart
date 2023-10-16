import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CheckServer extends StatefulWidget {
  const CheckServer({super.key});

  @override
  _CheckServerState createState() => _CheckServerState();
}

class _CheckServerState extends State<CheckServer> {
  bool isFirestoreConnected = false;

  @override
  void initState() {
    super.initState();
    checkFirestoreConnection();
  }

  Future<void> checkFirestoreConnection() async {
    try {
      // Khởi tạo Firebase App
      await Firebase.initializeApp();

      // Thử kết nối đến Firestore Database
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('your_collection_name').get();
      setState(() {
        isFirestoreConnected = true;
      });
    } catch (e) {
      setState(() {
        isFirestoreConnected = false;
      });
      print('Lỗi kết nối đến Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Server Connection'),
      ),
      body: Center(
        child: isFirestoreConnected
            ? const Text('Kết nối đến Firestore thành công')
            : const Text('Không thể kết nối đến Firestore'),
      ),
    );
  }
}
