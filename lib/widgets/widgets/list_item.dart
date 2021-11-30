import 'package:flutter/material.dart';
import 'package:test_list_app/models/post_model.dart';
import 'package:test_list_app/widgets/user_page.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text('${post.id}', style: textTheme.caption),
        title: Text(post.title ?? ""),
        isThreeLine: true,
        subtitle: Text(post.body ?? ""),
        dense: true,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserPage(id: post.userId)));
        },
      ),
    );
  }
}