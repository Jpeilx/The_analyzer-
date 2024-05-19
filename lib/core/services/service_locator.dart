import 'package:get_it/get_it.dart';
import 'package:the_analyzer/features/auth/data/repository/auth_repo.dart';
import 'package:the_analyzer/features/search/data/repository/search_results_repo.dart';

final getIt = GetIt.instance;
void setUpServiceLocator() {
  getIt.registerLazySingleton<AuthRepe>(() => AuthRepe());
  getIt.registerLazySingleton<SearchRepo>(() => SearchRepo());
}
