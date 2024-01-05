import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_notivication/phone_number_login/page/phone_otp.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
class PhoneNumberLogin extends StatelessWidget {
  PhoneNumberLogin({super.key});
  final phoneNumberController = TextEditingController();
  static String verify ="";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/user-profile.png',
                  height: height/2 *0.85,
                  width: width/2,
                ),
                const Text(
                  'Phone Verification',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),
                ),
                const Text(
                  'We need to register your phone befor getting start',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20
                  ),
                  padding: const EdgeInsets.only(
                    left: 30
                  ),
                  height: 55,
                  width: width*0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.lightBlue.withOpacity(0.5)
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "+855 | ",
                        style: TextStyle(
                        fontSize: 18,
                        color: Colors.white
                      ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.phone,
                          decoration:  InputDecoration(
                            hintText: "Enter phone number",
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.7)
                            ),
                            border: InputBorder.none
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
               
                const SizedBox(height: 30,),
                ZoomTapAnimation(
                  onTap: () async{
                    await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: "${'+855'+phoneNumberController.text}",
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      PhoneNumberLogin.verify=verificationId;
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return PhoneOTP();
                        },));
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                  
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: width*0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.lightBlue
                    ),
                    child: const Text(
                      'Send the code',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}