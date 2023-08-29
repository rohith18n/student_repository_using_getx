import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_repository_using_getx/screens/addstudent.dart';
import 'package:student_repository_using_getx/screens/profile.dart';
import 'package:student_repository_using_getx/screens/search.dart';
import '../controller/notes_controller.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotesController controller = Get.put(NotesController());
    controller.getStudent();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Student Repository"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Get.to(showSearch(context: context, delegate: Search()));
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              GetBuilder<NotesController>(
                builder: (_) {
                  return controller.students.isNotEmpty
                      ? Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final student = controller.students[index];
                              return Flex(direction: Axis.vertical, children: [
                                ListTile(
                                  onTap: () {
                                    Get.to(() => ProfileScreen(index: index));
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(File(student.profile)),
                                  ),
                                  title: Text(student.name),
                                  subtitle: Text(student.age),
                                  trailing: FittedBox(
                                    child: Row(
                                      children: [
                                        // IconButton(
                                        //   onPressed: () {
                                        //     // Implement edit functionality
                                        //   },
                                        //   icon: const Icon(Icons.edit),
                                        // ),
                                        IconButton(
                                          onPressed: () {
                                            showAlert(
                                                context, index, controller);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]);
                            },
                            separatorBuilder: (ctx, index) {
                              return const Divider();
                            },
                            itemCount: controller.students.length,
                          ),
                        )
                      : const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              'No items to Display',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddStudent());
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void showAlert(BuildContext context, int index, NotesController value) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'Do you want to delete ${value.students[index].name}',
          ),
          content: const Text(
            'All the related data will be cleared from the database',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                value.deleteStudent(index);
                Navigator.of(ctx).pop();
              },
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
