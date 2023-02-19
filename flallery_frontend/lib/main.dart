import 'package:flallery_frontend/blocs/auth_bloc.dart';
import 'package:flallery_frontend/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => AuthBloc(),
        child: RegisterScreen(),
      ),
    );
  }
}