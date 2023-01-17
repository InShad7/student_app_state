import 'dart:io';

import 'package:db_hive/db/function/db_function.dart';
import 'package:db_hive/model/data.dart';
import 'package:db_hive/screens/profile.dart';
import 'package:flutter/material.dart';

class ListStudent extends StatelessWidget {
  const ListStudent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    getStudents();
    return ValueListenableBuilder(
      valueListenable: studentNotifier,
      builder:
          (BuildContext context, List<Student> studentList, Widget? child) {
        return ListView.separated(
            itemBuilder: ((context, index) {
              final data = studentList[index];
              return ListTile(
                  contentPadding: const EdgeInsets.all(15.0),
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(data.image)),
                    radius: 30,
                  ),
                  title: Text(data.name),
                  trailing: IconButton(
                      onPressed: () {
                        deleteAlert(context, index);
                        // deleteStudent(index);
                      },
                      icon: const Icon(Icons.delete_outlined)),
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentProfile(
                                  passValue: data,
                                  passId: index,
                                )));
                  }));
            }),
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: studentList.length);
      },
    );
  }
}

deleteAlert(BuildContext context, index) {
  showDialog(
      context: context,
      builder: ((ctx) => AlertDialog(
            content: const Text('Are you sure you want to delete'),
            actions: [
              TextButton(
                  onPressed: () {
                    deleteStudent(index);
                    Navigator.of(context).pop(ctx);
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                onPressed: () => Navigator.of(context).pop(ctx),
                child: const Text('Cancel'),
              )
            ],
          )));
}
