import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focusbuddy/Keys/AllKeys.dart';
import 'package:focusbuddy/Providers/CounterProvider.dart';
import 'package:focusbuddy/Providers/LoginProvider.dart';
import 'package:focusbuddy/Providers/TaskProvider.dart';
import 'package:focusbuddy/screens/LogInScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late TextEditingController taskcontroller;

  @override
  void initState() {
    super.initState();

    // 1. Fetch whatever is currently hydrated in memory right now
    final initialTask = Provider.of<Taskprovider>(context, listen: false).usertask;
    taskcontroller = TextEditingController(text: initialTask);

    // 2. If the async SharedPreferences is running late, catch it after the frame renders
    if (initialTask.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final provider = Provider.of<Taskprovider>(context, listen: false);

        // Wait briefly if provider is still loading disk data
        if (provider.usertask.isEmpty) {
          // Allow SharedPreferences a microsecond flash to finish loading
          await Future.delayed(const Duration(milliseconds: 50));
        }

        // If data arrived late from disk, populate it securely
        if (mounted && taskcontroller.text.isEmpty && provider.usertask.isNotEmpty) {
          taskcontroller.text = provider.usertask;
        }
      });
    }
  }

  @override
  void dispose() {
    taskcontroller.dispose(); // FIXED: No listener cleanups required anymore!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int count = context.watch<Counterprovider>().currentcount();
    return Scaffold(
      // Appbar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(96, 96, 96, 96),
        title:Padding(
          padding:  EdgeInsets.fromLTRB(0,0,0,10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "FocusBuddy",
                style: GoogleFonts.googleSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              Text(
                "Welcome back, ${context.watch<Loginprovider>().username} !",
                style: GoogleFonts.googleSans(
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp, // Sleek, low-profile size
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: TextButton.icon(
              onPressed: () {
                context.read<Loginprovider>().setLoginStatus(false,'');
                context.read<Counterprovider>().setCountZero();
                context.read<Taskprovider>().removeTask();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>loginscreen()));
              },
              label: Text(
                'Logout',
                style: GoogleFonts.googleSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
              icon: Icon(Icons.logout, color: Colors.white, size: 20.sp),
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(96, 96, 96, 96),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Focus data input container
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                child: Container(
                  width: 330.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.6),
                        // A strong, frosty shine in the top-left
                        Colors.white.withOpacity(0.3),
                        // A smooth, clear mid-tone
                        Colors.white.withOpacity(0.2),
                        // Fading to a very subtle translucency
                        Colors.white.withOpacity(0.1),
                        // Almost transparent in the bottom-right
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadiusGeometry.circular(20),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Your Focus for Today :",
                          style: GoogleFonts.googleSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 8, 10, 10),
                        child:
                        TextField(
                          key: const ValueKey('focus_task_field_key'), // Forces Flutter to preserve this input's state across rebuilds
                          maxLines: 2,
                          controller: taskcontroller,
                          style: GoogleFonts.googleSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 15.sp,
                          ),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: "Enter Today's goal !",
                            hintStyle: GoogleFonts.googleSans(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white60,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white60,
                                width: 2,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            // This updates your Taskprovider logic safely
                            context.read<Taskprovider>().addTask(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Progress indicator in percent
              CircularPercentIndicator(
                animation: true,
                //animationDuration: 2000,
                radius: 150,
                percent: count / 100,
                progressColor: Colors.cyan,
                lineWidth: 10,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$count %",
                      style: GoogleFonts.googleSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 50.sp,
                      ),
                    ),
                    Text(
                      "Work completed !",
                      style: GoogleFonts.googleSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
              // Add and Remove Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    radius: 90,
                    onTap: () {
                      if (count == 0) return;
                      context.read<Counterprovider>().removeCount();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.cyan,
                      radius: 40,
                      child: Center(
                        child: Icon(
                          Icons.remove,
                          color: Colors.black,
                          size: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 60.w),
                  InkWell(
                    radius: 90,
                    onTap: () {
                      if (count == 100) return;
                      context.read<Counterprovider>().addCount();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.cyan,
                      radius: 40,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70.h),
              // All progress save locally component
              SafeArea(
                child: Container(
                  width: 250.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    color: Colors.white38.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "All progress saved locally",
                        style: GoogleFonts.googleSans(
                          color: Colors.white70,
                          fontSize: 15.sp,
                        ),
                      ),
                      Icon(Icons.lock, color: Colors.white70, size: 15.sp),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
