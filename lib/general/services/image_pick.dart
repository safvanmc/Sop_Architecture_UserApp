import 'package:image_picker/image_picker.dart';

Future<String?> pickImage(ImageSource imageSource) async {
  try {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: imageSource);

    return pickedFile?.path;
  } catch (e) {
    throw Exception(e);
  }
}
