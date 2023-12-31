import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/widgets/text_input_file.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen(
      {Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);


  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController controller;
  TextEditingController _songController = TextEditingController();
  TextEditingController _captionController = TextEditingController();

  UploadVideoController uploadVideoController =
      Get.put(UploadVideoController());

  @override
  void initState() {
    super.initState();
    setState(() {
      controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: VideoPlayer(controller),
            ),
            const SizedBox(
              height: 30,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                        controller: _songController,
                        labelText: 'Song Name',
                        icon: Icons.music_note),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 10),
                    width: MediaQuery.of(context).size.width - 20,
                    child: TextInputField(
                        controller: _captionController,
                        labelText: 'Caption',
                        icon: Icons.music_note),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () => uploadVideoController.uploadVideo(
                          _songController.text,
                          _captionController.text,
                          widget.videoPath),
                      child: Text(
                        'UpLoad',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UploadVideoController {
  uploadVideo(String text, String text2, String videoPath) {}
}
