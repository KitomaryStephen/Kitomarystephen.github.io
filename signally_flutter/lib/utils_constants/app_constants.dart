import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String BASE_URL_PROD = dotenv.get('BASE_URL_PROD', fallback: '');

  static String REVENUECAT_ANDROID_KEY = dotenv.get('REVENUECAT_ANDROID_KEY', fallback: 't');
  static String REVENUECAT_IOS_KEY = dotenv.get('REVENUECAT_IOS_KEY', fallback: '');

  static String privacyUrl = 'https://www.signally.com/general-5-1';
  static String termsUrl = 'https://www.signally.com/general-5';
  static String websiteUrl = 'https://www.signally.com/';

  static String facebookUrl = 'https://www.Facebook.com/signally';
  static String twitterUrl = 'https://www.twitter.com/signally';
  static String instagramUrl = 'https://www.Instagram.com/signally';

  static String googlePlayUrl = 'https://play.google.com/store/apps/details?id=com.codememory.signally';
  static String appleAppStoreUrl = 'https://apps.apple.com/us/app/durable-blast-parts-ai/id1609886313';

  static String shareApp = 'Check out Signally \n\n ${appleAppStoreUrl} \n\n${googlePlayUrl}';
}
