import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_analyzer/features/auth/logic/correct_password_cubit/correct_password_cubit.dart';
import 'package:the_analyzer/features/auth/views/widgets/text_validation.dart';

class ValidationError extends StatelessWidget {
  final TextEditingController controller;
  const ValidationError({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CorrectPasswordCubit, CorrectPasswordState>(
      builder: (context, state) {
        if (CorrectPasswordCubit.get(context).textPassword == null) {
          return const SizedBox();
        }

        bool atLeast8Characters = controller.text.length >= 8;

        bool containsSymbol =
            controller.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

        bool containsNumber = controller.text.contains(RegExp(r'[0-9]'));

        bool containsUpercase = controller.text.contains(RegExp(r'[A-Z]'));

        return Column(
          children: [
            SizedBox(height: 10.h),
            TextValidation(
              title: atLeast8Characters &&
                      (containsSymbol || containsNumber) &&
                      containsUpercase
                  ? "Password strength strong"
                  : "Password wtrength weak",
              success: atLeast8Characters &&
                      (containsSymbol || containsNumber) &&
                      containsUpercase
                  ? true
                  : false,
            ),
            SizedBox(height: 5.h),
            TextValidation(
              title: "At Least 8 characters",
              success: atLeast8Characters,
            ),
            SizedBox(height: 5.h),
            TextValidation(
              title: "Contains a number or symbol",
              success: containsNumber || containsSymbol,
            ),
            SizedBox(height: 5.h),
            TextValidation(
              title: "Contains a one characters upper case",
              success: containsUpercase,
            ),
          ],
        );
      },
    );
  }
}
