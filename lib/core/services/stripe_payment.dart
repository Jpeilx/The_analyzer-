// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

// class StripeService {
//   Future initPaymentSheet({required String clientSecret}) async {
//     await Stripe.instance.initPaymentSheet(
//       paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: clientSecret,
//           merchantDisplayName: 'Topz',
//           style: ThemeMode.light),
//     );
//   }

//   Future displayPaymentSheet() async {
//     await Stripe.instance.presentPaymentSheet();
//   }

//   Future makePayment({required String clientSecret}) async {
//     await initPaymentSheet(clientSecret: clientSecret);
//     await displayPaymentSheet();
//   }
// }
