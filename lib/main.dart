import 'package:clean_architecture_app/core/app_theme.dart';
import 'package:clean_architecture_app/features/posts/presintation/pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/posts/presintation/bloc/add_delete_update_post/bloc/add_update_delete_post_bloc.dart';
import 'features/posts/presintation/bloc/post/bloc/posts_bloc.dart';
import 'injection_container.dart' as di;
import 'dart:ui';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    print("------------ GLOBAL ERROR: $error");
    print("++++++++++++ STACK: $stack");
    return true;
  };
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
          BlocProvider(create: (_) => di.sl<AddUpdateDeletePostBloc>()),
        ],
        child: MaterialApp(
            theme: appTheme,
            debugShowCheckedModeBanner: false,
            home: const PostsPage()));
  }
}
