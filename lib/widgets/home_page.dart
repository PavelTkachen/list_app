import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_list_app/bloc/page/page_bloc.dart';
import 'package:test_list_app/widgets/widgets/list_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) {
        switch (state.status) {
          case PageStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case PageStatus.success:
            if (state.posts.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return Center(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return PostListItem(post: state.posts[index]);
                },
                itemCount: state.posts.length,
              ),
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
