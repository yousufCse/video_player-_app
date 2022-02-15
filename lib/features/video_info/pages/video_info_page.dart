import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player_app/core/uitls/colors.dart';

class VideoInfoPage extends StatefulWidget {
  const VideoInfoPage({Key? key}) : super(key: key);

  @override
  _VideoInfoPageState createState() => _VideoInfoPageState();
}

class _VideoInfoPageState extends State<VideoInfoPage> {
  List videoInfo = [];

  _init() async {
    final data = await rootBundle.loadString('json/videoinfo.json');
    final s = await jsonDecode(data);

    setState(() {
      videoInfo = s;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.gradientFirst.withOpacity(0.9),
              AppColor.gradientSecond.withOpacity(0.9)
            ],
            begin: FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          children: [
            // First Section
            Container(
              width: MediaQuery.of(context).size.width,
              height: 270,
              padding: EdgeInsets.only(top: 60, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 24,
                          color: AppColor.secondPageTopIconColor,
                        ),
                      ),
                      Icon(
                        Icons.info_outline,
                        size: 24,
                        color: AppColor.secondPageTopIconColor,
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        text: 'Legs Toning\n',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [TextSpan(text: 'and Glutes Workout')]),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            AppColor.secondPageContainerGradient1stColor,
                            AppColor.secondPageContainerGradient2ndColor
                          ]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer_sharp,
                              size: 20,
                              color: AppColor.secondPageTopIconColor,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '68 min',
                              style: TextStyle(
                                color: AppColor.secondPageTitleColor,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            AppColor.secondPageContainerGradient1stColor,
                            AppColor.secondPageContainerGradient2ndColor
                          ]),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.handyman_sharp,
                              size: 20,
                              color: AppColor.secondPageIconColor,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Resistent band, Kettlebell',
                              style: TextStyle(
                                  color: AppColor.secondPageTitleColor,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Second Section

            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Circuit1: Legs Toning',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.loop,
                              size: 20,
                              color: AppColor.loopColor,
                            ),
                            SizedBox(width: 5),
                            Text(
                              '3 sets',
                              style: TextStyle(
                                  color: AppColor.loopColor, fontSize: 15),
                            )
                          ],
                        ),
                      ],
                    ),
                    // ListView
                    // ListView()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
