import 'package:flutter/material.dart';
import 'package:the_analyzer/core/constant/app_constance.dart';
import 'package:the_analyzer/core/utils/colors/app_colors.dart';
import 'package:the_analyzer/core/utils/styles/my_text.dart';
import 'package:the_analyzer/core/widget/my_elevated_button.dart';

class SubscriptionPlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(
          title: 'Subscription Plans',
          fontSize: 24,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PlanCard(
              planName: 'Basic',
              price: 'Free',
              features: const [
                'Standard search',
                'Access to limited features',
              ],
              isPremium: false,
            ),
            const SizedBox(height: 20),
            PlanCard(
              planName: 'Premium',
              price: '\$15/month',
              features: const [
                'Faster search',
                'Customize search',
                'Access to all features',
              ],
              isPremium: true,
            ),
          ],
        ),
      ),
    );
  }
}

class PlanCard extends StatefulWidget {
  final String planName;
  final String price;
  final List<String> features;
  final bool isPremium;

  PlanCard({
    required this.planName,
    required this.price,
    required this.features,
    this.isPremium = false,
  });

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(
                title: widget.planName,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: widget.isPremium ? AppColors.baseColor : AppColors.black),
            const SizedBox(height: 10),
            MyText(title: widget.price, fontSize: 20, color: AppColors.gray),
            const SizedBox(height: 10),
            ...widget.features.map((feature) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: widget.isPremium
                            ? AppColors.baseColor
                            : AppColors.navyBlue,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MyText(
                            title: feature,
                            fontSize: 16,
                            color: AppColors.black),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 20),
            widget.isPremium
                ? Center(
                    child: MyElevatedButton(
                    title: 'Subscribe',
                    onPressed: () {
                      setState(() {
                         AppConstance.isVIP = true    ;
                      });
                    // GoRouter.of(context).pop() ;
                    },
                  ))
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
