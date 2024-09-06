import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/theme/colors_mapper.dart';
import 'package:to_do_app/core/widgets/grident_star.dart';
import 'package:to_do_app/features/to-do/domin/entitys/tag_entity.dart';
import 'package:to_do_app/features/to-do/domin/entitys/task_entity.dart';
import 'package:to_do_app/features/to-do/presentation/bloc/to_do_bloc/task_bloc.dart';
import 'package:to_do_app/features/to-do/presentation/widgets/tag_widget.dart';

class TaskCard extends StatelessWidget {
  final TodoEntity task;
  final bool selected;
  final void Function() onLongTab;
  final void Function() onTab;

  const TaskCard({
    super.key,
    required this.task,
    required this.onLongTab,
    required this.selected,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      onLongPress: onLongTab,
      child: Ink(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: selected ? Colors.black : Colors.transparent,
              width: 2,
            ),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridentStar(
                  startColor: tagColors[task.tags.first.color].shade300,
                  endColor: tagColors[task.tags.first.color].shade50,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Expanded(
                              child: Text(
                                task.time,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                BlocProvider.of<TasksBloc>(context)
                                    .add(DeleteTasksEvent(ids: [task.id!]));
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ]),
                          Text(
                            task.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            task.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[600],
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: 25,
                        child: Row(
                          children: [
                            if (task.urgent == 1)
                              TagWidget(
                                tag: TagEntity(name: "Urgent", color: "black"),
                              ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: task.tags.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    TagWidget(tag: task.tags[index]),
                              ),
                            ),
                            Icon(
                              Icons.check_box,
                              color: selected ? Colors.black : Colors.grey,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
