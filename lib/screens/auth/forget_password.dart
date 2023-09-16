import 'package:card_swiper/card_swiper.dart';
import 'package:e_commerce/consts/consts.dart';
import 'package:e_commerce/consts/firebase_consts.dart';
import 'package:e_commerce/widgets/loading_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../dialog_box.dart/dialog_box.dart';
import '../../services/utils.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/text_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgetPasswordScreen';
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final emailTextController = TextEditingController();
  @override
  void dispose() {
    emailTextController.dispose();

    super.dispose();
  }

  bool isLoading = false;
  void _forgetPassFCT() async {
    if (emailTextController.text.isEmpty ||
        !emailTextController.text.contains('a')) {
      AlertDialogs.errorDialog(
          subtitle: 'Email address in invalid', context: context);
    } else {
      setState(() {
        isLoading = true;
      });
      try {
        await authInstance.sendPasswordResetEmail(
            email: emailTextController.text.toLowerCase());
        Fluttertoast.showToast(
            msg: "An email has been sent to your mail",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade700,
            textColor: Colors.white,
            fontSize: 16.0);
      } on FirebaseException catch (error) {
        AlertDialogs.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {
          isLoading = false;
        });
      } catch (error) {
        AlertDialogs.errorDialog(subtitle: '$error', context: context);
        setState(() {
          isLoading = false;
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final theme = Utils(context).getTheme;

    return Scaffold(
      body: LoadingManager(
        isLoading: isLoading,
        child: Stack(
          children: [
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Consts.authImagesPaths[index],
                  fit: BoxFit.cover,
                );
              },
              autoplay: true,
              itemCount: Consts.authImagesPaths.length,
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => Navigator.canPop(context)
                        ? Navigator.pop(context)
                        : null,
                    child: Icon(
                      IconlyLight.arrowLeft2,
                      color: theme == true ? Colors.white : Colors.black,
                      size: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    text: 'Forget password',
                    color: Colors.white,
                    textSize: 30,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: emailTextController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Email address',
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthButton(
                    buttonText: 'Reset now',
                    fct: () {
                      _forgetPassFCT();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
