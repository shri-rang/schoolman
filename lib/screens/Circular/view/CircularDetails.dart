import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolmanegment/screens/Circular/controller/CircularController.dart';

class CircularDetails extends StatefulWidget {
  const CircularDetails({Key? key}) : super(key: key);

  @override
  State<CircularDetails> createState() => _CircularDetailsState();
}

class _CircularDetailsState extends State<CircularDetails> {
  final circularController = Get.put(CircularController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      height: 200,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              circularController
                                  .circularDetailsModel.value.data!.title!,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  circularController.circularDetailsModel.value
                                      .data!.timestamp!
                                      .toString()
                                      .split(" ")
                                      .first,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          )),
    );
  }
}
