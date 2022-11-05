import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schoolmanegment/screens/HomeScreen/Controoler/HomeController.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final homeController = Get.put(HomeController());
  ImagePicker picker = ImagePicker();
  File? profile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Profile Picture",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Center(
                      child: Container(
                          height: 100,
                          width: 100,
                          child: profile == null
                              ?
                              //    FileImage(File(profile.path))
                              //
                              CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      homeController.studentModel.value.photo!),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(profile!),
                                  //
                                )),
                    ),
                    Positioned(
                        left: 210,
                        bottom: 1,
                        //  left: MediaQuery.of(context).size.width/2.4,
                        //  top: 200,
                        //  top:MediaQuery.of(context).size.height/7 ,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30)),
                          child: IconButton(
                              // style: ElevatedButton.styleFrom(
                              //   backgroundColor: Colors.blue
                              // ),

                              iconSize: 20,
                              onPressed: () {
                                _showMyDialog();

                                // picker.pickImage(source: ImageSource.camera );
                              },
                              icon: Icon(Icons.edit)),
                        ))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                profileWidget(
                    "Name", homeController.studentModel.value.data!.name!),
                profileWidget("Father Name",
                    homeController.studentModel.value.data!.fatherName!),
                profileWidget("Mother Name",
                    homeController.studentModel.value.data!.motherName!),
                profileWidget(
                    "Date of Birth",
                    homeController.studentModel.value.data!.dob!
                        .toString()
                        .split(" ")
                        .first),
                profileWidget(
                    "Gender", homeController.studentModel.value.data!.gender!),
                profileWidget("Nationality",
                    homeController.studentModel.value.data!.nationality!),
                profileWidget("Aadhar No",
                    homeController.studentModel.value.data!.aadharNo!),
                profileWidget("Mother Tongue",
                    homeController.studentModel.value.data!.montherTongue!),
                profileWidget("Blood Group",
                    homeController.studentModel.value.data!.bloodGroup!),
                profileWidget(
                    "Email", homeController.studentModel.value.data!.email!),
                profileWidget("Phone No",
                    homeController.studentModel.value.data!.phoneNo!),

                profileWidget("Father Profession",
                    homeController.studentModel.value.data!.fatherProfession!),
                // profileWidget("father_profession",
                //     homeController.studentModel.value.data!.nationality!),
                // profileWidget("father_profession",
                //     homeController.studentModel.value.data!.nationality!),
                // profileWidget("father_profession",
                //     homeController.studentModel.value.data!.nationality!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: const Text('Select Profile')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                IconButton(
                    iconSize: 70,
                    color: Colors.blue,
                    onPressed: () async {
                      var image =
                          await picker.pickImage(source: ImageSource.camera);

                      profile = File(image!.path);
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.camera_alt)),
                IconButton(
                    iconSize: 70,
                    color: Colors.blue,
                    onPressed: () async {
                      var image =
                          await picker.pickImage(source: ImageSource.gallery);

                      profile = File(image!.path);
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.image)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  profileWidget(String title, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headName(title),
        SizedBox(
          height: 7,
        ),
        subHeader(data),
        Divider(
          thickness: 1.5,
        )
      ],
    );
  }

  headName(String title) {
    return Text(
      title,
      style: TextStyle(
          color: Color(0xFF01579b).withOpacity(0.8),
          fontSize: 15,
          fontWeight: FontWeight.bold),
    );
  }

  subHeader(String data) {
    return Text(
      data,
      style: TextStyle(fontSize: 18),
    );
  }
}
