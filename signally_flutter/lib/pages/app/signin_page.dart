import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:signally/pages/app/signup_page.dart';

import '../../components/z_button.dart';
import '../../components/z_card.dart';
import '../../components/z_text_form_field.dart';
import '../../models_providers/auth_provider.dart';
import '../../models_providers/navbar_provider.dart';
import '../../models_services/firebase_auth_service.dart';
import '../../utils/z_validators.dart';
import '../../utils_constants/app_colors.dart';
import 'reset_password_page.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void didChangeDependencies() {
    Future.microtask(() => Provider.of<NavbarProvider>(context, listen: false).selectedPageIndex = 1);
    super.didChangeDependencies();
  }

  final formKey = GlobalKey<FormState>();
  String userEmail = '';
  String userPassword = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 48),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Sign in to Signally', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)), SizedBox(height: 12)],
              ),
            ),
            SizedBox(height: 16),
            ZCard(
                borderRadiusColor: Color(0xFF2C2F38),
                borderWidth: 2,
                width: MediaQuery.of(context).size.width - 32,
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                color: Color(0xFF1E1E1E),
                child: Row(
                  children: [
                    Expanded(
                      child: ZCard(
                        margin: EdgeInsets.only(left: 2, top: 0, bottom: 0, right: 0),
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 9),
                        color: Color(0xFF2C2F38),
                        child: Center(child: Text('Sign in')),
                      ),
                    ),
                    Expanded(
                      child: ZCard(
                        onTap: () => Get.to(
                          () => SignUpPage(),
                          fullscreenDialog: true,
                          transition: Transition.fadeIn,
                          duration: Duration(milliseconds: 200),
                        ),
                        width: MediaQuery.of(context).size.width * 0.436,
                        margin: EdgeInsets.only(left: 2, top: 0, bottom: 0, right: 0),
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 9),
                        color: Colors.transparent,
                        child: Center(child: Text('Sign up')),
                      ),
                    )
                  ],
                )),
            SizedBox(height: 24),
            ZTextFormField(
              prefix: Icon(Icons.email_outlined, color: Colors.white54),
              labelText: 'Email',
              validator: ZValidators.email,
              keyboardType: TextInputType.emailAddress,
              onSaved: (String value) {
                userEmail = value.toLowerCase().trim();
              },
            ),
            ZTextFormField(
              prefix: Icon(Icons.lock, color: Colors.white54),
              labelText: 'Password',
              obscureText: true,
              onSaved: (String value) {
                userPassword = value;
              },
              validator: ZValidators.password,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ZCard(
                  margin: EdgeInsets.only(left: 4),
                  color: Colors.transparent,
                  onTap: () => Get.to(() => ResetPasswordPage(), fullscreenDialog: true),
                  child: Text('Forgot password?', style: TextStyle(color: appYellow, fontSize: 14, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            SizedBox(height: 12),
            ZButton(isLoading: isLoading, text: 'Sign in', onTap: _onSubmit),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Or login with', style: TextStyle(color: Color(0xFF777777))),
              ],
            ),
            SizedBox(height: 24),
            if (Platform.isIOS)
              ZCard(
                  onTap: () async {
                    var res = await FirebaseAuthService.signInWithApple();
                    if (res != null) authProvider.init();
                  },
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/apple.png', width: 20, height: 20),
                      SizedBox(width: 4),
                      Text('Sign in with Apple', style: TextStyle(color: Colors.black, fontSize: 13))
                    ],
                  )),
            SizedBox(height: 16),
            ZCard(
                onTap: () async {
                  var res = await FirebaseAuthService.signInWithGoogle();
                  if (res != null) authProvider.init();
                },
                width: (Platform.isIOS) ? MediaQuery.of(context).size.width * 0.435 : MediaQuery.of(context).size.width * 0.91,
                margin: EdgeInsets.symmetric(horizontal: 16),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/google.png', width: 20, height: 20),
                    SizedBox(width: 4),
                    Text('Sign in with Google', style: TextStyle(color: Colors.black, fontSize: 13))
                  ],
                )),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _onSubmit() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (formKey.currentState == null) return;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() => isLoading = true);

      print('$userEmail $userPassword');

      await authProvider.signInWithEmailAndPassword(userEmail, userPassword);
      setState(() => isLoading = false);
    }
  }
}
