import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:test_list_app/models/post_model.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  final httpClient = http.Client();

  PageBloc() : super(const PageState()) {
    on<DataLoading>(_mapDataLoadingToState);
  }
  Future<void> _mapDataLoadingToState(
      DataLoading event, Emitter<PageState> emit) async {
    try {
      final posts = await _getPosts(httpClient);
      emit(state.copyWith(status: PageStatus.success, posts: posts));
    } catch (e) {
      emit(state.copyWith(status: PageStatus.failure));
    }
  }
}

Future<List<Post>> _getPosts(httpClient) async {
  Uri uri = Uri.https("jsonplaceholder.typicode.com", "/posts");
  final response = await httpClient.get(uri);
  if (response.statusCode == 200) {
    final body = json.decode(response.body) as List;
    return body.map((data) {
      return Post.fromJson(data);
    }).toList();
  }
  throw Exception('error fetching posts');
}
