import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models_providers/app_provider.dart';
import '../../models_providers/auth_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 250)).then((value) async {
      FlutterNativeSplash.remove();
      await Provider.of<AuthProvider>(context, listen: false).init();
      Provider.of<AppProvider>(context, listen: false);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: <Widget>[
        //     Center(child: Image.asset('assets/images/app_logo.png', height: 100, fit: BoxFit.cover)),
        //     SizedBox(height: 8),
        //     Text('SignalByt', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
        //   ],
        // ),
        );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
