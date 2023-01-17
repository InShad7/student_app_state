import 'package:db_hive/db/function/db_function.dart';
import 'package:db_hive/screens/search.dart';
import 'package:db_hive/screens/widgets/StudentList.dart';
import 'package:db_hive/screens/widgets/addstudent.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Menu'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => SearchScreen()),
                  ),
                );
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: ListStudent(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddStudent(),
            ),
          );
          // AddStudent();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
