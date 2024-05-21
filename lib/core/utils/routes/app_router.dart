import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_analyzer/core/services/service_locator.dart';
import 'package:the_analyzer/features/auth/views/forget_password_with_email_screen.dart';
import 'package:the_analyzer/features/auth/views/login_by_email_screen.dart';
import 'package:the_analyzer/features/auth/views/otp_screen.dart';
import 'package:the_analyzer/features/auth/views/reset_password_screen.dart';
import 'package:the_analyzer/features/auth/views/sign_up_by_email_screen.dart';
import 'package:the_analyzer/features/auth/views/success_screen.dart';
import 'package:the_analyzer/features/search_free/data/repository/search_results_repo.dart';
import 'package:the_analyzer/features/search_free/logic/free_search_result_cubit/search_result_cubit.dart';
import 'package:the_analyzer/features/search_free/views/free_search_result_screen.dart';
import 'package:the_analyzer/features/search_vip/data/repository/search_results_repo.dart';
import 'package:the_analyzer/features/search_vip/logic/search_cubit/search_cubit.dart';
import 'package:the_analyzer/features/search_vip/logic/search_result_cubit/search_result_cubit.dart';
import 'package:the_analyzer/features/search_vip/views/search_result_screen.dart';
import 'package:the_analyzer/features/search_vip/views/search_screen.dart';
import 'package:the_analyzer/features/subscribtion/views/subscribtion_plan_screen.dart';

abstract class AppRouter {
  static const String kOtpView = '/OtpView';
  static const String kSuccessView = '/SuccessVeiw';
  static const String kForgetPasswordWithEmailView =
      '/ForgetPasswordWithEmailView';
  static const String kLoginByEmailView = '/LoginByEmailView';
  static const String kSignUpByEmailView = '/SignUpByEmailView';
  static const String kRestPasswordView = '/RestPasswordView';
  static const String kSearchView = '/SearchView';
  static const String kSearchResultView = '/SearchResultView';
  static const String kSubscribtionView = '/SubscribtionView';
  static const String kFreeSearchVeiw = '/FreeSearchVeiw';

  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) =>
                      SearchResultCubit(getIt.get<SearchRepo>())),
              BlocProvider(
                create: (context) => SearchCubit(getIt.get<SearchRepo>()),
              ),
            ],
            child: const SearchScreen(),
          );
        },
      ),
      GoRoute(
        path: kSignUpByEmailView,
        builder: (BuildContext context, GoRouterState state) {
          return SignUpByEmailScreen();
        },
      ),
      GoRoute(
        path: kOtpView,
        builder: (BuildContext context, GoRouterState state) {
          Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          return OtpScreen(
            title: data['title'] as String,
            forgetScreen: data['forgetscreen'] as bool,
            email: data['email'] as String?,
            phone: data['phone'] as String?,
          );
        },
      ),
      GoRoute(
        path: kSuccessView,
        builder: (BuildContext context, GoRouterState state) {
          return const SuccessScreen();
        },
      ),
      GoRoute(
        path: kForgetPasswordWithEmailView,
        builder: (BuildContext context, GoRouterState state) {
          return const ForgetPasswordWithEmailScreen();
        },
      ),
      GoRoute(
        path: kLoginByEmailView,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginByEmailScreen();
        },
      ),
      GoRoute(
        path: kRestPasswordView,
        builder: (BuildContext context, GoRouterState state) {
          Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          return ResetPasswordScreen(
            email: data['email'] as String?,
            phone: data['phone'] as String?,
          );
        },
      ),
      GoRoute(
        path: kSearchView,
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) =>
                      SearchResultCubit(getIt.get<SearchRepo>())),
              BlocProvider(
                create: (context) => SearchCubit(getIt.get<SearchRepo>()),
              ),
            ],
            child: const SearchScreen(),
          );
        },
      ),
      GoRoute(
        path: kSubscribtionView,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => SearchCubit(getIt.get<SearchRepo>()),
            child: SubscriptionPlanScreen(),
          );
        },
      ),
      GoRoute(
        path: kSearchResultView,
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SearchResultCubit(getIt.get<SearchRepo>())
                  ..getPercetageData()
                  ..getPlotingTableData()
                  ..getTweetsSampleData()
                  ..getNegativeWordsImage()
                  ..getPositiveWordsImage(),
              ),
              BlocProvider(
                create: (context) => SearchCubit(getIt.get<SearchRepo>()),
              ),
              BlocProvider(
                create: (context) =>
                    FreeSearchResultCubit(getIt.get<SearchFreeRepo>()),
              ),
            ],
            child: const SearchResultScreen(),
          );
        },
      ),
      GoRoute(
        path: kFreeSearchVeiw,
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    FreeSearchResultCubit(getIt.get<SearchFreeRepo>())
                      ..getNegativeWordsImage()
                      ..getPercetageDataFree()
                      ..getPlotingTableDataFree()
                      ..getPositiveWordsImage()
                      ..getTweetsSampleDataFree(),
              ),
            ],
            child: FreeFreeSearchResultScreen(),
          );
        },
      ),
    ],
  );
}
