import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_repository_using_getx/controller/image_controller.dart';
import 'package:student_repository_using_getx/screens/widget.dart';
import '../controller/notes_controller.dart';
import '../model/student_model.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});

  final controller = Get.put(NotesController());
  final value = Get.put(TempImageController());
  final nameController = TextEditingController();
  final agecontroller = TextEditingController();
  final addressController = TextEditingController();
  final numbercontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student's Details"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<TempImageController>(
                    builder: (_) => Column(
                      children: [
                        Align(
                            alignment: Alignment.topCenter,
                            child: value.tempImagePath == null
                                ? const CircleAvatar(
                                    backgroundImage:
                                        AssetImage('assets/man.jpg'),
                                    radius: 100,
                                  )
                                : CircleAvatar(
                                    radius: 100,
                                    backgroundImage: FileImage(
                                      File(value.tempImagePath!),
                                    ),
                                  )),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                            onPressed: () {
                              getimage(value);
                            },
                            icon: const Icon(Icons.photo),
                            label: const Text("Add Photo")),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: CustomDecoration('Name', Icons.person),
                    validator: (value) {
                      if (nameController.text.isEmpty) {
                        return 'NameField cannot be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: agecontroller,
                    keyboardType: TextInputType.number,
                    decoration: CustomDecoration('Age', Icons.calendar_month),
                    maxLength: 3,
                    validator: (value) {
                      if (agecontroller.text.isEmpty) {
                        return 'Enter your Age';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: addressController,
                    keyboardType: TextInputType.streetAddress,
                    decoration: CustomDecoration('Address', Icons.home),
                    validator: (value) {
                      if (addressController.text.isEmpty) {
                        return 'Enter your Address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: numbercontroller,
                    keyboardType: TextInputType.phone,
                    decoration: CustomDecoration('phone', Icons.phone_android),
                    maxLength: 10,
                    validator: (value) {
                      if (numbercontroller.text.isEmpty) {
                        return 'Enter your Phone Number';
                      } else if (numbercontroller.text.length < 10) {
                        return 'Enter a valid Phone Number';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(75, 5, 75, 5),
                    child: GetBuilder<TempImageController>(
                      builder: (value) => GetBuilder<NotesController>(
                        builder: (value2) => ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (value.tempImagePath == null) {
                                addingFailed(context);
                              } else {
                                addingSuccess(
                                  value,
                                  value2,
                                  context,
                                );
                              }
                            }
                          },
                          child: const Text('Add'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      )),
    );
  }

  void addingFailed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Please add your Photo!"),
      backgroundColor: Colors.red,
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 3),
    ));
  }

  void addingSuccess(
    TempImageController value,
    NotesController value2,
    BuildContext context,
  ) async {
    StudentModel st = StudentModel(
      profile: value.tempImagePath!,
      name: nameController.text.trim(),
      age: agecontroller.text.trim(),
      address: addressController.text.trim(),
      number: numbercontroller.text.trim(),
    );
    value2.addStudent(st);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Text('${nameController.text} details are added to your repository'),
      backgroundColor: Colors.green,
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 3),
    ));
    value.tempImagePath = null;
    value.notify();
    Navigator.of(context).pop();
  }

  getimage(TempImageController value) async {
    await value.getImage();
  }
}

// ignore: non_constant_identifier_names
Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return SizedBox(
    width: 280,
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 20,
          ),
          Text(title),
        ],
      ),
    ),
  );
}
