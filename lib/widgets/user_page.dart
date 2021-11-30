import 'package:flutter/material.dart';
import 'package:test_list_app/bloc/user/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_list_app/models/image_model.dart';
import 'package:test_list_app/models/user_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:test_list_app/widgets/user_edit.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key, this.id}) : super(key: key);
  final int? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc()..add(DataLoading(id: id, user: null)),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          print("STATEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEee ${state.user}");
          final User? user = state.user;
          final List<UserImage>? images = state.images;
          return user != null && images != null
              ? UserCard(user, images)
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard(this.user, this.images, {Key? key}) : super(key: key);
  final User user;
  final List<UserImage> images;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Пользователь",
                ),
                Tab(
                  text: "Компания",
                ),
                Tab(
                  text: "Адрес",
                ),
                Tab(text: "Фото"),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Column(
                    children: [
                      Text("Name: ${user.name}"),
                      Text("Username: ${user.username}"),
                      Text("Email: ${user.email}"),
                      Text("Phone: ${user.phone}"),
                      Text("Website: ${user.website}"),
                      TextButton(
                        child: const Text('Edit user'),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => UserBloc(),
                                    child: UserEdit(user: user),
                                  )));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Column(
                    children: [
                      Text("Name: ${user.company?.name}"),
                      Text("Catch phrase: ${user.company?.catchPhrase}"),
                      Text("BS: ${user.company?.bs}"),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: Column(
                    children: [
                      Text("Street: ${user.address?.street}"),
                      Text("Suite: ${user.address?.suite}"),
                      Text("City: ${user.address?.city}"),
                      Text("Zipcode: ${user.address?.zipcode}"),
                      Text(
                          "Geo: ${user.address?.geo?.lat} ${user.address?.geo?.lng}"),
                    ],
                  ),
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 400.0,
                ),
                items: images.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Image.network(image.url ?? ""));
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
