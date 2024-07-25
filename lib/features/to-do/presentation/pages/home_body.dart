import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/to-do/presentation/bloc/to_do_bloc/task_bloc.dart';
import 'package:to_do_app/features/to-do/presentation/widgets/filter_widet.dart';
import 'package:to_do_app/features/to-do/presentation/widgets/task_card.dart';
import 'package:to_do_app/features/to-do/presentation/widgets/type_filter.dart';
import 'package:to_do_app/features/to-do/presentation/widgets/welcome_header.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<int> selectedTasksIds = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 80.0),
      child: BlocConsumer<TaskBloc, TaskStates>(
        listener: (context, state) {
          if (state is TaskSucessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is TasksLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TasksLodedState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // TODO: return Expanded in case of errors
                    WelcomeHeader(
                      taskCount: state.taskEntity.length,
                    ),
                    if (selectedTasksIds.isNotEmpty)
                      IconButton(
                        onPressed: () {
                          if (state.active) {
                            BlocProvider.of<TaskBloc>(context).add(
                              ArchiveTasksEvent(ids: selectedTasksIds),
                            );
                          } else {
                            BlocProvider.of<TaskBloc>(context).add(
                              DeleteTasksEvent(ids: selectedTasksIds),
                            );
                          }
                          setState(() {
                            selectedTasksIds = [];
                          });
                        },
                        icon: Icon(
                          state.active ? Icons.done : Icons.delete,
                          size: 25,
                        ),
                      )
                  ],
                ),
                const FilterWidget(),
                TypeFilter(active: state.active),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => TaskCard(
                      task: state.taskEntity[index],
                      selected:
                          selectedTasksIds.contains(state.taskEntity[index].id),
                      index: index,
                      fun: (index) => selectTaks(state, index),
                    ),
                    itemCount: state.taskEntity.length,
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void selectTaks(TasksLodedState state, int index) {
    return setState(
      () {
        if (selectedTasksIds.contains(state.taskEntity[index].id)) {
          selectedTasksIds.remove(state.taskEntity[index].id);
        } else {
          selectedTasksIds.add(state.taskEntity[index].id!);
        }
      },
    );
  }
}
