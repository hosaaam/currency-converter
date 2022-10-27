import 'package:currency_converter/core/remote/my_bloc_observer.dart';
import 'package:currency_converter/screens/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocOverrides.runZoned(() {
    runApp(
        const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Currency converter',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

