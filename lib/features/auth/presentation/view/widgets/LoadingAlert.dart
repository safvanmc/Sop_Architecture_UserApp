import 'package:flutter/material.dart';

class LoadingAlertBox extends StatelessWidget {
  const LoadingAlertBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: mq.width / 5,
          vertical: mq.height / 2.3,
        ),
        content: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: Colors.blue.shade300,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text('Loading....'),
          ],
        )),
      ),
    );
  }
}
