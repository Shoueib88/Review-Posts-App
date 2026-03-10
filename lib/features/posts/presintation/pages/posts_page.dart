import 'package:clean_architecture_app/features/posts/presintation/bloc/post/bloc/posts_bloc.dart';
import 'package:clean_architecture_app/features/posts/presintation/pages/post_add_update.dart';
import 'package:clean_architecture_app/features/posts/presintation/widgets/post_page/loaded_post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../widgets/post_page/error_message.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatActionBtn(context),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _floatActionBtn(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => PostAddUpdatePage(
                        isUpdatePost: false,
                      )));
        },
        child: const Icon(Icons.add));
  }

  AppBar _buildAppBar() {
    return AppBar(title: const Text('Posts'));
  }

  Widget _buildBody() {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is PostsStateLoading) {
          return const LoadingWidget();
        } else if (state is PostsStateLoaded) {
          return RefreshIndicator(
            onRefresh: () => _onRefresh(context),
            child: LoadedPostWidget(posts: state.posts),
          );
        } else if (state is PostsStateError) {
          return ErrorMessage(message: state.message);
        }
        return const LoadingWidget();
      },
    );
  }
}

Future<void> _onRefresh(BuildContext context) async {
  BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
}
