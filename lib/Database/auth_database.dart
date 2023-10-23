import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/Getx/user.dart' as model;
import 'package:tiktok_clone/Screen/home_screen.dart';
import 'package:tiktok_clone/Screen/login_screen.dart';
import 'package:tiktok_clone/widgets/editpage.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find<AuthController>();

  late Rx<User?> _user;
  late Rx<File?> _pickedImage;

  File? get profilePhoto => _pickedImage.value;

  User get user => _user.value!;
  @override
  void onReady() {
    User? currentUser = firebaseAuth.currentUser;
    if (currentUser != null) {
      _user = Rx<User?>(currentUser);
    } else {
      _user = Rx<User?>(null);
    }
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture!');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadToStorage(image);
        User? user = cred.user;
        String uid = user!.uid;
        model.User userData = model.User(
          name: username,
          email: email,
          uid: uid,
          profilePhoto: downloadUrl,
        );
        print(user);
        await fireStore.collection('users').doc(uid).set({
          'name': userData.name,
          'email': userData.email,
          'uid': userData.uid,
          "profilePhoto": userData.profilePhoto,
        });
      } else {
        Get.snackbar(
            'Error Creating Account', 'Vui lòng nhập đầy đủ thông tin');
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error Creating Account', e.toString());
    }
  }

  Future<void> loginUser(
      String email, BuildContext context, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));

        print('Thanh cong');
      } else {
        Get.snackbar('Error Login Acccount', "Vui lòng nhấp đầy đủ dữ liệu !!");
      }
    } catch (e) {
      Get.snackbar('Error Login', e.toString());
    }
  }
}
