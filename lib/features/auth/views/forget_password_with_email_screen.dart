import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:the_analyzer/core/utils/colors/app_colors.dart';
import 'package:the_analyzer/core/utils/functions/repeated_functions.dart';
import 'package:the_analyzer/core/utils/routes/app_router.dart';
import 'package:the_analyzer/core/utils/styles/my_text.dart';
import 'package:the_analyzer/core/widget/my_elevated_button.dart';
import 'package:the_analyzer/core/widget/my_text_field.dart';
import 'package:the_analyzer/features/auth/logic/auth_cubit/auth_cubit.dart';

class ForgetPasswordWithEmailScreen extends StatefulWidget {
  const ForgetPasswordWithEmailScreen({super.key});

  @override
  State<ForgetPasswordWithEmailScreen> createState() =>
      _ForgetPasswordWithEmailScreenState();
}

class _ForgetPasswordWithEmailScreenState
    extends State<ForgetPasswordWithEmailScreen> {
  final FocusNode focusNode1 = FocusNode();
  final TextEditingController _emailController = TextEditingController();

  var _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    focusNode1.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode1.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    AuthCubit.get(context).changeStatusEmail(false);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: null,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.w),
        child: Form(
          key: _keyForm,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 111.h,
                  width: double.infinity,
                ),
                MyText(
                  title: "Forget Password",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: MyText(
                    title: "No worries , we'll send you reset instructions",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.gray,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return MyText(
                        title: "Email",
                        color: AuthCubit.get(context).emailError
                            ? AppColors.red
                            : AppColors.black,
                      );
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                MyTextField(
                  controller: _emailController,
                  textHint: '',
                  focusNode: focusNode1,
                  isBorder: true,
                  filledColor: true,
                  keyboardType: TextInputType.emailAddress,
                  fillColor: AppColors.baseColor,
                  validator: (String? s) {
                    if (s == null || s.isEmpty) {
                      return "Please Enter Your Email";
                    }
                    if (!s.contains('.') || !s.contains('@')) {
                      return "Please Enter A Valid Email Address";
                    }
                    return null;
                  },
                  onFieldSubmitted: (p0) {
                    if (_emailController.text.isEmpty ||
                        !_emailController.text.contains('@') ||
                        !_emailController.text.contains('.')) {
                      AuthCubit.get(context).changeStatusEmail(true);
                    } else {
                      AuthCubit.get(context).changeStatusEmail(false);
                    }

                    if (_keyForm.currentState!.validate()) {
                      AuthCubit.get(context)
                          .forgetPassword(email: _emailController.text);
                    }
                  },
                ),
                SizedBox(height: 50.h),
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is ForgetPasswordSuccessState) {
                      GoRouter.of(context).push(AppRouter.kOtpView, extra: {
                        'title': "Verify Your Email",
                        'forgetscreen': true,
                        'email': _emailController.text,
                      });
                    }
                    if (state is ForgetPasswordErrorState) {
                      RepeatedFunctions.showSnackBar(
                        context,
                        message: state.message,
                        error: true,
                      );
                    }
                  },
                  child: MyElevatedButton(
                    title: "Reset Password",
                    fontSize: 18,
                    onPressed: () {
                      if (_emailController.text.isEmpty) {
                        AuthCubit.get(context).changeStatusEmail(true);
                      } else {
                        AuthCubit.get(context).changeStatusEmail(false);
                      }

                      if (_keyForm.currentState!.validate()) {
                        AuthCubit.get(context)
                            .forgetPassword(email: _emailController.text);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
