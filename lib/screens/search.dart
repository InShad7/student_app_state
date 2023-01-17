import 'dart:io';

import 'package:db_hive/infrastructure/provider.dart';
import 'package:db_hive/model/data.dart';
import 'package:db_hive/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

List<Student> studentList = Hive.box<Student>('student_db').values.toList();

class SearchScreen extends ConsumerWidget {
  SearchScreen({Key? key}) : super(key: key);

  final _searchController = TextEditingController();

  // List<Student> studentList = Hive.box<Student>('student_db').values.toList();

  late List<Student> studentDisplay = List<Student>.from(studentList);

//function or widgets-------------------------------------------------------

  Widget expanded() {
    return Expanded(
      child: studentDisplay.isNotEmpty
          ? ListView.builder(
              itemCount: studentDisplay.length,
              itemBuilder: (context, index) {
                // final data = studentList[index];
                File img = File(studentDisplay[index].image);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(img),
                    radius: 22,
                  ),
                  title: Text(studentDisplay[index].name),
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StudentProfile(
                          passValue: studentDisplay[index],
                          passId: index,
                        ),
                      ),
                    );
                  }),
                );
              },
            )
          : const Center(
              child: Text(
                'No match found',
                style: TextStyle(fontSize: 20),
              ),
            ),
    );
  }

  Widget searchTextField(ref) {
    // return Consumer(
    // builder: (BuildContext context, WidgetRef ref, Widget? child) {
    studentDisplay = ref.watch(searchProvider);
    return TextFormField(
      autofocus: true,
      controller: _searchController,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => clearText(),
        ),
        filled: true,
        fillColor: const Color.fromRGBO(234, 236, 238, 2),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        hintText: 'search . . .',
      ),
      onChanged: (value) {
        ref.read(searchProvider.notifier).state = studentList
            .where((element) =>
                element.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      },
    );
    // },
    // );
  }

  // void _searchStudent(String value, ref) {
  //   // setState(() {
  //   //   studentDisplay = studentList
  //   //       .where((element) =>
  //   //           element.name.toLowerCase().contains(value.toLowerCase()))
  //   //       .toList();
  //   // });
  //   studentDisplay = ref.read(searchProvider.notifier).state = studentList
  //       .where((element) =>
  //           element.name.toLowerCase().contains(value.toLowerCase()))
  //       .toList();
  // }

  void clearText() {
    _searchController.clear();
  }

  //builder-------------------------------------------------------------

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('main');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              searchTextField(ref),
              expanded(),
            ],
          ),
        ),
      ),
    );
  }
}
