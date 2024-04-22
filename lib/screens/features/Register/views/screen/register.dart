import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maasapp/screens/core/utils/image_constants.dart';
import 'package:maasapp/screens/core/utils/string_constants.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(46, 53, 107, 1),
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            SizedBox(
              height: 25.h,
            ),
            Image.asset(ImageConstants.appBarImage),
            SizedBox(
              height: 6.h,
            ),
            Text(
              StringConstants.goalOfApp,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Center(
                  child: Text(
                    StringConstants.signInToContinue,
                    style: GoogleFonts.poppins(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xffffffff),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 38.0).w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        StringConstants.email,
                        style: GoogleFonts.dmSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffffffff),
                        ),
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      SizedBox(
                        width: 295.w,
                        height: 42,
                        child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15).r,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15).r,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15).r,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15).r,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                // isDense: true,
                                hoverColor: Colors.white,
                                focusColor: Colors.white,
                                hintText: StringConstants.hintEmail,
                                hintStyle: GoogleFonts.dmSans(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ))),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Text(
                        StringConstants.password,
                        style: GoogleFonts.dmSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffffffff),
                        ),
                      ),
                      SizedBox(
                        height: 9.h,
                      ),
                      SizedBox(
                        width: 295.w,
                        height: 42,
                        child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15).r,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15).r,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15).r,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15).r,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                // isDense: true,
                                hoverColor: Colors.white,
                                focusColor: Colors.white,
                                hintText: StringConstants.hintPassword,
                                hintStyle: GoogleFonts.dmSans(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                ))),
                      ),
                      SizedBox(
                        height: 23.h,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 135.w,
                              height: 41,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20).r,
                                  border:
                                      Border.all(width: 3, color: Colors.white),
                                  color: Colors.transparent),
                              child: Center(
                                child: Text(StringConstants.login,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xffffffff),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 27.w,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 135.w,
                              height: 41,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20).r,
                                  border: Border.all(
                                      width: 0, color: Colors.transparent),
                                  color: const Color.fromRGBO(252, 72, 110, 1)),
                              child: Center(
                                child: Text(StringConstants.register,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xffffffff),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () {
                    log("Forget Password");
                  },
                  child: Center(
                    child: Text(StringConstants.forgotPassword,
                        style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 255, 255, 255))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 38.0).w,
                  child: SizedBox(
                    height: 236.h,
                    // height: 165,
                    // width: double.infinity,
                    child: Image.asset(
                      // fit: BoxFit.fill,
                      ImageConstants.illustrationImage,
                    ),
                  ),
                )
              ],
            ),
          ],
        )),
      ),
    );
  }
}
