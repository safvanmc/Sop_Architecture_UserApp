import 'package:architecture/features/home/data/model/user_model.dart';
import 'package:architecture/features/upload/repo/i_upload_impl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadProvider extends ChangeNotifier {
  final TextEditingController name = TextEditingController();
  final TextEditingController age = TextEditingController();
  String imagePath = "";
  bool isLoading = false;
  final formkey = GlobalKey<FormState>();

  // add user
  Future<void> addUser(UserModel user) async {
    await AddUserRepository().addUsers(user);
    notifyListeners();
  }

  //set user profile picture
  Future<void> pickImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imagePath = image.path;
      notifyListeners();
    }
  }

  // user data from textfields
  void clearDatas() {
    name.clear();
    age.clear();
    imagePath = '';
    notifyListeners();
  }
}
