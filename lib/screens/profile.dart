import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_repository_using_getx/controller/notes_controller.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  final int index;
  const ProfileScreen({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentController = Get.find<NotesController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile of ${studentController.students[index].name}'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                  width: 130,
                  child: Center(
                    child: Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                FittedBox(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.indigo),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: FileImage(
                              File(studentController.students[index].profile),
                            ),
                            radius: 65,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "Name",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      "Age",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text("Address",
                                        style: TextStyle(fontSize: 17)),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text("Phone Number",
                                        style: TextStyle(fontSize: 17)),
                                  ],
                                ),
                              ),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    ":",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    ":",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(":", style: TextStyle(fontSize: 17)),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(":", style: TextStyle(fontSize: 17)),
                                ],
                              ),
                              SizedBox(
                                width: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      studentController.students[index].name,
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      studentController.students[index].age,
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      studentController.students[index].address,
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                        studentController
                                            .students[index].number,
                                        style: const TextStyle(fontSize: 17)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
