import 'dart:io';


import 'package:db_hive/model/data.dart';


import 'package:db_hive/screens/widgets/editProfile.dart';
import 'package:flutter/material.dart';

class StudentProfile extends StatelessWidget {
  final double coverHeight = 200;
  final double profileHeight = 160;

  StudentProfile({
    Key? key,
    required this.passValue,
    required this.passId,
  }) : super(key: key);

  Student passValue;
  final int passId;

//functions or widgets========================================================

  Widget top() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(clipBehavior: Clip.none, children: [
      Container(margin: EdgeInsets.only(bottom: bottom), child: CoverImage()),
      Positioned(
        top: top,
        left: 135,
        child: ProfileImage(),
      ),
    ]);
  }

  Widget content() {
    return Container(
      width: 200,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            ' ${passValue.name}',
            style: const TextStyle(fontSize: 28, fontFamily: 'Ubuntu'),
          ),
          Text('Age : ${passValue.age}',
              style: const TextStyle(fontSize: 18, color: Colors.grey)),
          Text('Class : ${passValue.number}',
              style: const TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget CoverImage() => Container(
        color: const Color.fromRGBO(234, 236, 238, 2),
        width: double.infinity,
        height: coverHeight,
      );

  Widget ProfileImage() => CircleAvatar(
        backgroundImage: FileImage(File(passValue.image)),
        radius: profileHeight / 2,
      );

  Widget floatbtn(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditProfile(
                        passValueProfile: passValue,
                        index: passId,
                      )));
        },
        icon: const Icon(Icons.edit_outlined));
  }

//builder====================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          actions: [
            floatbtn(context),
          ],
        ),
        body: ListView(children: <Widget>[
          top(),
          content(),
        ]));
  }
}
