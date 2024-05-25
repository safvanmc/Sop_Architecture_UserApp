import 'package:architecture/features/home/data/model/user_model.dart';
import 'package:architecture/general/utils/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class userCard extends StatelessWidget {
  const userCard({
    super.key,
    required this.data,
  });

  final UserModel data;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    return ListTile(
      minTileHeight: mq.height / 10,
      leading: data.url == ''
          ? CircleAvatar(
              radius: 25.r,
              backgroundImage: AssetImage(AppImages.personImage),
              backgroundColor: Colors.grey,
            )
          : CircleAvatar(
              radius: 25.r,
              backgroundImage: Image.network(
                data.url,
                scale: 10,
              ).image,
              backgroundColor: Colors.grey,
            ),
      title: Text(data.name),
      subtitle: Text('Age:${data.age}'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: Colors.white,
    );
  }
}
