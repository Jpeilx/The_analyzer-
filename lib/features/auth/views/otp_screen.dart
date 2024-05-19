import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:the_analyzer/core/utils/colors/app_colors.dart';
import 'package:the_analyzer/core/utils/functions/repeated_functions.dart';
import 'package:the_analyzer/core/utils/routes/app_router.dart';
import 'package:the_analyzer/core/utils/styles/my_text.dart';
import 'package:the_analyzer/core/widget/my_elevated_button.dart';
import 'package:the_analyzer/features/auth/logic/auth_cubit/auth_cubit.dart';

class OtpScreen extends StatefulWidget {
  final String title;
  final bool forgetScreen;
  final String? email;
  final String? phone;

  const OtpScreen(
      {super.key,
      required this.title,
      required this.forgetScreen,
      this.email,
      this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final StopWatchTimer _stopWatchTimer;
  String? code;

  @override
  void initState() {
    _stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countDown);
    _stopWatchTimer.setPresetMinuteTime(1);
    _stopWatchTimer.setPresetSecondTime(12);

    _stopWatchTimer.onStartTimer();

    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 111.h,
                width: double.infinity,
              ),
           
              MyText(
                title: widget.title,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 10.h),
              MyText(
                title: "Enter OTP Code Sent To",
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.gray,
                textAlign: TextAlign.center,
              ),
              MyText(
                title: widget.email != null
                    ? '${widget.email}'
                    : '${widget.phone}',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.gray,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 35.h),
              StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: 0,
                builder: (context, snap) {
                  final value = snap.data;
                  final displayTime = value == null
                      ? ''
                      : StopWatchTimer.getDisplayTime(
                          value,
                          milliSecond: false,
                          hours: false,
                        );
                  return Column(
                    children: [
                      MyText(
                        title: displayTime,
                        color: AppColors.navyBlue,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 10.h),
                      value != null && value != 0
                          ? const SizedBox()
                          : InkWell(
                              onTap: () {
                                _stopWatchTimer.onResetTimer();
                                _stopWatchTimer.onStartTimer();
                              },
                              child: MyText(
                                title: 'Send again',
                                color: AppColors.baseColor,
                                fontSize: 14,
                              ),
                            )
                    ],
                  );
                },
              ),
              SizedBox(height: 20.h),
              myPinput(),
              SizedBox(height: 50.h),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is VerifyAccoutSuccessState) {
                    if (widget.forgetScreen) {
                      GoRouter.of(context).push(AppRouter.kRestPasswordView,
                          extra: {
                            'email': widget.email,
                            'phone': widget.phone
                          });
                      //  AppLoaderDialog.hide(context);
                    } else {
                      GoRouter.of(context).go(AppRouter.kLoginByEmailView);
                      //  AppLoaderDialog.hide(context);
                    }
                  }
                  if (state is VerifyAccoutLoadingState) {
                    //  AppLoaderDialog.show(context);
                  }
                  if (state is VerifyAccoutErrorState) {
                    // AppLoaderDialog.hide(context);
                    RepeatedFunctions.showSnackBar(context,
                        message: state.message, error: true);
                  }
                },
                builder: (context, state) {
                  return state is VerifyAccoutLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.baseColor,
                          ),
                        )
                      : MyElevatedButton(
                          title: 'Verify',
                          fontSize: 18,
                          onPressed: () {
                            if (widget.email != null) {
                              print(code);
                              // AuthCubit.get(context).verifyUserAccount(
                              //     code: code ?? '', email: widget.email);
                            } else {
                              // AuthCubit.get(context).verifyUserAccount(
                              //     code: code ?? '', email: widget.phone);
                            }
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myPinput() {
    final defaultPinTheme = PinTheme(
      width: 60.r,
      height: 60.r,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: AppColors.white2,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(10.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: AppColors.baseColor.withOpacity(.05),
      border: Border.all(color: AppColors.baseColor),
      borderRadius: BorderRadius.circular(10.r),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
        // decoration: defaultPinTheme.decoration.copyWith(
        //   color: Color.fromRGBO(234, 239, 243, 1),
        // ),
        );

    return Pinput(
      pinAnimationType: PinAnimationType.fade,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      validator: (s) {
        if (s == '') {
          return "you should enter verfication code";
        }
        return null;
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) {
        code = pin;
      },
    );
  }
}
