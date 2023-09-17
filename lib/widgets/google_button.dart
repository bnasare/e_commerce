import 'package:e_commerce/consts/firebase_consts.dart';
import 'package:e_commerce/screens/bottom_bar_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../consts/dialog_box.dart';
import 'text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  Future<void> googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await authInstance.signInWithCredential(GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken));
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const BottomBarScreen()));
        } on FirebaseException catch (error) {
          AlertDialogs.errorDialog(
              subtitle: '${error.message}', context: context);
        } catch (error) {
          AlertDialogs.errorDialog(subtitle: '$error', context: context);
        }
      }
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
