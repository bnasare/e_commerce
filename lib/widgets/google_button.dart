import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/fetch_screen.dart';
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

      // signInWithCredential returns a UserCredential object
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Now you can access the user property
      final user = userCredential.user;

      if (userCredential.additionalUserInfo!.isNewUser) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .set({
          'id': user.uid,
          'name': user.displayName,
          'email': user.email,
          'shipping_address': '',
          'userWishList': [],
          'userCartItems': [],
          'createdAt': Timestamp.now(),
        });
      }

      print("Google Sign-In successful");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const FetchScreen()));
      return userCredential;
    } on FirebaseException catch (error) {
      print("FirebaseException: ${error.message}");
      AlertDialogs.errorDialog(subtitle: '${error.message}', context: context);
      return null;
    } catch (error) {
      print("Error: $error");
      AlertDialogs.errorDialog(subtitle: '$error', context: context);
      return null;
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
