import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hsos/authentication/auth_bloc.dart';
import 'package:hsos/authentication/login_page.dart';
import 'package:hsos/theme/theme.dart';
import 'package:osca_dart/app/osca_app_api.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<OscaAppApi>(
      create: (_) => OscaAppApi(),
      child: BlocProvider<AuthBloc>(
        create: (BuildContext context) {
          return AuthBloc(context.read<OscaAppApi>());
        },
        child: MaterialApp(
          title: 'Osca',
          theme: lightTheme,
          darkTheme: darkTheme,
          home: LoginPage(),
        ),
      ),
    );
  }
}