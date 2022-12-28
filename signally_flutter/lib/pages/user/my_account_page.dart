import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:signally/components/z_button.dart';
import 'package:signally/components/z_card.dart';
import 'package:signally/components/z_select_single_image.dart';
import 'package:signally/components/z_text_form_field.dart';
import 'package:signally/models/auth_user.dart';
import 'package:signally/models_providers/auth_provider.dart';
import 'package:signally/models_services/firebase_auth_service.dart';
import 'package:signally/pages/user/account_delete_page.dart';
import 'package:signally/pages/user/follow_page.dart';
import 'package:signally/pages/user/support_page.dart';

import 'subscription_page.dart';

class MyAccountPage extends StatefulWidget {
  MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  String userName = '';

  @override
  void initState() {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    userName = authProvider.authUser?.name ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final AuthUser authUser = authProvider.authUser!;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        updateUserName();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          title: Text('My Account'),
          actions: [
            IconButton(onPressed: () => Get.to(AccountDeletePage()), icon: Icon(Icons.more_vert_outlined)),
          ],
        ),
        body: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 90),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Color(0xFF2C2F38), width: 2), borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        SizedBox(height: 52),
                        Text('Change Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFFDC413))),
                        SizedBox(height: 32),
                        ZTextFormField(
                          initialValue: userName,
                          margin: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                          prefix: Image.asset('assets/images/icon_profile_textfield.png', width: 20, height: 20),
                          onSaved: (value) {},
                          onValueChanged: (v) {
                            userName = v;
                          },
                          onEditingComplete: () {
                            updateUserName();
                          },
                          onFieldSubmitted: (v) {
                            updateUserName();
                          },
                        ),
                        ZCard(
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            color: Colors.transparent,
                            onTap: () => Get.to(() => SubscriptionPage(), fullscreenDialog: true, duration: Duration(milliseconds: 100)),
                            child: Row(
                              children: [
                                Image.asset('assets/images/icon_upgrade.png', width: 40, height: 40),
                                SizedBox(width: 16),
                                Text('Upgrade Account', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                              ],
                            )),
                        ZCard(
                            color: Colors.transparent,
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            onTap: () => Get.to(() => SupportPage(), fullscreenDialog: true, duration: Duration(milliseconds: 100)),
                            child: Row(
                              children: [
                                Image.asset('assets/images/icon_phone.png', width: 40, height: 40),
                                SizedBox(width: 16),
                                Text('Support', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                              ],
                            )),
                        ZCard(
                            onTap: () => Get.to(() => FollowPage(), fullscreenDialog: true),
                            color: Colors.transparent,
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Row(
                              children: [
                                Image.asset('assets/images/icon_rate.png', width: 40, height: 40),
                                SizedBox(width: 16),
                                Text('Follow/Rate Us', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                              ],
                            )),
                        ZCard(
                            color: Colors.transparent,
                            margin: EdgeInsets.only(left: 16),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Row(
                              children: [
                                Image.asset('assets/images/icon_notification.png', width: 40, height: 40),
                                SizedBox(width: 16),
                                Text('Enable notifications', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                Spacer(),
                                Switch(
                                    value: authUser.isNotificationsEnabled,
                                    activeColor: Color(0xFFFDC413),
                                    onChanged: (v) {
                                      FirebaseAuthService.toggleNotifications(value: v);
                                    })
                              ],
                            )),
                        SizedBox(height: 24),
                        ZButton(text: 'Logout', onTap: () => FirebaseAuth.instance.signOut()),
                        SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(100)),
                    child: authUser.profileImageUrl != ''
                        ? ZSelectSingleImage(
                            imageUrl: authUser.profileImageUrl,
                            height: 115,
                            width: 115,
                            borderRadius: BorderRadius.circular(100),
                            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            onImageChange: (v) {
                              FirebaseAuthService.uploadProfilePicture(file: v);
                            },
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset('assets/images/default_profile.png', width: 115, height: 115, fit: BoxFit.cover),
                          ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  updateUserName() async {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    final AuthUser authUser = authProvider.authUser!;

    if (authUser.name == userName) return;

    String? v = await FirebaseAuthService.updateUserName(name: userName);
    if (v != null) {
      userName = v;
      setState(() {});
    }
  }
}
