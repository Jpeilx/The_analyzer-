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

class LoginByEmailScreen extends StatefulWidget {
  const LoginByEmailScreen({super.key});

  @override
  State<LoginByEmailScreen> createState() => _LoginByEmailScreenState();
}

class _LoginByEmailScreenState extends State<LoginByEmailScreen> {
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    focusNode1.addListener(() {
      setState(() {});
    });
    focusNode2.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    AuthCubit.get(context).changeStatusPassword(false);
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
                  title: "Welcome Back",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: MyText(
                    title:
                        "We are happy to see you again , enjoy exclusive features and many more.",
                    fontSize: 12,
                    textOverflow: false,
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
                  keyboardType: TextInputType.emailAddress,
                  focusNode: focusNode1,
                  isBorder: true,
                  filledColor: true,
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
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return MyText(
                        title: 'Password',
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
                      onFieldSubmitted: (p0) {
                        if (_emailController.text.isEmpty ||
                            !_emailController.text.contains('@') ||
                            !_emailController.text.contains('.')) {
                          AuthCubit.get(context).changeStatusEmail(true);
                        } else {
                          AuthCubit.get(context).changeStatusEmail(false);
                        }
                        if (_passwordController.text.isEmpty) {
                          AuthCubit.get(context).changeStatusPassword(true);
                        } else {
                          AuthCubit.get(context).changeStatusPassword(false);
                        }
                        if (_keyForm.currentState!.validate()) {
                          AuthCubit.get(context).userLogin(
                            password: _passwordController.text.trim(),
                            email: _emailController.text,
                          );
                        }
                      },
                      suffixWidget: IconButton(
                        onPressed: () {
                          AuthCubit.get(context).changeShowPassword();
                        },
                        icon: Icon(AuthCubit.get(context).showPassowrd
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                      ),
                      validator: (String? s) {
                        if (s == null || s.isEmpty) {
                          return "Please Enter Your Password";
                        }

                        return null;
                      },
                    );
                  },
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: InkWell(
                    onTap: () {
                      GoRouter.of(context)
                          .push(AppRouter.kForgetPasswordWithEmailView);
                    },
                    child: MyText(
                      title: "Forget Password",
                      fontSize: 14,
                      color: AppColors.baseColor,
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is LoginSuccessState) {
                      GoRouter.of(context).go(AppRouter.kSearchResultView);
                    }
                    if (state is LoginErrorState) {
                      RepeatedFunctions.showSnackBar(
                        context,
                        message: state.message,
                        error: true,
                      );
                    }
                  },
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return state is LoginLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : MyElevatedButton(
                              title: "Sign In",
                              fontSize: 18,
                              onPressed: () {
                                if (_emailController.text.isEmpty ||
                                    !_emailController.text.contains('@') ||
                                    !_emailController.text.contains('.')) {
                                  AuthCubit.get(context)
                                      .changeStatusEmail(true);
                                } else {
                                  AuthCubit.get(context)
                                      .changeStatusEmail(false);
                                }
                                if (_passwordController.text.isEmpty) {
                                  AuthCubit.get(context)
                                      .changeStatusPassword(true);
                                } else {
                                  AuthCubit.get(context)
                                      .changeStatusPassword(false);
                                }
                                if (_keyForm.currentState!.validate()) {
                                  AuthCubit.get(context).userLogin(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                                }
                              },
                            );
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      title: "Don't Have An Account ",
                      fontSize: 12,
                      color: AppColors.gray,
                    ),
                    InkWell(
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kSignUpByEmailView);
                      },
                      child: MyText(
                        title: 'Sign Up ',
                        fontSize: 12,
                        color: AppColors.baseColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
