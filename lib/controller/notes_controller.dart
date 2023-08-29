import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:student_repository_using_getx/model/student_model.dart';

class NotesController extends GetxController {
  List<StudentModel> students = [];

  Future<void> addStudent(StudentModel student) async {
    final studentDB = await Hive.openBox<StudentModel>('studentDbGetX');
    students.add(student);
    await studentDB.add(student);
    update();
  }

  Future<void> getStudent() async {
    final studentDB = await Hive.openBox<StudentModel>('studentDbGetX');
    students.clear();
    students.addAll(studentDB.values);
    update();
  }

  Future<void> deleteStudent(int index) async {
    final studentDB = await Hive.openBox<StudentModel>('studentDbGetX');
    await studentDB.deleteAt(index);
    getStudent();
  }

  Future<void> editStudent(int index, StudentModel student) async {
    final studentDB = await Hive.openBox<StudentModel>('studentDbGetX');
    await studentDB.putAt(index, student);
    getStudent();
    update();
  }
}
