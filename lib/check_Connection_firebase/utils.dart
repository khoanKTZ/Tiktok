import 'package:image_picker/image_picker.dart';

pickVideo() async {
  // ignore: unused_local_variable
  final picker = ImagePicker();
  // ignore: unused_local_variable
  XFile? VideoFile;

  try {
    VideoFile = await picker.pickVideo(source: ImageSource.gallery);
    return VideoFile!.path;
  } catch (e) {
    print('UpLoad video error: $e');

  }
}
