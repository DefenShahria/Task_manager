import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:task1/data/colorPlate.dart';
import 'package:task1/ui/state_holder/controller/auth_controller.dart';
import 'package:task1/ui/state_holder/controller/statusChangeController.dart';
import 'package:task1/ui/state_holder/controller/taskDelet_controller.dart';
import '../../../state_holder/controller/new_taskcontroller.dart';
import '../add_task/addTask.dart';

class New_task extends StatefulWidget {
  const New_task({super.key});

  @override
  State<New_task> createState() => _New_taskState();
}

class _New_taskState extends State<New_task> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<NewTaskController>().getNewTask();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('In Progress'),
        backgroundColor: Appcolor.primarycolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GetBuilder<NewTaskController>(builder: (newTaskController) {
              if (newTaskController.getNewTaskInProgress) {
                return const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              // Check if newtask or newtask.data is null
              if (newTaskController.newtask == null ||
                  newTaskController.newtask!.data == null) {
                return Column(
                  children: [
                    Center(
                      child: Text('No tasks available.'),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          print(AuthController().accessToken);
                        },
                        child: Text("Token")),
                  ],
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: newTaskController.newtask!.data!.length,
                  itemBuilder: (context, index) {
                    var task = newTaskController.newtask!.data![index];

                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.title ?? 'Empty title',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(task.description ?? ''),
                                Text(task.createdDate ?? ''),
                                Text('Status: ${task.status ?? 'Unknown'}'), // Display current status
                              ],
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.blue,
                                onPressed: () {
                                  showStatusChangeDialog(task.sId ?? '', task.status ?? '');
                                  newTaskController.getNewTask();
                                },
                              ),
                              GetBuilder<DeletPostController>(builder: (deletPostController) {
                                return IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.grey,
                                  onPressed: () async {
                                    await deletPostController.deletPost(task.sId ?? '');
                                    // Refresh the task list after deletion
                                    newTaskController.getNewTask();
                                  },
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(TaskAddPage());
        },
        child: const Icon(Icons.add),
        backgroundColor: Appcolor.primarycolor,
      ),
    );
  }

  void showStatusChangeDialog(String taskId, String currentStatus) {
    String? newStatus = currentStatus; // Start with current status

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Task Status'),
          content: DropdownButtonFormField<String>(
            value: newStatus,
            decoration: const InputDecoration(labelText: 'Select New Status'),
            items: const [
              DropdownMenuItem(
                value: 'New',
                child: Text('New'),
              ),
              DropdownMenuItem(
                value: 'Completed',
                child: Text('Completed'),
              ),
            ],
            onChanged: (value) {
              newStatus = value; // Update new status
            },
          ),
          actions: [
            GetBuilder<UpdatePostController>(
              builder: (updatePostController) {
                return TextButton(
                  onPressed: () async {
                    if (newStatus != null) {
                      await updatePostController.updatePost(taskId, newStatus!);
                      Get.back(); // Close the dialog
                      Get.find<NewTaskController>().getNewTask(); // Refresh task list
                    } else {
                      Get.snackbar('Error', 'Please select a status');
                    }
                  },
                  child: const Text('Confirm'),
                );
              }
            ),
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
