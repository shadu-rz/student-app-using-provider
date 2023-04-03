import 'dart:io';

import 'package:dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/provider.dart';
import 'package:flutter_application_1/screen/edit_students.dart';
import 'package:flutter_application_1/screen/main_screen.dart';
import 'package:provider/provider.dart';

class EditListView extends StatelessWidget {
  const EditListView({
    super.key,
    required this.name,
    required this.class_,
    required this.age,
    required this.rollno,
    required this.photo,
    required this.index,
  });

  final String name;
  final String class_;
  final String age;
  final String rollno;
  final String? photo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(builder: (context, data, _) {
      data.enameController = TextEditingController(text: name);
      data.eclassController = TextEditingController(text: class_);
      data.eageController = TextEditingController(text: age);
      data.erollNoController = TextEditingController(text: rollno);
      data.eprofile = photo;

      return Form(
        key: data.eformkey,
        child: SizedBox(
          width: 350,
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: data.fileimage == null
                      ? Container(
                          height: 140,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: data.eprofile == null
                              ? const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('Assets/images/avatar.jpg'),
                                  radius: 80,
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(
                                    File(data.eprofile!),
                                  ),
                                  radius: 80,
                                ),
                        )
                      : CircleAvatar(
                          radius: 40,
                          backgroundImage: FileImage(
                            File(data.fileimage!.path),
                          ),
                        ),
                ),
                ElevatedButton(
                  onPressed: () {
                    data.imageFromGallery();
                  },
                  child: const Text('Edit profile'),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: data.enameController,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: data.eclassController,
                    decoration: const InputDecoration(
                      hintText: 'class',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLength: 3,
                    controller: data.eageController,
                    decoration: const InputDecoration(
                      hintText: 'Age',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLength: 10,
                    controller: data.erollNoController,
                    decoration: const InputDecoration(
                      hintText: 'Mobile Number',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required Name';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      style: const ButtonStyle(),
                      onPressed: () {
                        if (data.eformkey.currentState!.validate()) {
                          editSave(context, index);
                          MessageDialog messageDialog = MessageDialog(
                            dialogBackgroundColor: Colors.white,
                            buttonOkColor: Colors.blue,
                            title: 'Edit Details',
                            titleColor: Colors.black,
                            message: 'Do You Want To Edit?',
                            messageColor: Colors.black,
                            buttonOkText: 'Ok',
                            dialogRadius: 15.0,
                            buttonRadius: 18.0,
                            iconButtonOk: const Icon(Icons.one_k),
                            buttonOkOnPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const MainScreen(),
                                  ),
                                  (route) => false);
                            },
                          );
                          messageDialog.show(context,
                              barrierColor: Colors.white);
                        }

                        // editDialouge(context);
                      },
                      child: const Text('Done'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
