import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/errors/failures.dart';
import 'package:to_do_app/features/to-do/domin/entitys/task_entity.dart';
import 'package:to_do_app/features/to-do/domin/usecases/get_all_tasks_usecase.dart';

part 'stats_states.dart';
part 'stats_events.dart';

class StatsBloc extends Bloc<StatsEvents, StatsState> {
  final GetAllTasksUseCase getAllTasksUseCase;

  StatsBloc({
    required this.getAllTasksUseCase,
  }) : super(StatsState.inital()) {
    on<GetStatsEvent>(_getStats);
  }

  Future<void> _getStats(GetStatsEvent event, Emitter emit) async {
    emit(state.copyWith(
      newState: StatsStatesEnum.loading,
      newGetActive: event.getActiveTasks,
    ));

    final taskOrError = await getAllTasksUseCase();

    emit(
      mapResultToState(
        taskOrError,
        state.copyWith(
          newTasks: taskOrError.right,
          newState: StatsStatesEnum.sucsess,
        ),
      ),
    );
  }

  StatsState mapResultToState(dynamic result, StatsState state) {
    if (result.runtimeType == Failure) {
      return state.copyWith(newState: StatsStatesEnum.failure, newTasks: []);
    } else {
      return state;
    }
  }
}
