import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:focusbuddy/Providers/CounterProvider.dart';
import 'package:focusbuddy/Providers/LoginProvider.dart';
import 'package:focusbuddy/screens/LogInScreen.dart';
import 'package:focusbuddy/screens/homescreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Providers/TaskProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Loginprovider()),
        ChangeNotifierProvider(create: (context) => Counterprovider()),
        ChangeNotifierProvider(create: (context) => Taskprovider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            // Set these to match your exact dark grey/charcoal theme background
            scaffoldBackgroundColor: const Color.fromARGB(255, 33, 33, 33),
            canvasColor: const Color.fromARGB(255, 33, 33, 33),
          ),
          home: const Splashscreen(),
        );
      },
    );
  }
}

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the provider. Whenever notifyListeners() is called, this rebuilds.
    final loginProvider = context.watch<Loginprovider>();

    // As soon as the disk data is ready, run the routing logic
   Timer(Duration(seconds: 3),(){
     if (loginProvider.hasLoaded) {
       // Use addPostFrameCallback so navigation happens after the frame completes safely
       WidgetsBinding.instance.addPostFrameCallback((_) {
         if (loginProvider.isLogedin) {
           Navigator.of(context).pushReplacement(
             MaterialPageRoute(builder: (context) =>  Homescreen()),
           );
         } else {
           Navigator.of(context).pushReplacement(
             MaterialPageRoute(builder: (context) => loginscreen()),
           );
         }
       });
     }
   });
    return Scaffold(
      backgroundColor: const Color(0xFF212121),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(
              child: FaIcon(
                FontAwesomeIcons.moon,
                size: 60.sp,
                color: Colors.cyanAccent,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "FocusBuddy",
              style: GoogleFonts.googleSans(
                color: Colors.white,
                fontSize: 45.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50.h),
            SpinKitFadingCircle(
              color: Colors.cyan,
              size: 55.sp,
            ),
            const Spacer(),
            SafeArea(
              child: Text(
                "Welcome",
                style: GoogleFonts.googleSans(
                  fontSize: 20.sp,
                  color: Colors.cyanAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}