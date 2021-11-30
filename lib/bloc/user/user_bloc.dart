import 'dart:math';
import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:test_list_app/models/image_model.dart';
import 'package:test_list_app/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final httpClient = http.Client();

  UserBloc() : super(const UserState()) {
    on<DataLoading>(_mapDataLoadingToState);
  }
  Future<void> _mapDataLoadingToState(
      DataLoading event, Emitter<UserState> emit) async {
    try {
      List<UserImage> images = [];
      final User? user = event.user ?? await _getUser(httpClient, event.id);
      if (event.user == null) {
        images = await _getImages(httpClient);
      }
      emit(state.copyWith(
          status: UserStatus.success, user: user, images: images));
    } catch (e) {
      emit(state.copyWith(status: UserStatus.failure));
    }
  }
}

Future<User> _getUser(httpClient, id) async {
  Uri uri = Uri.https("jsonplaceholder.typicode.com", "/users/$id");
  final response = await httpClient.get(uri);
  if (response.statusCode == 200) {
    final data = json.decode(response.body) as Map<String, dynamic>;
    return User.fromJson(data);
  }
  throw Exception('error fetching user');
}

Future<List<UserImage>> _getImages(httpClient) async {
  final Random rnd = Random();
  int min = 1;
  int max = 4997;
  int startIndex = min + rnd.nextInt(max - min);
  int imageLimit = 3;

  Uri uri = Uri.https(
    "jsonplaceholder.typicode.com",
    "/photos",
    <String, String>{'_start': '$startIndex', '_limit': '$imageLimit'},
  );
  final response = await httpClient.get(uri);
  if (response.statusCode == 200) {
    final body = json.decode(response.body) as List;
    return body.map((data) {
      return UserImage.fromJson(data);
    }).toList();
  }
  throw Exception('error fetching user');
}
