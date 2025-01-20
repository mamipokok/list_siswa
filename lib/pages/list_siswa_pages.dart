import 'package:application/model/student.dart';
import 'package:application/widget/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListSiswaPages extends StatefulWidget {
  const ListSiswaPages({super.key});

  @override
  State<ListSiswaPages> createState() => _ListSiswaState();
}

class _ListSiswaState extends State<ListSiswaPages> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController classesController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final List<Student> _students = [];
  String? pesan;

  void _addStudent() {
    setState(() {
      _students.add(
        Student(
          firstNameController.text,
          lastNameController.text,
          classesController.text,
          majorController.text,
        ),
      );
    });
    firstNameController.clear();
    lastNameController.clear();
    classesController.clear();
    majorController.clear();
  }

  void _editStudent(int index, Student newStudent) {
    setState(() {
      _students[index] = newStudent;
    });
    firstNameController.clear();
    lastNameController.clear();
    classesController.clear();
    majorController.clear();
  }

  void _deleteStudent(int index) {
    setState(() {
      _students.removeAt(index);
    });
  }

  void _showEdit(int index) {
    final student = _students[index];
    firstNameController.text = student.firstName;
    lastNameController.text = student.lastName;
    classesController.text = student.classes;
    majorController.text = student.major;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Student"),
          content: Container(
            height: 300,
            width: 200,
            child: Column(
              children: [
                CustomTextfield(
                  nama: "First Name",
                  controller: firstNameController,
                  typekeyboard: TextInputType.name,
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  nama: "Last Name",
                  controller: lastNameController,
                  typekeyboard: TextInputType.name,
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  nama: "classes",
                  controller: classesController,
                  typekeyboard: TextInputType.number,
                ),
                SizedBox(height: 20),
                CustomTextfield(
                  nama: "major",
                  controller: majorController,
                  typekeyboard: TextInputType.name,
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("cancel"),
            ),
            TextButton(
              onPressed: () {
                _editStudent(
                  index,
                  Student(firstNameController.text, lastNameController.text,
                      classesController.text, majorController.text),
                );
                Navigator.pop(context);
              },
              child: Text("save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Aplikasi Data Siswa",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30, top: 10),
            child: Column(
              children: [
                CustomTextfield(
                  controller: firstNameController,
                  nama: "Frist Name",
                  typekeyboard: TextInputType.name,
                ),
                SizedBox(height: 10),
                CustomTextfield(
                  controller: lastNameController,
                  nama: "Last Name",
                  typekeyboard: TextInputType.name,
                ),
                SizedBox(height: 10),
                CustomTextfield(
                  controller: classesController,
                  nama: "Classes",
                  typekeyboard: TextInputType.number,
                ),
                SizedBox(height: 10),
                CustomTextfield(
                  controller: majorController,
                  nama: "Major",
                  typekeyboard: TextInputType.text,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addStudent,
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: _students.length,
                itemBuilder: (context, index) {
                  final students = _students[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey,
                            const Color.fromARGB(255, 185, 184, 184),
                            const Color.fromARGB(255, 201, 198, 198),
                            const Color.fromARGB(255, 207, 204, 204),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        title: Text(
                          "${students.firstName} ${students.lastName}",
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          "${students.classes} ${students.major}",
                          style: TextStyle(color: Colors.black),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => _showEdit(index),
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () => _deleteStudent(index),
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
