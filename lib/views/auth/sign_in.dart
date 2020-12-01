import 'package:flutter/material.dart';
import '../../Views/auth/decoration_functions.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'logo.dart';
import './sign_in_up_bar.dart';
import '../../config/palette.dart';

class SignIn extends StatelessWidget {
  const SignIn({
    Key key,
    @required this.onRegisterClicked,
  }) : super(key: key);

  final VoidCallback onRegisterClicked;

  @override
  Widget build(BuildContext context) {
    final isSubmiting = context.isSubmitting();
    return SignInForm(
        child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.topLeft,
              child: LoginLogo(
                image: 'assets/images/logo-white.png',
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: EmailTextFormField(
                    decoration: signInInputDecoration(hintText: 'Email'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: PasswordTextFormField(
                    decoration: signInInputDecoration(hintText: 'Password'),
                  ),
                ),
                SignInBar(
                  isLoading: isSubmiting,
                  label: 'Sign in ',
                  onPressed: () {
                    context.signInWithEmailAndPassword();
                  },
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      onRegisterClicked?.call();
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: Palette.darkPink,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
