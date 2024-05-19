import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:the_analyzer/core/network/local/cache_helper.dart';
import 'package:the_analyzer/core/network/remote/dio_helper/dio_helper.dart';
import 'package:the_analyzer/core/services/service_locator.dart';
import 'package:the_analyzer/core/utils/colors/app_colors.dart';
import 'package:the_analyzer/core/utils/routes/app_router.dart';
import 'package:the_analyzer/core/widget/bloc_observer.dart';
import 'package:the_analyzer/features/auth/data/repository/auth_repo.dart';
import 'package:the_analyzer/features/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:the_analyzer/features/auth/logic/correct_password_cubit/correct_password_cubit.dart';
import 'package:the_analyzer/features/on_boarding/logic/on_boarding_cubit/on_boarding_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  setUpServiceLocator();
  await CacheHelper.init();
  await ScreenUtil.ensureScreenSize();
  //Stripe.publishableKey = AppConstance.stripePublishableKey;
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      designSize: Size(
          MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => OnBoardingCubit()),
            BlocProvider(create: (context) => AuthCubit(getIt.get<AuthRepe>())),
            BlocProvider(create: (context) => CorrectPasswordCubit())
          ],
          child: MaterialApp.router(
            title: 'The Analyzer',
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.white,
              sliderTheme:
                  SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
              colorScheme:
                  ColorScheme.fromSwatch(primarySwatch: AppColors.appTheme)
                      .copyWith(background: AppColors.white),
            ),
          ),
        );
      },
    );
  }
}
