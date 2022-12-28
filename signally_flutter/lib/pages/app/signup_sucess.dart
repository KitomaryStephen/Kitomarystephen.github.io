import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/z_button.dart';
import '../../models_providers/auth_provider.dart';

class SignUpSuccess extends StatefulWidget {
  SignUpSuccess({Key? key}) : super(key: key);

  @override
  _SignUpSuccessState createState() => _SignUpSuccessState();
}

class _SignUpSuccessState extends State<SignUpSuccess> {
  final formKey = GlobalKey<FormState>();
  String email = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      extendBody: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/signup_success.png', height: MediaQuery.of(context).size.height * 0.35),
          SizedBox(height: 16),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Your account has been \nsuccessfully created!',
              style: TextStyle(fontSize: 21, height: 1.3, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16),
          ZButton(text: 'Get Started', onTap: _onSubmit),
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
        ],
      ),
    );
  }

  void _onSubmit() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.init();
  }
}
