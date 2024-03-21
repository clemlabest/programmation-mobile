import 'package:flutter/material.dart';
import 'app_content.dart'; // Assurez-vous que ce chemin est correct.
import 'BloC/navigation_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => NavigationBloc(),
      child: const MyApp(),
    ),
  );
}
