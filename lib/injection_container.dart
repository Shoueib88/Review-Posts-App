import 'package:clean_architecture_app/core/network/network_info.dart';
import 'package:clean_architecture_app/features/posts/data/data_repository.dart/post_repository_impl.dart';
import 'package:clean_architecture_app/features/posts/data/data_source.dart/local_data_source.dart';
import 'package:clean_architecture_app/features/posts/data/data_source.dart/remote_data_source.dart';
import 'package:clean_architecture_app/features/posts/domain/repositories/post_repository.dart';
import 'package:clean_architecture_app/features/posts/domain/uses_case/add_post.dart';
import 'package:clean_architecture_app/features/posts/domain/uses_case/delete_post.dart';
import 'package:clean_architecture_app/features/posts/domain/uses_case/get_all_post.dart';
import 'package:clean_architecture_app/features/posts/domain/uses_case/update_post.dart';
import 'package:clean_architecture_app/features/posts/presintation/bloc/add_delete_update_post/bloc/add_update_delete_post_bloc.dart';
import 'package:clean_architecture_app/features/posts/presintation/bloc/post/bloc/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init() async {
  ///features - posts

  //blocs

  // we use registerFactory because we want to create a new instance of the bloc every time we need it,
  // and we use registerLazySingleton because we want to create a single instance of the use case and repository
  // and data sources and core and external

  sl.registerFactory(() => PostsBloc(getAllPost: sl()));
  sl.registerFactory(() => AddUpdateDeletePostBloc(
      addPost: sl(), deletePost: sl(), updatePost: sl()));

  //use cases
  sl.registerLazySingleton(() => GetAllPostUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpDatePostUseCase(sl()));

  //repositories
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //data sources
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

  //external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  //http client
  sl.registerLazySingleton(() => http.Client());

  // Internet connection checker
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker.createInstance());

  ///core
  ///
  /// we use registerLazySingleton because we want to create a single instance of the network info and internet connection checker
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}
