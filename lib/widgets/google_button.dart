import 'package:e_commerce/screens/bottom_bar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../consts/dialog_box.dart';
import 'text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  Future<UserCredential?> googleSignIn(context) async {
    try {
      print("Google Sign-In started");
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print("Google Sign-In successful");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const BottomBarScreen()));
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseException catch (error) {
      print("FirebaseException: ${error.message}");
      AlertDialogs.errorDialog(subtitle: '${error.message}', context: context);
      return null; // Add this line to return null in case of FirebaseException.
    } catch (error) {
      print("Error: $error");
      AlertDialogs.errorDialog(subtitle: '$error', context: context);
      return null; // Add this line to return null in case of other exceptions.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          googleSignIn(context);
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/images/google.png',
              width: 40.0,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          TextWidget(
              text: 'Sign in with Google', color: Colors.white, textSize: 18)
        ]),
      ),
    );
  }
}
