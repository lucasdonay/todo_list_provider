import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository_impl.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';
import 'package:todo_list_provider/app/services/user/user_service_impl.dart';

import 'app_widget.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Registrando o firebaseauth
        Provider(create: (_) => FirebaseAuth.instance),
        Provider(
          create: (_) => SqliteConnectionFactory(),
          lazy: false,
        ),
        // Registrando o userRepository
        Provider(
          create: (context) => UserRepositoryImpl(
            firebaseAuth: context.read(),
          ),
        ),
        // Registrando o UserService
        Provider<UserService>(
          create: (context) => UserServiceImpl(
            UserRepository: context.read(),
          ),
        )
      ],
      child: AppWidget(),
    );
  }
}
