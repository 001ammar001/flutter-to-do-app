import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/to-do/presentation/bloc/to_do_bloc/task_bloc.dart';

class TypeFilter extends StatelessWidget {
  final bool active;
  const TypeFilter({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        statusTypeButton(active: active, label: "To Do", context: context),
        statusTypeButton(active: !active, label: "Done", context: context),
      ],
    );
  }

  Widget statusTypeButton({
    required bool active,
    required String label,
    required BuildContext context,
  }) {
    return Expanded(
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: active
              ? MaterialStateProperty.all(Colors.black)
              : MaterialStateProperty.all(Colors.grey[200]),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: label == "To Do"
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    )
                  : const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
              side: const BorderSide(color: Colors.transparent),
            ),
          ),
        ),
        onPressed: () {
          if (!active && label == "To Do") {
            BlocProvider.of<TaskBloc>(context).add(GetPedningTasksEvent());
          } else if (!active && label == "Done") {
            BlocProvider.of<TaskBloc>(context).add(GetDoneTasksEvent());
          }
        },
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
