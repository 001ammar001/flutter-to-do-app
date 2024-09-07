import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/constants/tag_constants.dart';
import 'package:to_do_app/core/widgets/custom_form_field.dart';
import 'package:to_do_app/core/widgets/date_widget.dart';
import 'package:to_do_app/core/widgets/new_task_header.dart';
import 'package:to_do_app/core/widgets/tag_list_item.dart';
import 'package:to_do_app/core/widgets/time_widget.dart';
import 'package:to_do_app/features/to-do/domin/entitys/task_entity.dart';
import 'package:to_do_app/features/to-do/presentation/bloc/stats_bloc/stats_bloc.dart';
import 'package:to_do_app/features/to-do/presentation/bloc/to_do_bloc/task_bloc.dart';

class TodoDetailsPage extends StatefulWidget {
  final TodoEntity todo;
  const TodoDetailsPage({
    super.key,
    required this.todo,
  });

  @override
  State<TodoDetailsPage> createState() => _TodoDetailsPage();
}

class _TodoDetailsPage extends State<TodoDetailsPage> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController dateController;
  late TextEditingController hoursController;
  late TextEditingController minutesController;
  late TextEditingController descriptonController;
  late bool isUrgent = false;
  bool isError = false;
  late Color appBarColor;
  late Color appBarTextColor;

  late List<int> chosedTags = [];

  @override
  void initState() {
    super.initState();
    isUrgent = widget.todo.urgent == 1 ? true : false;
    titleController = TextEditingController(text: widget.todo.title);
    dateController = TextEditingController(text: widget.todo.date);
    hoursController =
        TextEditingController(text: widget.todo.time.split(":").first);
    minutesController =
        TextEditingController(text: widget.todo.time.split(":").last);
    descriptonController = TextEditingController(text: widget.todo.description);
    for (var tag in widget.todo.tags) {
      chosedTags.add(tags.indexWhere((element) => tag.name == element.name));
    }
    appBarColor = widget.todo.tags.isNotEmpty
        ? widget.todo.tags[0].getTagColor()
        : Colors.black;
    appBarTextColor = widget.todo.tags.isNotEmpty
        ? widget.todo.tags[0].getTextColor()
        : Colors.white;
  }

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    hoursController.dispose();
    minutesController.dispose();
    descriptonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        foregroundColor: appBarTextColor,
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AddNewTaskHeader(),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Title",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    coustomFormField(
                      controller: titleController,
                      text: "Type new task and do it!.",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        children: [
                          DateWidget(controller: dateController),
                          const SizedBox(width: 20),
                          TimeWidget(
                            hoursController: hoursController,
                            minutesController: minutesController,
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        "Dsecription",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    coustomFormField(
                      controller: descriptonController,
                      text: "Type your notes here",
                    ),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: isUrgent,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        isUrgent = !isUrgent;
                                      },
                                    );
                                  },
                                ),
                                const Text(
                                  "Urgent",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              "Select Category",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            ListView.builder(
                              itemCount: chosedTags.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, listIndex) => SizedBox(
                                height: 50,
                                child: ListView.separated(
                                  itemCount: tags.length,
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(top: 8),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 12),
                                  itemBuilder: (context, itemIndex) =>
                                      GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {
                                          if (chosedTags[listIndex] ==
                                              itemIndex) {
                                            chosedTags[listIndex] = -1;
                                          } else {
                                            chosedTags[listIndex] = itemIndex;
                                          }
                                        },
                                      );
                                    },
                                    child: TagListItem(
                                      isChoosed:
                                          chosedTags[listIndex] == itemIndex,
                                      item: tags[itemIndex],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                if (chosedTags.length < tags.length)
                                  TextButton(
                                    child: const Text(
                                      "+ Add new",
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {
                                          chosedTags.add(-1);
                                        },
                                      );
                                    },
                                  ),
                                if (chosedTags.length > 1)
                                  TextButton(
                                    child: const Text(
                                      "- Remove Tag",
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {
                                          chosedTags.removeLast();
                                        },
                                      );
                                    },
                                  )
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    if (isError)
                      const Column(
                        children: [
                          Text(
                            "All the Tags should be unique and should have value",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4)
                        ],
                      ),
                    SizedBox(
                      width: double.maxFinite,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (chosedTags.contains(-1) ||
                                chosedTags.toSet().length !=
                                    chosedTags.length) {
                              setState(() {
                                isError = true;
                              });
                            } else {
                              final task = TodoEntity(
                                id: widget.todo.id,
                                date: dateController.text,
                                description: descriptonController.text,
                                done: widget.todo.done,
                                time:
                                    "${hoursController.text}:${minutesController.text}",
                                title: titleController.text,
                                urgent: isUrgent ? 1 : 0,
                                tags: chosedTags
                                    .map((index) => tags[index])
                                    .toList(),
                              );
                              BlocProvider.of<TodosBloc>(context).add(
                                UpdateTodoEvent(taskEntity: task),
                              );
                              Navigator.pop(context);
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                        ),
                        child: const Text("Confirm Changes"),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
