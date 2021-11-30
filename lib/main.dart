import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_list_app/bloc/page/page_bloc.dart';
import 'package:test_list_app/widgets/widgets.dart';

void main() async {
  runApp(BlocProvider<PageBloc>(
    create: (context) {
      return PageBloc()..add(DataLoading());
    },
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Post List',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: const Color(0xFF6E24A9),
            brightness: Brightness.light,
            fontFamily: 'RobotoCondensed'),
        home: Scaffold(
          appBar: AppBar(title: const Text("Posts list app")),
          body: BlocBuilder<PageBloc, PageState>(
            builder: (context, state) {
              switch (state.status) {
                case PageStatus.success:
                  return const HomePage();
                case PageStatus.failure:
                  return const ErrorPage();
                default:
                  return const SplashScreen();
              }
            },
          ),
        ));
  }
}
