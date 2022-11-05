import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../HomeScreen/Controoler/HomeController.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({Key? key}) : super(key: key);

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Details"),
      ),
      body: Column(
        children: [
          DataTable(
            columnSpacing: Get.width / 3,
            columns: [
              // DataColumn(
              //     label: Text('ID',
              //         style: TextStyle(
              //             fontSize: 18, fontWeight: FontWeight.bold))),
              DataColumn(
                  label: Text(
                'Name',
                // style: TextStyle(
                //     fontSize: 18, fontWeight: FontWeight.bold)
              )),
              DataColumn(
                  label: Text(
                'Profession',
                // style: TextStyle(
                //     fontSize: 18, fontWeight: FontWeight.bold)
              )),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('Stephen')),
                DataCell(Text('Actor')),
              ]),
              DataRow(cells: [
                DataCell(Text('John')),
                DataCell(Text('Student')),
              ]),
              DataRow(cells: [
                DataCell(Text('Harry')),
                DataCell(Text('Leader')),
              ]),
              DataRow(cells: [
                DataCell(Text('Peter')),
                DataCell(Text('Scientist')),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
