import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolmanegment/constant.dart';
import 'package:schoolmanegment/screens/Attendance/AttendanceController.dart';
import 'package:schoolmanegment/screens/Attendance/AttendanceScreen.dart';
import 'package:schoolmanegment/screens/Circular/view/CircularScreen.dart';
import 'package:schoolmanegment/screens/ForgortPassword/view/Forgotpassword.dart';
import 'package:schoolmanegment/screens/HomeScreen/Controoler/HomeController.dart';
import 'package:schoolmanegment/screens/StudentDetails/StudentDetails.dart';
import 'package:schoolmanegment/screens/StudentDetails/profilePage.dart';
import 'package:schoolmanegment/screens/login/Controller/LoginController.dart';
import 'package:schoolmanegment/screens/login/View/LoginScreen.dart';
import 'package:schoolmanegment/utility.dart';

class HomeSreen extends StatefulWidget {
  const HomeSreen({Key? key}) : super(key: key);

  @override
  State<HomeSreen> createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {
  final homeController = Get.put(HomeController());
  final authController = Get.put(LoginController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall();
  }

  apiCall() async {
    var id = await getStudent();
    print(" hhWS $id");
    await homeController.studentDetails(id);
  }

  List names = [
    "Students Details",
    "Attendance Sheet",
    "Fees",
    "Circular",
    "Assignment",
    "School Websites",
    "Change Password",
    "Need Help ?"
  ];
  List img = [
    "https://development.erpsofts.com/public/asset/icon/student-details.png",
    "https://development.erpsofts.com/public/asset/icon/attendance.jpg",
    "https://development.erpsofts.com/public/asset/icon/fees.png",
    "https://development.erpsofts.com/public/asset/icon/circular.png",
    "https://development.erpsofts.com/public/asset/icon/homework.webp",
    "https://development.erpsofts.com/public/asset/icon/school-website.jpg",
    "https://development.erpsofts.com/public/asset/icon/change-password.png",
    "https://development.erpsofts.com/public/asset/icon/help.png"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff9be7ef),
          elevation: 0,
          // flexibleSpace:
          title: Obx(() => homeController.checkData.value
              ? Center(
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://development.erpsofts.com/writable/uploads/logo/${homeController.data.value.logo}",
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      homeController.data.value.name!,
                      maxLines: 1,
                      // softWrap: false,
                      // overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF01579b),
                      ),
                    ),

                    // Text(
                    //   homeController.data.value.name!,
                    //   maxLines: 2,
                    //   overflow: TextOverflow.clip,
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 23,
                    //     color: Color(0xFF01579b),
                    //   ),
                    // ),
                  ],
                ))
              : Container()),
          actions: [
            IconButton(
              onPressed: () async {
                await deleteToken();
                await deleteStudent();
                // Get.offAllNamed(onBoardingRoute);
                // Get.delete<ModuleService>();
                // Get.delete<BottomAppServices>();
                Get.deleteAll();
                Get.back();
                Get.offAll(LoginScreen());
              },
              icon: Icon(Icons.logout),
              color: Colors.black,
            )
            // ElevatedButton.icon(onPressed: (() {

            // }), icon: Icon( Icons.logout), label: Text("log"))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() => homeController.checkStudent.value
                    ? AppBar(
                        backgroundColor: Colors.white,
                        title: Row(
                          children: [
                            Text(
                              homeController.studentModel.value.data!.name!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF01579b),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "${homeController.studentModel.value.data!.classname!} / ${homeController.studentModel.value.data!.sectionName!}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF01579b)),
                            ),
                          ],
                        ))
                    : Container()

                // )
                ),
            //  Card(
            //       elevation: 5,
            //       child: Container(
            //           width: Get.width,
            //           padding:
            //               const EdgeInsets.only(top: 10, left: 10, bottom: 10),
            //           child:
            // Row(
            //             children: [
            //               Text(
            //                 homeController.studentModel.value.data!.name!,
            //                 style: TextStyle(fontWeight: FontWeight.bold),
            //               ),
            //               SizedBox(
            //                 width: 10,
            //               ),
            //               Text(
            //                 "${homeController.studentModel.value.data!.classname!} / ${homeController.studentModel.value.data!.sectionName!}",
            //                 style: TextStyle(fontWeight: FontWeight.bold),
            //               ),
            //             ],
            //           )),
            //     )

            Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.8, crossAxisCount: 3),
                    itemCount: names.length,
                    itemBuilder: (buildcontext, int) {
                      return GestureDetector(
                        onTap: () {
                          if (int == 0) {
                            Get.to(ProfilePage());
                          }
                          if (int == 1) {
                            Get.to(Attendance());
                          }
                          if (int == 3) {
                            Get.to(CircularScreen());
                          }
                          if (int == 6) {
                            Get.to(ForgetPassword());
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  img[int],
                                  width: 50,
                                  height: 100,
                                ),
                                Text(
                                  names[int],
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
