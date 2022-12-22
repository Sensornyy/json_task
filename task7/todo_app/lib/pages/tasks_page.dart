import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/snack_bars.dart';
import 'package:todo_app/widgets/create_task_drawer.dart';

import '../bloc/task_cubit.dart';
import '../bloc/task_state.dart';
import '../model/task.dart';
import '../widgets/task_card.dart';
import '../widgets/task_error.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        List<Task> tasks = [];

        if (state is TasksLoadedState) {
          tasks = state.tasks;
        } else if (state is TasksEditingState) {
          tasks = state.tasksToEdit;
        } else if (state is TasksErrorState) {
          return const TaskError();
        }

        return Scaffold(
          backgroundColor: AppColors.mainBackground,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title:
                  const Text('Tasks', style: TextStyle(color: Colors.white))),
          endDrawer: CreateTaskDrawer(
            onAdd: context.read<TasksCubit>().addTask,
            onStopEditing: context.read<TasksCubit>().cancelEditingTask,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView.builder(
              itemBuilder: (_, int index) => TaskCard(
                task: tasks[index],
                onDelete: context.read<TasksCubit>().deleteTask,
                onToggle: context.read<TasksCubit>().toggleTask,
                onEdit: context.read<TasksCubit>().editTask,
              ),
              itemCount: tasks.length,
            ),
          ),
          floatingActionButton: state is TasksEditingState
              ? FloatingActionButton(
                  onPressed: () {
                    context.read<TasksCubit>().cancelEditingTask;
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBars.taskEditSuccess);
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.close,
                    color: AppColors.mainBackground,
                  ),
                )
              : null,
        );
      },
    );
  }
}
