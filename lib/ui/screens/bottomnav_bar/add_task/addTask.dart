import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/ui/screens/main_bottomnav.dart';
import 'package:task1/ui/state_holder/controller/addTask_controller.dart';
import 'package:task1/ui/state_holder/model_calsses/newTask_model.dart'; // Make sure this import is correct

class TaskAddPage extends StatefulWidget {
  TaskAddPage({super.key});

  @override
  State<TaskAddPage> createState() => _TaskAddPageState();
}

class _TaskAddPageState extends State<TaskAddPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Task Description'),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: selectedStatus,
              decoration: const InputDecoration(labelText: 'Status'),
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
                setState(() {
                  selectedStatus = value; // Update selected status
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Please select a status';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.07,
              child: GetBuilder<AddNewTaskController>(
                builder: (addNewTaskController) {
                  if (addNewTaskController.newTaskInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (titleController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty &&
                          selectedStatus != null) {
                        addTask(addNewTaskController);
                      } else {
                        Get.snackbar('Error', 'Please fill in all fields');
                      }
                    },
                    child: const Text('Add Task'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addTask(AddNewTaskController addNewTaskController) async {
    final response = await addNewTaskController.addNewTask(
      titleController.text,
      descriptionController.text,
      selectedStatus!,
    );

    if (response) {
      titleController.clear();
      descriptionController.clear();
      selectedStatus = null; // Reset the selected status
      Get.offAll(const MainBottomNavScreen()); // Navigate to NewTask page
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wrong Information! Try Again')),
        );
      }
    }
  }
}
