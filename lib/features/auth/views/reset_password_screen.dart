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
import 'package:the_analyzer/features/auth/logic/correct_password_cubit/correct_password_cubit.dart';
import 'package:the_analyzer/features/auth/views/widgets/validation_error.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? email;
  final String? phone;
  const ResetPasswordScreen({super.key, this.email, this.phone});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  var _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    focusNode2.addListener(() {
      setState(() {});
    });
    focusNode3.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode2.dispose();
    focusNode3.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    CorrectPasswordCubit.get(context).textPassword = null;
    AuthCubit.get(context).changeStatusPassword(false);
    AuthCubit.get(context).changeStatusEmail(false);
    AuthCubit.get(context).changeStatusConfirmationPassword(false);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: null,
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordLoadingState) {
            // AppLoaderDialog.show(context);
          }
          if (state is ResetPasswordSuccessState) {
            //   AppLoaderDialog.hide(context);

            GoRouter.of(context).go(AppRouter.kSuccessView);
          }
          if (state is ResetPasswordErrorState) {
            //  AppLoaderDialog.hide(context);
            RepeatedFunctions.showSnackBar(
              context,
              message: state.message,
              error: true,
            );
          }
        },
        child: Padding(
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
                    title: "Set New Password",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: MyText(
                      title:
                          "your new password must be different from previously used password",
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
                          title: "password",
                          color: AuthCubit.get(context).passwordError
                              ? AppColors.red
                              : AppColors.black,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return MyTextField(
                        controller: _passwordController,
                        textHint: '',
                        filledColor: true,
                        focusNode: focusNode2,
                        isBorder: true,
                        maxLines: 1,

                        obscureText: AuthCubit.get(context).showPassowrd,
                        fillColor: AppColors.baseColor,
                        onChange: (value) {
                          CorrectPasswordCubit.get(context)
                              .changeTextPassword(value);
                        },
                        isError: AuthCubit.get(context).passwordError,
                        suffixWidget: IconButton(
                          onPressed: () {
                            AuthCubit.get(context).changeShowPassword();
                          },
                          icon: Icon(AuthCubit.get(context).showPassowrd
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                        ), //Please Enter Your Password
                      );
                    },
                  ),
                  ValidationError(controller: _passwordController),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return MyText(
                          title: "Confirm password",
                          color: AuthCubit.get(context).passwordError
                              ? AppColors.red
                              : AppColors.black,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  MyTextField(
                    controller: _passwordConfirmationController,
                    textHint: '',
                    filledColor: true,
                    focusNode: focusNode3,
                    isBorder: true,
                    maxLines: 1,
                    obscureText: AuthCubit.get(context).showPassowrd,
                    fillColor: AppColors.baseColor,
                    onFieldSubmitted: (p0) {
                      if (_passwordController.text.isEmpty) {
                        AuthCubit.get(context).changeStatusPassword(true);
                      } else {
                        AuthCubit.get(context).changeStatusPassword(false);
                      }
                      if (_passwordConfirmationController.text.isEmpty) {
                        AuthCubit.get(context)
                            .changeStatusConfirmationPassword(true);
                      } else {
                        AuthCubit.get(context)
                            .changeStatusConfirmationPassword(false);
                      }
                      if (_keyForm.currentState!.validate()) {
                        // AuthCubit.get(context).resetPassword(
                        //     email: widget.email,
                        //     phone: widget.phone,
                        //     password: _passwordController.text,
                        //     confirmPassword:
                        //         _passwordConfirmationController.text);
                      }
                    },
                    validator: (String? s) {
                      if (s == null || s.isEmpty) {
                        return "Please enter your confirmation password";
                      }

                      if (s != _passwordController.text) {
                        return "Password do not match";
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 50.h),
                  MyElevatedButton(
                    title: "Confirm password",
                    fontSize: 18,
                    onPressed: () {
                      if (_passwordController.text.isEmpty) {
                        AuthCubit.get(context).changeStatusPassword(true);
                      } else {
                        AuthCubit.get(context).changeStatusPassword(false);
                      }
                      if (_passwordConfirmationController.text.isEmpty) {
                        AuthCubit.get(context)
                            .changeStatusConfirmationPassword(true);
                      } else {
                        AuthCubit.get(context)
                            .changeStatusConfirmationPassword(false);
                      }
                      if (_keyForm.currentState!.validate()) {
                        // AuthCubit.get(context).resetPassword(
                        //     email: widget.email,
                        //     phone: widget.phone,
                        //     password: _passwordController.text,
                        //     confirmPassword:
                        //         _passwordConfirmationController.text);
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
