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

class SignUpByEmailScreen extends StatefulWidget {
  SignUpByEmailScreen({super.key});

  @override
  State<SignUpByEmailScreen> createState() => _SignUpByEmailScreenState();
}

class _SignUpByEmailScreenState extends State<SignUpByEmailScreen> {
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  var _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    focusNode1.addListener(() {
      setState(() {});
    });
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
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    _emailController.dispose();
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.w),
        child: Form(
          key: _keyForm,
          child: SingleChildScrollView(
            child: BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is RegisterSuccessState) {
                  RepeatedFunctions.showSnackBar(context,
                      message: "we send an email please verfiy and Log In");
                  GoRouter.of(context).push(AppRouter.kLoginByEmailView);
                }
                if (state is RegisterErrorState) {
                 
                  RepeatedFunctions.showSnackBar(context,
                      message: state.message, error: true);
                }
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 111.h,
                    width: double.infinity,
                  ),
                  
                  MyText(
                    title: "Create new account",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: MyText(
                      title:
                          "Create new account and start your journey with us",
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
                          title: "User Name",
                          color: AuthCubit.get(context).emailError
                              ? AppColors.red
                              : AppColors.black,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  MyTextField(
                    controller: userNameController,
                    textHint: '',
                    keyboardType: TextInputType.emailAddress,
                    isBorder: true,
                    filledColor: true,
                    fillColor: AppColors.baseColor,
                    validator: (String? s) {
                      if (s == null || s.isEmpty) {
                        return "Please enter your user name";
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
                  ),
                  SizedBox(height: 20.h),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return MyText(
                          title: "Password",
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
                        isError: AuthCubit.get(context).passwordError,
                        fillColor: AppColors.baseColor,
                        suffixWidget: IconButton(
                          onPressed: () {
                            AuthCubit.get(context).changeShowPassword();
                          },
                          icon: Icon(AuthCubit.get(context).showPassowrd
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                        ),
                        onChange: (value) {
                          CorrectPasswordCubit.get(context)
                              .changeTextPassword(value);
                        },
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
                          title: "Confirm Password",
                          color:
                              AuthCubit.get(context).passwordConfirmationpError
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

                      if (_passwordConfirmationController.text.isEmpty) {
                        AuthCubit.get(context)
                            .changeStatusConfirmationPassword(true);
                      } else {
                        AuthCubit.get(context)
                            .changeStatusConfirmationPassword(false);
                      }
                      if (_keyForm.currentState!.validate()) {
                        AuthCubit.get(context).userRegister(
                            username: userNameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            confirmPassword:
                                _passwordConfirmationController.text);
                      }
                    },
                    obscureText: true,
                    fillColor: AppColors.baseColor,
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
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return state is RegisterLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : MyElevatedButton(
                              title: "Create",
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

                                if (_passwordConfirmationController
                                    .text.isEmpty) {
                                  AuthCubit.get(context)
                                      .changeStatusConfirmationPassword(true);
                                } else {
                                  AuthCubit.get(context)
                                      .changeStatusConfirmationPassword(false);
                                }
                                if (_keyForm.currentState!.validate()) {
                                  AuthCubit.get(context).userRegister(
                                      username: userNameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      confirmPassword:
                                          _passwordConfirmationController.text);
                                }
                              },
                            );
                    },
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        title: ' Already have an account ? ',
                        fontSize: 12,
                        color: AppColors.gray,
                      ),
                      InkWell(
                        onTap: () {
                          GoRouter.of(context)
                              .push(AppRouter.kLoginByEmailView);
                        },
                        child: MyText(
                          title: "Sign In",
                          fontSize: 12,
                          color: AppColors.baseColor,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
