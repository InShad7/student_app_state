import 'dart:io';

import 'package:db_hive/infrastructure/provider.dart';
import 'package:db_hive/model/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:image_picker/image_picker.dart';

import '../../db/function/db_function.dart';

class AddStudent extends StatelessWidget {
  AddStudent({Key? key}) : super(key: key);


  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _numController = TextEditingController();

  String? imagePath;

  // final ImagePicker _picker = ImagePicker();

//functionss-----------------------------------------

  Future<void> StudentAddBtn() async {
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

    addStudent(_students);
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

  Widget elavatedbtn({required Icon myIcon, required Text myLabel, context}) {
    return ElevatedButton.icon(
      onPressed: () {
        StudentAddBtn();

        Navigator.of(context).pop();
      },
      icon: myIcon,
      label: myLabel,
    );
  }

  Widget textFieldName(
      {required TextEditingController myController, hintName}) {
    return TextFormField(
      // textCapitalization: TextCapitalization.characters,
      controller: myController,
      cursorColor: Colors.black,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromRGBO(234, 236, 238, 2),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        hintText: hintName,
      ),
    );
  }

  Widget dpImage() {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        print('consumer widget only');
        imagePath = ref.watch(imgProvider);
        // child:
        return Stack(
          children: [
            CircleAvatar(
              radius: 75,
              backgroundImage: imagePath == ''
                  ? const AssetImage('assests/images.png') as ImageProvider
                  : FileImage(File(imagePath!)),
            ),
            Positioned(
                bottom: 10,
                right: 25,
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

// builder----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    print(' main');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              dpImage(),
              szdBox,
              textFieldName(myController: _nameController, hintName: "Name"),
              szdBox,
              textFieldName(myController: _ageController, hintName: "Age"),
              szdBox,
              textFieldName(myController: _numController, hintName: "Class"),
              szdBox,
              elavatedbtn(
                  myIcon: const Icon(Icons.person_add_alt_outlined),
                  myLabel: const Text('Add student'),
                  context: context),
              // elavatedbtn(
              //     myIcon: Icon(Icons.access_alarm), myLabel: 'saample2'),
            ],
          ),
        ),
      ),
    );
  }
}
