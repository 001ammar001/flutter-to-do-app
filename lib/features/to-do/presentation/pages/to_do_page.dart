import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/widgets/floating_button.dart';
import 'package:to_do_app/core/widgets/painter.dart';
import 'package:to_do_app/features/to-do/presentation/bloc/to_do_bloc/task_bloc.dart';
import 'package:to_do_app/features/to-do/presentation/pages/calendar_body.dart';
import 'package:to_do_app/features/to-do/presentation/pages/home_body.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  final icons = [
    Icons.home,
    Icons.calendar_month,
    Icons.bar_chart_sharp,
    Icons.person
  ];
  final homes = [
    const HomeBody(),
    const CalendarBody(),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: key,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            homes[currentIndex],
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                width: size.width,
                height: 80,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CustomPaint(
                      size: Size(size.width, 80),
                      painter: BNBCustomPainter(),
                    ),
                    const FlotingButton(),
                    SizedBox(
                      width: size.width,
                      height: 80,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(12),
                        scrollDirection: Axis.horizontal,
                        itemCount: icons.length,
                        itemBuilder: (context, index) => IconButton(
                            icon: Icon(
                              icons[index],
                              color: currentIndex == index
                                  ? Colors.black
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              changeIndex(index);
                              switch (index) {
                                case 0:
                                  BlocProvider.of<TaskBloc>(context)
                                      .add(GetPedningTasksEvent());
                                case 1:
                                  BlocProvider.of<TaskBloc>(context)
                                      .add(GetPedningTasksEvent());
                              }
                            }),
                        separatorBuilder: (context, index) {
                          if (index == 1) {
                            return SizedBox(
                              width: size.width * 0.25,
                            );
                          } else {
                            return SizedBox(
                              width: size.width * 0.10,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
