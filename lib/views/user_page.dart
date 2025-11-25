import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';
import 'user_detail_page.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),

      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {

          // -----------------------------
          // 🔵 ESTADO LOADING
          // -----------------------------
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // -----------------------------
          // 🔴 ESTADO ERROR
          // -----------------------------
          if (state is UserError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          // -----------------------------
          // 🟢 LISTA DE USUARIOS
          // -----------------------------
          if (state is UserListLoaded) {
            final users = state.users;

            if (users.isEmpty) {
              return const Center(child: Text("No users found"));
            }

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, index) {
                final user = users[index];

                return ListTile(
                  title: Text(user.name),
                  subtitle:
                  Text("${user.email} | Website: ${user.website}"),
                  onTap: () {
                    // Disparamos el evento
                    context
                        .read<UserBloc>()
                        .add(LoadUserById(user.id));

                    // Navegación
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const UserDetailPage(),
                      ),
                    );
                  },
                );
              },
            );
          }

          // -----------------------------
          // ⚪ ESTADO INICIAL
          // -----------------------------
          return const Center(child: Text("Loading users..."));
        },
      ),
    );
  }
}
