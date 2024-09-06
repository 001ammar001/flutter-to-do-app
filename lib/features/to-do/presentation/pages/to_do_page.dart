import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/widgets/painter.dart';
import 'package:to_do_app/features/to-do/presentation/bloc/to_do_bloc/task_bloc.dart';
import 'package:to_do_app/features/to-do/presentation/pages/stats_page.dart';
import 'package:to_do_app/features/to-do/presentation/pages/home_page.dart';
import 'package:to_do_app/features/to-do/presentation/widgets/add_todo_button.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  int currentIndex = 0;
  final icons = [
    Icons.home,
    Icons.bar_chart_sharp,
  ];
  final homes = [
    const HomeBody(),
    const StatsBody(),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const AddTodoButton(),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: BNBCustomPainter(),
          ),
          Container(
            height: 80,
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var index = 0; index < icons.length; index++)
                  IconButton(
                    iconSize: 40,
                    icon: Icon(
                      icons[index],
                      color: currentIndex == index
                          ? Colors.black
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      changeIndex(index);
                      BlocProvider.of<TasksBloc>(context).add(GetTasksEvent());
                    },
                  ),
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: currentIndex,
          children: homes,
        ),
      ),
    );
  }

  changeIndex(index) {
    if (currentIndex != index) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}
