import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolmanegment/screens/Circular/controller/CircularController.dart';

import 'CircularDetails.dart';

class CircularScreen extends StatefulWidget {
  const CircularScreen({Key? key}) : super(key: key);

  @override
  State<CircularScreen> createState() => _CircularScreenState();
}

class _CircularScreenState extends State<CircularScreen> {
  final circularController = Get.put(CircularController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Circular"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: circularController.circularList.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () async {
                  var token = circularController.token;

                  await circularController.circularDetails(token!,
                      circularController.circularList[index].composeId!);

                  Get.to(CircularDetails());
                },
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff9be7ef),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF01579b),
                        offset: const Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 2.0,
                        spreadRadius: 1.0,
                      ), //BoxShadow
                      // BoxShadow(
                      //   color: Colors.white,
                      //   offset: const Offset(0.0, 0.0),
                      //   blurRadius: 0.0,
                      //   spreadRadius: 0.0,
                      // ), //BoxShadow
                    ],
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          circularController.circularList[index].title!,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          circularController.circularList[index].message!,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              circularController.circularList[index].timestamp!
                                  .split(" ")
                                  .first,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
