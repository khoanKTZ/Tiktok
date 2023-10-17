import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/Screen/login_screen.dart';
import 'package:tiktok_clone/check_Connection_firebase/save_video.dart';
import 'package:tiktok_clone/check_Connection_firebase/utils.dart';
import 'package:video_player/video_player.dart';

void main() {
  FirebaseOptions options = const FirebaseOptions(
    apiKey: 'AIzaSyDec9jFizbrTJFHBXImSRslKIpBhTGpPYg',
    appId: '1:314737080085:web:fa743e14688eb9887f5b1c',
    messagingSenderId: '314737080085',
    projectId: 'tiktok-clone-35aeb',
    authDomain: 'tiktok-clone-35aeb.firebaseapp.com',
    databaseURL: 'https://tiktok-clone-35aeb-default-rtdb.firebaseio.com',
    storageBucket: 'tiktok-clone-35aeb.appspot.com',
    measurementId: 'G-KQ9SB6GDGZ',
  );
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: options);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: CheckServer(),
      // home: const HomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _videoUrl;
  VideoPlayerController? _videoPlayerController;
  String? _downloadUrl;

  bool _isImagePickerActive = false;

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UpLoadVideo'),
      ),
      body: Center(
        child: _videoUrl != null
            ? _videoPlayerController != null
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio:
                              _videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController!),
                        ),
                        ElevatedButton(
                          onPressed: _upLoadVideo,
                          child: Text('UpLoad'),
                        ),
                      ],
                    ),
                  )
                : CircularProgressIndicator()
            : const Text('No video select'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!_isImagePickerActive) {
            _isImagePickerActive = true;
            _videoUrl = await pickVideo();
            _isImagePickerActive = false;
            _initializaVideoController();
          }
        },
        child: Icon(Icons.video_call),
      ),
    );
  }

  void _initializaVideoController() {
    _videoPlayerController = VideoPlayerController.file(File(_videoUrl!))
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController!.play();
      });
  }

  _videoPreviewWitget() {
    if (_videoPlayerController != null) {
      return Column(children: [
        AspectRatio(
          aspectRatio: _videoPlayerController!.value.aspectRatio,
          child: VideoPlayer(_videoPlayerController!),
        ),
        ElevatedButton(
          onPressed: _upLoadVideo,
          child: Text('UpLoad'),
        )
      ]);
    } else {
      return const CircularProgressIndicator();
    }
  }

  void _upLoadVideo() async {
    _downloadUrl = await StorageData().uploadVideos(_videoUrl!);
    await StorageData().saveVideoData(_downloadUrl!);
    setState(() {
      _videoUrl = null;
    });
  }
}
