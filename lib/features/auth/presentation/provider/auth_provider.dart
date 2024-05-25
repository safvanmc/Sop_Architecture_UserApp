// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
// import 'package:sms_autofill/sms_autofill.dart';
import 'package:architecture/features/auth/repo/i_auth_impl.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final AuthRepository authRepository = AuthRepository();
  bool isLoading = false;
  // AuthProvider() {
  //   _listenSmsCode();
  // }
  // _listenSmsCode() async {
  //   await SmsAutoFill().listenForCode();
  // }

  // @override
  // void codeUpdated() {
  //   // print('SMS code updated:$code');
  //   if (code != null && code!.isNotEmpty) {
  //     otpController.text = code!;
  //     notifyListeners();
  //   }
  // }

  // @override
  // void dispose() {
  //   SmsAutoFill().unregisterListener();
  //   super.dispose();
  // }

  //login using phone number
  void loginWithPhoneNumber(BuildContext context) {
    isLoading = true;
    String phoneNumber = numberController.text.trim();

    if (!phoneNumber.startsWith("+91")) {
      phoneNumber = "+91$phoneNumber";
    }
    authRepository.loginWithPhoneNumber(context, phoneNumber);

    notifyListeners();
  }

  //otp submition
  Future<void> otpSubmit(String verificationId) async {
    isLoading = false;
    notifyListeners();
    await authRepository.otpSubmit(otpController.text, verificationId);
    notifyListeners();
  }
}
