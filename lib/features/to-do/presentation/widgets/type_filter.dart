import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/to-do/presentation/bloc/to_do_bloc/task_bloc.dart';

class TypeFilter extends StatelessWidget {
  const TypeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      buildWhen: (previous, current) =>
          previous.getPending != current.getPending,
      builder: (context, state) {
        return SizedBox(
          width: double.maxFinite,
          child: CupertinoSlidingSegmentedControl(
            groupValue: state.getPending,
            thumbColor: Colors.black,
            children: {
              true: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Pending",
                  style: TextStyle(
                    fontSize: 16,
                    color: state.getPending ? Colors.white : Colors.black,
                  ),
                ),
              ),
              false: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Done",
                  style: TextStyle(
                    fontSize: 16,
                    color: !state.getPending ? Colors.white : Colors.black,
                  ),
                ),
              ),
            },
            onValueChanged: (value) {
              context.read<TasksBloc>().add(
                    GetTasksEvent(
                      getActiveTasks: value,
                    ),
                  );
            },
          ),
        );
      },
    );
  }
}
