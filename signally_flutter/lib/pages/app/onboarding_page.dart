import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signally/pages/app/signin_page.dart';

import '../../components/z_button.dart';
import '../../utils_constants/app_colors.dart';

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  PageController controller = PageController(viewportFraction: 1, keepPage: true);
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        PageView(
          controller: controller,
          onPageChanged: (v) {
            currentIndex = v;
            setState(() {});
          },
          children: [
            buildPage(image: onboarding[0]['image']!, title: onboarding[0]['title']!, description: onboarding[0]['description']!),
            buildPage(image: onboarding[1]['image']!, title: onboarding[1]['title']!, description: onboarding[1]['description']!),
            buildPage(image: onboarding[2]['image']!, title: onboarding[2]['title']!, description: onboarding[2]['description']!),
          ],
        ),
        Positioned(
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildDots(),
                SizedBox(height: 20),
                ZButton(
                  width: MediaQuery.of(context).size.width - 64,
                  text: 'Next',
                  onTap: () {
                    currentIndex += 1;
                    setState(() {});
                    if (currentIndex == onboarding.length) {
                      Get.offAll(() => SignInPage(), transition: Transition.fadeIn, duration: Duration(milliseconds: 300));
                      return;
                    }
                    controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                  },
                ),
              ],
            )),
      ],
    ));
  }

  Row buildDots() {
    return Row(
      children: [
        AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: currentIndex == 0 ? appYellow : Colors.white30,
          ),
          duration: Duration(seconds: 1),
          width: 12,
          height: 12,
        ),
        SizedBox(width: 8),
        AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: currentIndex == 1 ? appYellow : Colors.white30,
          ),
          duration: Duration(seconds: 1),
          width: 12,
          height: 12,
        ),
        SizedBox(width: 8),
        AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: currentIndex == 2 ? appYellow : Colors.white30,
          ),
          duration: Duration(seconds: 1),
          width: 12,
          height: 12,
        ),
      ],
    );
  }

  buildPage({required String image, required String title, required String description}) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 100),
        Container(height: 325, width: 325, child: Image.asset(image, fit: BoxFit.contain)),
        SizedBox(height: 50),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
              SizedBox(height: 24),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Text(
                  description,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, height: 1.65),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

var onboarding = [
  {
    'title': 'Trade anytime anywhere',
    'description':
        'Trade anywhere by simply login in \nand copying the trades our pros \nsend live. Updates are sent throughout the \ntrade if any modifications are needed.',
    'image': 'assets/images/onboarding_1.png',
  },
  {
    'title': 'Realistic Returns',
    'description':
        'On average our users profit 85% of \nreturns during their first month. \nWe provide a 1:2 or 1:3 R:R for each \ntrade along with real time analysis.',
    'image': 'assets/images/onboarding_2.png',
  },
  {
    'title': 'Pending Orders & Market \nExecution',
    'description': 'Our pros send pending orders along \nwith market execution orders to ensure our \nusers get a fair signal each time! ',
    'image': 'assets/images/onboarding_3.png',
  }
];
