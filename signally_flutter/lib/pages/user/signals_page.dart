import 'package:blurrycontainer/blurrycontainer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:signally/components/z_button.dart';
import 'package:signally/components/z_card.dart';
import 'package:signally/models/signal.dart';
import 'package:signally/models_providers/app_provider.dart';
import 'package:signally/models_providers/auth_provider.dart';
import 'package:signally/pages/user/subscription_page.dart';

import '../../components/z_text_form_field_search.dart';
import '../../models/auth_user.dart';
import '../../utils/z_format.dart';

class SignalsPage extends StatefulWidget {
  SignalsPage({Key? key}) : super(key: key);

  @override
  State<SignalsPage> createState() => _SignalsPageState();
}

class _SignalsPageState extends State<SignalsPage> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final signals = getFilteredSignals(search, appProvider.signals);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final AuthUser authUser = authProvider.authUser!;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(backgroundColor: Colors.transparent, foregroundColor: Colors.transparent, title: Text('Signals')),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (authUser.hasActiveSubscription)
                ZSearch(
                  onValueChanged: (v) {
                    setState(() => search = v);
                  },
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              Expanded(
                child: ListView.builder(
                  itemCount: signals.length,
                  itemBuilder: ((context, index) => buildSignalContainer(signals[index])),
                ),
              ),
            ],
          ),
          if (!authUser.hasActiveSubscription)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: ZButton(text: 'Get Access', onTap: () => Get.to(() => SubscriptionPage(), fullscreenDialog: true)),
            )
        ],
      ),
    );
  }

  List<Signal> getFilteredSignals(String s, List<Signal> signals) {
    if (s == '') return signals;

    return signals.where((signal) {
      return signal.symbol.toLowerCase().contains(s.toLowerCase());
    }).toList();
  }

  buildSignalContainer(Signal signal) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final AuthUser authUser = authProvider.authUser!;
    final hasComment = signal.comment != '';
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xFF1F2127)),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          Container(
              height: authUser.hasActiveSubscription
                  ? null
                  : hasComment
                      ? 220
                      : 190,
              padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(ZFormat.dateFormatSignal(signal.signalDatetime), style: TextStyle(color: Color(0xFFA9A9A9), fontSize: 10)),
                      Spacer(),
                      ZCard(
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                          borderRadiusColor: signal.isActive ? Colors.green : Colors.grey,
                          borderWidth: 2,
                          margin: EdgeInsets.symmetric(),
                          child: Text(signal.isActive ? 'Open' : 'Closed',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                              ))),
                      if (signal.isFree) SizedBox(width: 6),
                      if (signal.isFree)
                        ZCard(
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                            borderRadiusColor: signal.isActive ? Colors.green : Colors.grey,
                            borderWidth: 2,
                            margin: EdgeInsets.symmetric(),
                            child: Text(signal.isFree ? 'Free' : 'Paid',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontStyle: FontStyle.italic,
                                ))),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(signal.getIconPath, width: 30, height: 30),
                      SizedBox(width: 10),
                      Text(signal.symbol),
                      SizedBox(width: 6),
                      Image.asset(signal.getIconArrow, width: 25, height: 50),
                      SizedBox(width: 8),
                      Spacer(),
                    ],
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildSignalItem(title: signal.getEntryText, value: '${ZFormat.toPrecision(signal.stopLoss, 6)}'),
                        buildSignalItem(
                            title: 'Stop \nLoss', value: '${ZFormat.toPrecision(signal.stopLoss, 6)}', type: signal.type, isStopLoss: true),
                        buildSignalItem(title: 'Take \nProfit1', value: '${ZFormat.toPrecision(signal.takeProfit1, 6)}'),
                        buildSignalItem(title: 'Take \nProfit2', value: '${ZFormat.toPrecision(signal.takeProfit2, 6)}'),
                      ],
                    ),
                  ),
                  if (hasComment) Divider(),
                  if (authUser.hasActiveSubscription && hasComment)
                    Text(
                      signal.comment,
                      style: TextStyle(
                          color: signal.type == 'Bull' ? Color(0xFFFDC413) : Color(0xFF02CFFF),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic),
                    ),
                ],
              )),
          if (!authUser.hasActiveSubscription && !signal.isFree)
            Container(
              child: BlurryContainer(
                child: Container(child: Center(child: Image.asset('assets/images/lock.png', width: 30, height: 30))),
                blur: 5,
                width: MediaQuery.of(context).size.width,
                height: hasComment ? 220 : 190,
                elevation: 0,
                color: Colors.transparent,
                padding: const EdgeInsets.all(8),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
            )
        ],
      ),
    );
  }

  Expanded buildSignalItem({required String title, required String value, String type = 'Bull', isStopLoss = false}) {
    Color textColor = (isStopLoss && type == 'Bull')
        ? Color(0xFF0AD61E)
        : (isStopLoss && type == 'Bear')
            ? Color(0xFFFF0002)
            : Colors.white;
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Color(0xFFA9A9A9), fontSize: 10)),
        SizedBox(height: 8),
        Text(value, style: TextStyle(fontSize: 13, color: textColor)),
      ],
    ));
  }
}
