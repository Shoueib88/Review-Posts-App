import 'package:clean_architecture_app/features/posts/presintation/widgets/post_detail_page/delete_dialog_detial_widget.dart';
import 'package:clean_architecture_app/features/posts/presintation/widgets/post_detail_page/update_detial_btn.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/post.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;
  const PostDetailWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(post.title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const Divider(height: 50),
          Text(post.body, style: const TextStyle(fontSize: 16)),
          const Divider(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostBtnWidget(post: post),
              DeletePostBtnWidget(postId: post.id!)
            ],
          )
        ],
      ),
    );
  }
}
