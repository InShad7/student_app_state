import 'package:hive/hive.dart';
part 'data.g.dart';

@HiveType(typeId: 1)
class Student {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String number;

  @HiveField(4)
  final String image;

  Student({
    required this.name,
    required this.age,
    this.id,
    required this.number,
    required this.image,
  });
}
