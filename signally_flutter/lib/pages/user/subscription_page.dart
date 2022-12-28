import 'package:signally/components/z_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../components/z_card.dart';
import '../../models_providers/auth_provider.dart';
import '../../utils_constants/app_constants.dart';
import '../../utils/z_launch_url.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  bool isLoading = false;

  @override
  void initState() {
    Future.microtask(() => Provider.of<AuthProvider>(context, listen: false).checkPurchasesStatus(getPackages: true));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('Upgrade'),
      ),
      body: Stack(
        children: [
          _buildBody(),
          if (isLoading)
            GestureDetector(
              onDoubleTap: () => setState(() => isLoading = false),
              child: Container(
                color: Colors.black.withOpacity(0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(),
                    SizedBox(height: 30, width: 30, child: CircularProgressIndicator(color: Colors.orange)),
                    SizedBox(height: Get.height * 0.225),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  _buildBody() {
    final authProvider = Provider.of<AuthProvider>(context);
    final entitlementInfos = authProvider.entitlementInfo;
    final isLoadingEntitlementInfo = authProvider.isLoadingEntitlementInfo;
    final packages = authProvider.packages;

    if (isLoadingEntitlementInfo) return _buildLoading();
    // if (null == null) return _buildNoSubscription(packages);
    if (authProvider.authUser!.hasLifetime) return _buildSubscriptionLifetime();
    if (entitlementInfos == null) return _buildNoSubscription(packages);
    return _buildSubscription();
  }

  Column _buildLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(),
        SizedBox(child: CircularProgressIndicator(color: Colors.white), height: 20, width: 20),
        SizedBox(height: 8),
        Text('loading...'),
        SizedBox(height: 50),
      ],
    );
  }

  _buildNoSubscription(List<Package> packages) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Stack(
      children: [
        Scaffold(
          body: ListView(
            children: [
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Get your first \nmonth for free', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
                    SizedBox(height: 16),
                    Text('Subscribe to one of our plans below and get instant \naccess to the latest sigals for the  Forex market.'),
                  ],
                ),
              ),
              SizedBox(height: 16),
              for (var package in packages)
                ZCard(
                  onTap: () => purchasePackage(package),
                  borderRadiusColor: Color(0xFF2C2F38),
                  color: Colors.transparent,
                  child: Row(children: [
                    Image.asset('assets/images/icon_subscription_thumbs_up.png', width: 40, height: 40),
                    SizedBox(width: 16),
                    Container(
                      width: MediaQuery.of(context).size.width * .675,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${package.storeProduct.priceString}'),
                          SizedBox(height: 4),
                          _buildPackageDescription(package),
                        ],
                      ),
                    )
                  ]),
                ),
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Daily VIP Signals', style: TextStyle(fontSize: 13)),
                    SizedBox(height: 6),
                    Text('Weekly Trade Breakdown Videos', style: TextStyle(fontSize: 13)),
                    SizedBox(height: 6),
                    Text('Market Execution & Pending Order Signals', style: TextStyle(fontSize: 13)),
                    SizedBox(height: 6),
                    Text('Be Notified Before a Signal Goes out so you can prepare to enter', style: TextStyle(fontSize: 13)),
                    SizedBox(height: 6),
                    Text('Every Signal Comes With Entry Point, Stop Loss, Take profit 1-3', style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),
              SizedBox(height: 16),
              if (!authProvider.authUser!.hasActiveSubscription)
                ZButton(
                  margin: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  isLoading: authProvider.isloadingRestorePurchases,
                  text: 'Restore Purchases',
                  onTap: () => authProvider.restorePurchases(),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ZCard(
                    onTap: () {
                      ZLaunchUrl.launchUrl(AppConstants.privacyUrl);
                    },
                    color: Colors.transparent,
                    child: Text('Privacy Policy', style: TextStyle(color: Color(0xFFC1C1C1))),
                  ),
                  ZCard(
                    onTap: () {
                      ZLaunchUrl.launchUrl(AppConstants.termsUrl);
                    },
                    color: Colors.transparent,
                    child: Text('Term of Use', style: TextStyle(color: Color(0xFFC1C1C1))),
                  ),
                ],
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }

  _buildSubscriptionLifetime() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(),
        Image.asset('assets/images/active_subscription.png', height: 300),
        SizedBox(height: 24),
        Text('Congrats you have a lifetime subscription', style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Text('Continue using premium features!', style: TextStyle(fontSize: 16)),
        SizedBox(height: Get.height * 0.1),
        SizedBox(height: Get.height * 0.15),
      ],
    );
  }

  _buildSubscription() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(),
        Image.asset('assets/images/active_subscription.png', height: 300),
        SizedBox(height: 24),
        Text(
          'You have an active \nsubscription',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Get.height * 0.1),
        SizedBox(height: Get.height * 0.15),
      ],
    );
  }

  checkIfStringContainsString(String string, String substring) {
    return string.toLowerCase().contains(substring.toLowerCase());
  }

  _buildPackageDescription(Package package) {
    print(package.identifier);
    String p = package.identifier == '\$rc_monthly' ? 'Monthly subscription' : '';
    p = package.identifier == '\$rc_annual' ? '${(package.storeProduct.price / 12).toStringAsFixed(2)}/Month. Billed annually' : p;

    return Text(p, style: TextStyle(fontSize: 14));
  }

  checkIfStringContainsStringAndRemove(String string, String substring) {
    if (string.toLowerCase().contains(substring.toLowerCase())) {
      return string.replaceAll(substring, '');
    }
    return string;
  }

  void purchasePackage(Package package) async {
    try {
      isLoading = true;
      setState(() => isLoading = true);
      await Purchases.purchasePackage(package);
      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
      print(e);
    }
  }

  getCardColor(Package package) {
    if (package.packageType == PackageType.monthly) return Colors.lightBlue.shade300;
    if (package.packageType == PackageType.annual) return Colors.purple.shade400;
    return Colors.blue.shade400;
  }

  getPricePeriod(Package package) {
    if (package.packageType == PackageType.monthly) return '${package.storeProduct.priceString}/m';
    if (package.packageType == PackageType.annual) return '${package.storeProduct.priceString}/yr';
    return 'yearly';
  }

  getYearlyPackage(packages) {
    return packages.firstWhere((element) => element.packageType == PackageType.annual);
  }
}
