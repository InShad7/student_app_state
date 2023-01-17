import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../model/data.dart';

ValueNotifier<List<Student>> studentNotifier = ValueNotifier([]);

Future<void> addStudent(Student value) async {
  final studentDB = await Hive.openBox<Student>('Student_db');
  final _id = await studentDB.add(value);
  value.id = _id;
  studentNotifier.value.add(value);
  studentNotifier.notifyListeners();
}

Future<void> getStudents() async {
  final studentDB = await Hive.openBox<Student>('Student_db');
  studentNotifier.value.clear();

  studentNotifier.value.addAll(studentDB.values);
  studentNotifier.notifyListeners();
}

Future<void> deleteStudent(int id) async {
  final studentDB = await Hive.openBox<Student>('Student_db');
  await studentDB.deleteAt(id);
  getStudents();
}
