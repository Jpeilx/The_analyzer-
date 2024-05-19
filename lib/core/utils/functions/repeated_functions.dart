import 'package:flutter/material.dart';
import 'package:the_analyzer/core/utils/colors/app_colors.dart';

import '../styles/my_text.dart';

class RepeatedFunctions {
  static showSnackBar(
    BuildContext context, {
    required String message,
    Color? textColor,
    Color? background,
    bool error = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: MyText(
          title: message,
          fontSize: 14,
          maxLines: 3,
          color: error ? AppColors.red : AppColors.baseColor,
          textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor:
            error ? AppColors.kLightRedColor : const Color(0xffFFF9F4),
        // backgroundColor: background ?? AppColors.black,
      ),
    );
  }

  static String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds);
    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  // static Future<void> makePhoneCall(String phoneNumber) async {
  //   final Uri launchUri = Uri(
  //     scheme: 'tel',
  //     path: phoneNumber,
  //   );
  //   await launchUrl(launchUri);
  // }

  // static Future<void> launchCustomUrl(context, String? url) async {
  //   if (url != null) {
  //     Uri uri = Uri.parse(url);

  //     if (await canLaunchUrl(uri)) {
  //       await launchUrl(uri);
  //     } else {
  //       showSnackBar(context, message: 'Cannot launch $url');
  //     }
  //   }
  // }

  // static bool isArabic() => Intl.getCurrentLocale() == 'ar';
}
