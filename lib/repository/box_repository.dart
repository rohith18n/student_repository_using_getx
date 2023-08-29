import 'package:hive/hive.dart';
import 'package:student_repository_using_getx/model/student_model.dart';

class BoxRepository {
  static const String boxName = "studentdb";

  static openBox() async => await Hive.openBox<StudentModel>(boxName);

  static Box getBox() => Hive.box<StudentModel>(boxName);

  static closeBox() async => await Hive.box(boxName).close();
}
