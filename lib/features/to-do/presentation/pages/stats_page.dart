import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/to-do/presentation/bloc/stats_bloc/stats_bloc.dart';

class StatsBody extends StatelessWidget {
  const StatsBody({super.key});

  @override
  Widget build(BuildContext context) {
    // the state get updated once we enter the stats page (when changing index for the indexed stack)

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(child: BlocBuilder<StatsBloc, StatsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const CircularProgressIndicator();
          } else if (state.isFailure) {
            return Column(
              children: [
                const Text("An Error Accoured Please Try Again"),
                TextButton(
                  onPressed: () => context.read<StatsBloc>().add(
                        GetStatsEvent(),
                      ),
                  child: const Text("Retry"),
                ),
              ],
            );
          } else if (state.isSucsess) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "So far you have finished: ${state.doneTasksCount} task",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "you still have ${state.tasks.length - state.doneTasksCount} pendding tasks",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                )
              ],
            );
          }
          return const SizedBox();
        },
      )),
    );
  }
}
