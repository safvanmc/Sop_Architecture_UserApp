import 'package:architecture/features/home/presentation/provider/provider.dart';
import 'package:architecture/general/core/sort_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SortingAlert extends StatelessWidget {
  const SortingAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, pro, child) => AlertDialog(
        scrollable: true,
        title: Text(
          'Sort',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        ),
        titlePadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10).w,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10).w,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        insetPadding:
            const EdgeInsets.symmetric(horizontal: 50, vertical: 250).w,
        content: Column(
          children: [
            RadioListTile(
              title: Text(
                "Age:All",
                style: TextStyle(fontSize: 15.sp),
              ),
              value: AgeType.all,
              groupValue: pro.selectedValue,
              onChanged: (value) {
                pro.clearData();
                pro.changeValue(value!);

                pro.getUsers(value);
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: Text(
                "Age:Elder",
                style: TextStyle(fontSize: 15.sp),
              ),
              value: AgeType.elder,
              groupValue: pro.selectedValue,
              onChanged: (value) {
                pro.clearData();
                pro.changeValue(value!);

                pro.getUsers(value);
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: Text(
                "Age:Younger",
                style: TextStyle(fontSize: 15.sp),
              ),
              value: AgeType.younger,
              groupValue: pro.selectedValue,
              onChanged: (value) {
                pro.clearData();
                pro.changeValue(value!);

                pro.getUsers(value);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
