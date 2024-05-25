import 'package:architecture/features/upload/prasentation/provider/uploadProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(
          top: mq.height * .03,
          bottom: mq.height * .05,
          left: mq.width * .05,
          right: mq.width * .05),
      children: [
        const Text(
          'Pick a Profile Picture',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: mq.height * .02),
        Consumer<UploadProvider>(
          builder: (context, imageProvider, child) {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const BeveledRectangleBorder(),
                        fixedSize: Size(mq.width, mq.height * .10)),
                    onPressed: () async {
                      await imageProvider
                          .pickImage(ImageSource.gallery)
                          .then((value) {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Choose photo'),
                        Icon(Icons.photo_library_outlined),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const BeveledRectangleBorder(),
                        fixedSize: Size(mq.width, mq.height * .10)),
                    onPressed: () async {
                      await imageProvider
                          .pickImage(ImageSource.camera)
                          .then((value) {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Take photo'),
                        Icon(Icons.camera_alt_outlined),
                      ],
                    )),
              ],
            );
          },
        ),
      ],
    );
  }
}
