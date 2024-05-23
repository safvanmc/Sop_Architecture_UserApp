import 'package:architecture/features/auth/presentation/provider/auth_provider.dart';
import 'package:architecture/features/auth/presentation/view/widgets/login_screen.dart';
import 'package:architecture/features/home/presentation/provider/provider.dart';
import 'package:architecture/features/search/presentation/provider/search_provider.dart';
import 'package:architecture/features/upload/prasentation/provider/uploadProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => SearchUserProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => HomeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => UploadProvider(),
          )
        ],
        child: const MaterialApp(
          home: LoginScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
