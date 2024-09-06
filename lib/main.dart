import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/database/database_helper.dart';
import 'package:to_do_app/core/theme/theme.dart';
import 'package:to_do_app/features/to-do/presentation/bloc/to_do_bloc/task_bloc.dart';
import 'package:to_do_app/features/to-do/presentation/pages/to_do_page.dart';
import 'package:to_do_app/core/injection_container.dart' as gitit;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.init();
  await gitit.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => gitit.sl<TasksBloc>()..add(GetTasksEvent()),
      child: MaterialApp(
        title: 'To-Do-App',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const ToDoPage(),
      ),
    );
  }
}
