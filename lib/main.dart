import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userdemo_app/blocs/user/user_bloc.dart';
import 'package:userdemo_app/services/api_services.dart';
import 'package:userdemo_app/utils/app_styles.dart';

import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Manager BLoC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppStyles.primaryColor,
        scaffoldBackgroundColor: Colors.grey.shade50,
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppStyles.borderRadiusMedium),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppStyles.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => UserBloc(ApiService()),
        child: const HomePage(),
      ),
    );
  }
}
