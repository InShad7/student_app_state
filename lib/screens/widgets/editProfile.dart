import 'dart:io';

import 'package:db_hive/infrastructure/provider.dart';
import 'package:db_hive/model/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:image_picker/image_picker.dart';

import '../../db/function/db_function.dart';
import '../HomeScreen.dart';

class EditProfile extends StatelessWidget {
  EditProfile(
      {Key? key,
      // required this.passValue01,
      required this.index,
      required this.passValueProfile})
      : super(key: key);

  Student passValueProfile;
  int index;

  late final _nameController =
      TextEditingController(text: passValueProfile.name);

  late final _ageController = TextEditingController(text: passValueProfile.age);

  late final _numController =
      TextEditingController(text: passValueProfile.number);

  String? imagePath;

  // final ImagePicker _picker = ImagePicker();

//function or widget==================================================

  Future<void> StudentAddBtn(int index) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _number = _numController.text.trim();
    // final _image = imagePath;

    if (_name.isEmpty || _age.isEmpty || _number.isEmpty) {
      return;
    }
    print('$_name $_age $_number');

    final _students = Student(
      name: _name,
      age: _age,
      number: _number,
      image: imagePath!,
    );
    final studentDB = await Hive.openBox<Student>('student_db');
    studentDB.putAt(index, _students);
    getStudents();
  }

  Future<void> takePhoto(ref) async {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      // setState(() {
      //   imagePath = PickedFile.path;
      // });
      ref.read(imgProvider.notifier).state = PickedFile.path;
    } else {
      return;
    }
  }

  Widget elavatedbtn(context) {
    return ElevatedButton.icon(
      onPressed: () {
        StudentAddBtn(index);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const HomeScreen()),
            (route) => false);
      },
      icon: const Icon(Icons.update_rounded),
      label: const Text('Update'),
    );
  }

  Widget textFieldName(
      {required TextEditingController myController, required String hintName}) {
    return TextFormField(
      autofocus: false,
      controller: myController,
      cursorColor: Colors.black,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(234, 236, 238, 2),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        hintText: hintName,
        // counterText: myController.text
      ),
      // initialValue: 'hintName',
    );
  }

  Widget dpImage() {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        imagePath = ref.watch(imgProvider);
        return Stack(
          children: [
            CircleAvatar(
              radius: 75,
              backgroundImage: imagePath == ''
                  ? FileImage(File(passValueProfile.image))
                  : FileImage(File(imagePath!)),
            ),
            Positioned(
                bottom: 2,
                right: 10,
                child: InkWell(
                    child: const Icon(
                      Icons.add_a_photo_outlined,
                      size: 30,
                    ),
                    onTap: () {
                      takePhoto(ref);
                    })),
          ],
        );
      },
    );
  }

  Widget szdBox = const SizedBox(height: 20);

  //build======================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              dpImage(),
              szdBox,
              textFieldName(myController: _nameController, hintName: 'Name'),
              szdBox,
              textFieldName(myController: _ageController, hintName: 'Age'),
              szdBox,
              textFieldName(myController: _numController, hintName: 'Class'),
              szdBox,
              elavatedbtn(context),
            ]),
          ),
        ));
  }
}
