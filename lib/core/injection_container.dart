import 'package:get_it/get_it.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/core/database/database_helper.dart';
import 'package:to_do_app/features/to-do/data/data_sources/task_local_data_source.dart';
import 'package:to_do_app/features/to-do/data/repositores/task_repositore_implementation.dart';
import 'package:to_do_app/features/to-do/domin/repositores/task_repositore.dart';
import 'package:to_do_app/features/to-do/domin/usecases/add_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/archive_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/delete_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/delete_tasks_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/get_archived_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/get_done_task_usecase.dart';
import 'package:to_do_app/features/to-do/domin/usecases/update_task_usecase.dart';
import 'package:to_do_app/features/to-do/presentation/bloc/to_do_bloc/task_bloc.dart';

final sl = GetIt.instance;

const _databaseName = "toDo.db";
const _databaseVersion = 1;

Future<Database> initDatabase() async {
  return await openDatabase(
    _databaseName,
    version: _databaseVersion,
    onConfigure: (db) => db.execute("PRAGMA foreign_keys = ON"),
    onCreate: (db, version) {
      db.execute('''
          CREATE TABLE tasks (
            taskId INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            date TEXT NOT NULL,
            time TEXT NOT NULL,
            description TEXT NOT NULL,
            urgent INTEGER NOT NULL,
            done INTEGER NOT NULL,
            tags TEXT NOT NULL
          )
          ''');
    },
  );
}

Future<void> init() async {
  Database database = await initDatabase();
  sl.registerLazySingleton<TaskRepositore>(
    () => TaskRepositoreImplementation(
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => AddTaskUseCase(taskRepositore: sl()));
  sl.registerLazySingleton(() => UpdateTaskUseCase(taskRepositore: sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(taskRepositore: sl()));
  sl.registerLazySingleton(() => GetPendindTasksUseCase(taskRepositore: sl()));
  sl.registerLazySingleton(() => GetDoneTasksUseCase(taskRepositore: sl()));
  sl.registerLazySingleton(() => ArchiveTasksUseCase(taskRepositore: sl()));
  sl.registerLazySingleton(() => DeleteTasksUseCase(taskRepositore: sl()));

  sl.registerLazySingleton<Database>(() => database);

  sl.registerLazySingleton(() => DatabaseHelper(database: sl()));

  sl.registerLazySingleton<LocalDataSource>(
    () => SqfliteLocalDataSource(
      databaseHelper: sl(),
    ),
  );

  sl.registerFactory<TaskBloc>(
    () => TaskBloc(
      getDoneTasksUseCase: sl(),
      addTasksUseCase: sl(),
      deleteTaskUseCase: sl(),
      deleteTasksUseCase: sl(),
      getPendindTasksUseCase: sl(),
      archiveTaskUseCase: sl(),
    ),
  );
}
