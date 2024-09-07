import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/to-do/presentation/bloc/stats_bloc/stats_bloc.dart';
import 'package:to_do_app/features/to-do/presentation/bloc/to_do_bloc/task_bloc.dart';
import 'package:to_do_app/features/to-do/presentation/pages/to_do_details_page.dart';
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
    return BlocListener<TodosBloc, TodosState>(
      listenWhen: (previous, current) => current.isFailure,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              state.message,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<TodosBloc, TodosState>(
              buildWhen: (previous, current) =>
                  previous.tasks.length != current.tasks.length,
              builder: (context, state) {
                return Row(
                  children: [
                    WelcomeHeader(
                      taskCount: state.tasks.length,
                    ),
                    const Spacer(),
                    if (selectedTasksIds.isNotEmpty)
                      IconButton(
                        onPressed: () {
                          if (state.getPending) {
                            context.read<TodosBloc>().add(
                                  ArchiveTodosEvent(ids: selectedTasksIds),
                                );
                          } else {
                            context.read<TodosBloc>().add(
                                  DeleteTodosEvent(ids: selectedTasksIds),
                                );
                          }
                          setState(() {
                            selectedTasksIds = [];
                          });
                        },
                        icon: Icon(
                          state.getPending ? Icons.done : Icons.delete,
                          size: 25,
                        ),
                      )
                  ],
                );
              },
            ),
            const FilterWidget(),
            const TypeFilter(),
            Expanded(
              child: BlocBuilder<TodosBloc, TodosState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.isSucsess) {
                    return ListView.builder(
                      itemCount: state.tasks.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final task = state.tasks[index];
                        return TaskCard(
                          task: task,
                          selected: selectedTasksIds.contains(task.id),
                          onTab: () {
                            if (selectedTasksIds.isNotEmpty) {
                              selectTaks(state, index);
                            } else {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TodoDetailsPage(todo: task),
                                ),
                              );
                            }
                          },
                          onLongTab: () => selectTaks(state, index),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void selectTaks(TodosState state, int index) {
    return setState(
      () {
        if (selectedTasksIds.contains(state.tasks[index].id)) {
          selectedTasksIds.remove(state.tasks[index].id);
        } else {
          selectedTasksIds.add(state.tasks[index].id!);
        }
      },
    );
  }
}
