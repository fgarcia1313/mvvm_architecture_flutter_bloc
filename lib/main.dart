import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'services/user_service.dart';
import 'blocs/user/user_bloc.dart';
import 'views/user_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // ---------------------------
        // 1. Registrar el Service
        // ---------------------------
        RepositoryProvider<UserService>(
          create: (_) => UserService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // ---------------------------
          // 2. Registrar el BLoC
          // ---------------------------
          BlocProvider<UserBloc>(
            create: (context) {
              final service = context.read<UserService>();
              return UserBloc(service); // inicia con LoadUsers()
            },
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BLoC Example',
          home: const UserPage(),
        ),
      ),
    );
  }
}
