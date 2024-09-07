part of 'stats_bloc.dart';

abstract class StatsEvents {}

class GetStatsEvent extends StatsEvents {
  final bool? getActiveTasks;

  GetStatsEvent({this.getActiveTasks});
}
