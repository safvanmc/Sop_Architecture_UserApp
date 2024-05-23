import 'dart:io';

import 'package:architecture/features/home/data/model/user_model.dart';
import 'package:architecture/features/home/presentation/provider/provider.dart';
import 'package:architecture/features/home/presentation/view/widgets/CustomTextField.dart';
import 'package:architecture/features/upload/prasentation/provider/uploadProvider.dart';
import 'package:architecture/features/upload/prasentation/view/widgets/image_pick_bottom.dart';
import 'package:architecture/features/upload/repo/i_upload_impl.dart';
import 'package:architecture/general/services/search_keywords.dart';
import 'package:architecture/general/services/toast_messages.dart';
import 'package:architecture/general/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddUserDialoge extends StatelessWidget {
  const AddUserDialoge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final home = Provider.of<HomeProvider>(context, listen: false);
    return Consumer<UploadProvider>(
      builder: (context, pro, child) => AlertDialog(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Add A New User',
            style: TextStyle(fontSize: 20.sp),
          ),
        ),
        content: Form(
          key: pro.formkey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: mq.height * 0.06,
                      backgroundImage: pro.imagePath.isEmpty
                          ? null
                          : FileImage(File(pro.imagePath)),
                    ),
                    // Positioned(
                    //   left: mq.width * 0.01,
                    //   top: mq.height * 0.10,
                    //   child: Transform.rotate(
                    //     angle: 3.15 / 1,
                    //     child: ClipRect(
                    //       child: Align(
                    //         alignment: Alignment.topCenter,
                    //         heightFactor: 0.4,
                    //         child: CircleAvatar(
                    //           radius: mq.height * 0.065,
                    //           backgroundColor: Colors.black.withOpacity(0.1),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              context: context,
                              builder: (builder) {
                                return const ImagePickerBottomSheet();
                              });
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          size: 10,
                        ))
                  ],
                ),
                CustomTextField(
                    controller: pro.name,
                    text: 'Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'empty field';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextField(
                    controller: pro.age,
                    text: 'Age',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'empty field';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
        actions: [
          MaterialButton(
            color: Colors.grey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w)),
            onPressed: () {
              Navigator.pop(context);
              pro.name.clear();
              pro.age.clear();
              pro.imagePath = '';
            },
            child: Text('cancel',
                style: TextStyle(fontSize: 15.sp, color: Colors.black)),
          ),
          MaterialButton(
            color: Colors.blue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.w)),
            onPressed: () async {
              String image = '';
              if (pro.formkey.currentState!.validate()) pro.isLoading = true;

              // if (pro.isLoading) {
              //   // showDialog(
              //   //     context: context,
              //   //     builder: (context) => Text("loading..."));
              //   return;
              // }
              if (pro.imagePath.isNotEmpty) {
                image = await AddUserRepository()
                    .getUserProfilePicture(File(pro.imagePath));
              }

              final user = UserModel(
                  name: pro.name.text,
                  age: int.parse(pro.age.text.trim()),
                  url: image,
                  search: keywordsBuilder(pro.name.text));
              await pro.addUser(user).then((value) {
                home.addUserLocaly(user);
                Navigator.pop(context);
              });
              pro.isLoading = false;

              pro.clearDatas();
            },
            child: Text('Save',
                style: TextStyle(fontSize: 15.sp, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
