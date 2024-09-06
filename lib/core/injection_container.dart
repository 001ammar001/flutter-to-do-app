import 'package:get_it/get_it.dart';
import 'package:to_do_app/core/database/database_helper.dart';
import 'package:to_do_app/features/to-do/data/data_sources/task_local_data_source.dart';
import 'package:to_do_app/features/to-do/data/repositores/task_repositore_implementation.dart';
import 'package:to_do_app/features/to-do/domin/repositores/task_repositore.dart';
import 'package:to_do_app/features/to-do/domin/usecases/add_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/archive_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/delete_tasks_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/get_done_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/update_task_usecase.dart';
import 'package:to_do_app/features/to-do/presentation/bloc/to_do_bloc/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<TaskRepositore>(
    () => TaskRepositoreImplementation(
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => AddTaskUseCase(taskRepositore: sl()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(taskRepositore: sl()));
  sl.registerLazySingleton(() => GetTasksUseCase(taskRepositore: sl()));
  sl.registerLazySingleton(() => ArchiveTasksUseCase(taskRepositore: sl()));
  sl.registerLazySingleton(() => DeleteTasksUseCase(taskRepositore: sl()));

  sl.registerLazySingleton(() => const DatabaseHelper());

  sl.registerLazySingleton<LocalDataSource>(
    () => SqfliteLocalDataSource(
      databaseHelper: sl(),
    ),
  );

  sl.registerFactory<TasksBloc>(
    () => TasksBloc(
      getTasksUseCase: sl(),
      addTasksUseCase: sl(),
      deleteTasksUseCase: sl(),
      archiveTaskUseCase: sl(),
      updateTaskUseCase: sl(),
    ),
  );
}
