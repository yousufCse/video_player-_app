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
    _init();
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

                    Expanded(child: _buildListView()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: videoInfo.length,
      itemBuilder: (_, index) {
        return GestureDetector(
            onTap: () {
              debugPrint(index.toString());
            },
            child: _buildCard(index));
      },
    );
  }

  _buildCard(int index) {
    final video = videoInfo[index];
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      // height: 135,
      // width: 200,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(video['thumbnail']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video['title'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    video['time'],
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFFeaeefc),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    '15s rest',
                    style: TextStyle(
                      color: Color(0xff839fed),
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 78; i++)
                    Container(
                      width: 3,
                      height: 1,
                      decoration: BoxDecoration(
                        color:
                            i.isEven ? const Color(0xFF839fed) : Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
