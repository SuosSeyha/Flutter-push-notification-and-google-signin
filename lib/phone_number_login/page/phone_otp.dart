import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:test_notivication/phone_number_login/page/homepage.dart';
import 'package:test_notivication/phone_number_login/page/phoneNumber_login.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
class PhoneOTP extends StatefulWidget {
  PhoneOTP({super.key});

  @override
  State<PhoneOTP> createState() => _PhoneOTPState();
}
String pinCode="";
class _PhoneOTPState extends State<PhoneOTP> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    
    FirebaseAuth auth = FirebaseAuth.instance;
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
                Pinput(
                  // controller: pinCodeController,
                  // focusNode: _pinPutFocusNode,
                  onChanged: (value) {
                      pinCode=value;
                    print("==>Pincode:$pinCode");
                    
                  },
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  // validator: (s) {
                  //   return s == '2222' ? null : 'Pin is incorrect';
                  // },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) => print(pin),
                ),
                const SizedBox(height: 30,),
                ZoomTapAnimation(
                  onTap: () async{              // Create a PhoneAuthCredential with the code
                   try{
                     PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: PhoneNumberLogin.verify, smsCode: pinCode);
                    // Sign the user in (or link) with the credential
                    await auth.signInWithCredential(credential);
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return const HomePage();
                    },));
                   }catch(e){
                    print("OTP Wrong!!");
                   }
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
                      'Verify Phone Number',
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