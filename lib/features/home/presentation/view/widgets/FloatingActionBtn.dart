import 'package:architecture/features/upload/prasentation/view/add_userDialoge.dart';
import 'package:flutter/material.dart';

class FloatingActionBtn extends StatelessWidget {
  const FloatingActionBtn({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      backgroundColor: const Color.fromARGB(255, 30, 29, 29),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {
        add(context);
      },
    );
  }

  add(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) => const AddUserDialoge(),
    );
  }
}
