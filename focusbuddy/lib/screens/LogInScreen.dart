import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focusbuddy/Providers/LoginProvider.dart';
import 'package:focusbuddy/screens/homescreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class loginscreen extends StatelessWidget {
  loginscreen({super.key});

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF212121),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Focus Buddy Tre Buddy Text
                Text(
                  "FocusBuddy",
                  style: GoogleFonts.googleSans(
                    color: Colors.white,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                // Subtitle text
                Text(
                  "Enhance your focus.",
                  style: GoogleFonts.googleSans(
                    fontSize: 23.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5.h),
                // Json Floating Image
                Lottie.asset(
                  "assets/Meditation.json",
                  width: 250.w,
                  height: 250.h,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback placeholder widget if json asset isn't matching perfectly yet
                    return SizedBox(height: 150.h, child: const Icon(Icons.image, color: Colors.grey));
                  },
                ),
                // username TextFiel
                Padding(
                  padding: EdgeInsets.fromLTRB(30.w, 8.h, 30.w, 8.h),
                  child: TextField(
                    controller: username,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person, color: Colors.cyanAccent),
                      hintText: "Enter Username",
                      hintStyle: GoogleFonts.googleSans(color: Colors.white38, fontSize: 15.sp),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(width: 2.w, color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(width: 2.w, color: Colors.cyanAccent),
                      ),
                    ),
                  ),
                ),
                // password TextFiel
                Padding(
                  padding: EdgeInsets.fromLTRB(30.w, 8.h, 30.w, 8.h),
                  child: TextField(
                    controller: password,
                    obscureText: true, // Secure entry pattern for text passwords
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: Colors.cyanAccent),
                      hintText: "Enter Password",
                      hintStyle: GoogleFonts.googleSans(color: Colors.white38, fontSize: 15.sp),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(width: 2.w, color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: BorderSide(width: 2.w, color: Colors.cyanAccent),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                // Login Button with snack bar and data storing logic
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(300.w, 45.h), // Slightly padded matching standard thumb touch targets
                    backgroundColor: Colors.cyanAccent,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () {
                    final String userVal = username.text.trim();
                    final String passVal = password.text.trim();

                    if (userVal.isNotEmpty && passVal.isNotEmpty) {
                      context.read<Loginprovider>().setLoginStatus(true, userVal);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Homescreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            "Please Enter Both Username & Password Correctly!",
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.black,
                          action: SnackBarAction(
                            label: 'Close',
                            textColor: Colors.blue,
                            onPressed: () {
                              ScaffoldMessenger.of(context).clearSnackBars();
                            },
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Log In",
                    style: GoogleFonts.googleSans(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                //Forgot password Text
                Text(
                  "Forgot Password?",
                  style: GoogleFonts.googleSans(color: Colors.blueGrey, fontSize: 15.sp),
                ),
                SizedBox(height: 15.h),
                Text(
                  "or continue with",
                  style: GoogleFonts.googleSans(color: Colors.white, fontSize: 15.sp),
                ),
                SizedBox(height: 15.h),

                //Google & Apple  id Sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset("assets/google_logo.png", width: 40.w, errorBuilder: (c, e, s) => const Icon(Icons.g_mobiledata, size: 40)),
                      onPressed: () {},
                    ),
                    SizedBox(width: 30.w),
                    IconButton(
                      icon: const Icon(Icons.apple, color: Colors.white, size: 40),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                // Don't have account Sign up text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.googleSans(color: Colors.white, fontSize: 15.sp),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.googleSans(color: Colors.cyan, fontSize: 15.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}