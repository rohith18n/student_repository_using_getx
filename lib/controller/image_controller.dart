import 'dart:io';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class TempImageController extends GetxController {
  String? tempImagePath;

  Future<void> getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final imageTemporary = File(image.path);
    tempImagePath = imageTemporary.path;
    update();
  }

  void notify() {
    update();
  }
}
