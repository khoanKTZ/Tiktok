import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/Database/auth_database.dart';
import 'package:tiktok_clone/Screen/HomePage.dart';
import 'package:tiktok_clone/Screen/camvideo_screen.dart';
import 'package:tiktok_clone/Screen/chat_screen.dart';
import 'package:tiktok_clone/Screen/profile_screen.dart';

List pages = [
  HomePage(),
  ChatScreen(),
  CamScreen(),
  Text('Mail Screen'),
  ProFilePage(uid: authController.user.uid),
];
const backgroundColor = Colors.black;

var buttonColor = Colors.red[400];

const borderColor = Colors.grey;
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var fireStore = FirebaseFirestore.instance;

var authController = AuthController.instance;
