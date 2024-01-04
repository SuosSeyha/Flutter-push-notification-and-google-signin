import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
class FacebookPage extends StatefulWidget {
   FacebookPage({super.key});

  @override
  State<FacebookPage> createState() => _FacebookPageState();
}

class _FacebookPageState extends State<FacebookPage> {
  
  Map<String,dynamic>? userData;
  String profilePicUrl="";
  
  Future<UserCredential> signInWithFacebook() async {
    final LoginResult? loginResult = await FacebookAuth.instance.login(permissions: ['email','public_profile',]).then((facebookUser)async{
      if(facebookUser!=null){
        await FacebookAuth.instance.getUserData().then((facebookUserData) async{
            setState(() {
              userData=facebookUserData;
            });
            final String userId = userData?['id'];
            profilePicUrl = "https://graph.facebook.com/$userId/picture?type=large"; //it's still cannot allow permission 'user _photo' yet just endpoint from : https://developers.facebook.com/docs/graph-api
            debugPrint("=====================FACEBOOK LOGIN INFO=======================");
            debugPrint("UserID: ${userData!['id']}");
            debugPrint("FBName: ${userData!['name']}");
            debugPrint("Email: ${userData!['email']}");
            debugPrint("Token: ${facebookUser.accessToken!.token}");
            debugPrint("ProfileImage: ${userData!['picture']['data']['url']}"); // Cann't display image yet
            debugPrint("==========================================================");
        });
      }
    return null;
    });
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult!.accessToken!.token);
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<void> signoutWithFacebook()async{
    await FacebookAuth.instance.logOut();
    userData = null;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: const Text("FACEBOOK LOGIN"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            userData !=null ?  SizedBox(
              child: Column(
                children: [
                  Container(
                    height: height/2 *0.5,
                    width: height/2 *0.5,
                    decoration:  BoxDecoration(
                      //color: Colors.pink,
                      border: Border.all(
                        width: 1,
                        color: Colors.pink
                      ),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(profilePicUrl.toString())
                      )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text("Facebook: ${userData!['name']}"),
                  const SizedBox(height: 20,),
                  Text("Email: ${userData!['email']}")
                ],
              ),
            ): const Text(""),
            const SizedBox(height: 50,),
            ElevatedButton(
              onPressed: (){
                userData==null ? signInWithFacebook() : signoutWithFacebook();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pink)
              ), 
              child:  Text(userData==null?"L O G I N":"L O G O U T",style: const TextStyle(color: Colors.white),),
            ), 
          ],
        ),
      ),
    );
  }
}