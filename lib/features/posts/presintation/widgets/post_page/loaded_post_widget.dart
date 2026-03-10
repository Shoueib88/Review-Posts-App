import 'package:clean_architecture_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_app/features/posts/presintation/pages/post_detail_page.dart';
import 'package:flutter/material.dart';

class LoadedPostWidget extends StatelessWidget {
  final List<Post> posts;

  const LoadedPostWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.separated(
        itemCount: posts.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(thickness: 1);
        },
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(posts[index].id.toString()),
            title: Text(posts[index].title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle:
                Text(posts[index].body, style: const TextStyle(fontSize: 16)),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PostDetailPage(post: posts[index]))),
          );
        },
      ),
    );
  }
}
