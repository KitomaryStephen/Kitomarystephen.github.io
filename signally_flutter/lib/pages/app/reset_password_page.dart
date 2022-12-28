import 'package:flutter/material.dart';

import '../../components/z_button.dart';
import '../../components/z_text_form_field.dart';
import '../../models_services/firebase_auth_service.dart';
import '../../utils/z_validators.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      extendBody: true,
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Forgot Password', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                  SizedBox(height: 12),
                  Text(
                    'Please type in your email you used when signing up, \nwe’ll  send a verification code for authentication.',
                    style: TextStyle(fontSize: 14, height: 1.4, color: Theme.of(context).textTheme.caption!.color, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            ZTextFormField(
              prefix: Icon(Icons.email_outlined),
              labelText: 'Email',
              validator: ZValidators.email,
              onSaved: (String value) {
                email = value.toLowerCase().trim();
              },
            ),
            SizedBox(height: 64),
            ZButton(text: 'Send email', onTap: _onSubmit),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _onSubmit() async {
    if (formKey.currentState == null) return;
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setState(() => isLoading = true);

      FirebaseAuthService.resetPassword(email);

      setState(() => isLoading = false);
    }
  }
}
