import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player_app/core/uitls/colors.dart';
import 'package:video_player_app/core/uitls/size_config.dart';
import 'package:video_player_app/features/video_info/pages/video_info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List info = [];
  _initData() async {
    final String infoString = await rootBundle.loadString('json/info.json');
    final data = await jsonDecode(infoString);

    setState(() {
      info = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize SizeConfig class
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColor.homePageBackground,
      body: SizedBox(
        child: Container(
          padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
          child: Column(
            children: [
              // AppBar
              Row(
                children: [
                  Text(
                    'Training',
                    style: TextStyle(
                      fontSize: 30,
                      color: AppColor.homePageTitle,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(child: Container()),
                  Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: AppColor.homePageIcons,
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                    color: AppColor.homePageIcons,
                  ),
                  SizedBox(width: 15),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: AppColor.homePageIcons,
                  )
                ],
              ),
              const SizedBox(height: 20),

              // Sub Title
              Row(
                children: [
                  Text(
                    'Your program',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColor.homePageSubtitle,
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColor.homePageDetail,
                    ),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Get.to(() => const VideoInfoPage());
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: AppColor.homePageIcons,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 20),

              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColor.gradientFirst.withOpacity(0.8),
                      AppColor.gradientSecond.withOpacity(0.9),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(5, 10),
                      blurRadius: 20,
                      color: AppColor.gradientSecond.withOpacity(0.2),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(80),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Next workout',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.homePageContainerTextSmall,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Legs Toning\nand Glutes Workout',
                        style: TextStyle(
                          fontSize: 25,
                          color: AppColor.homePageContainerTextSmall,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.timer,
                                size: 20,
                                color: AppColor.homePageContainerTextSmall,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '60 min',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColor.homePageContainerTextSmall),
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: AppColor.gradientFirst,
                                blurRadius: 10,
                                offset: const Offset(4, 8),
                              ),
                            ], borderRadius: BorderRadius.circular(60)),
                            child: const Icon(
                              Icons.play_circle_fill,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 5),
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage('assets/images/card.jpg'),
                          fit: BoxFit.fill,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 40,
                            offset: Offset(8, 10),
                            color: AppColor.gradientSecond.withOpacity(0.3),
                          ),
                          BoxShadow(
                            blurRadius: 40,
                            offset: Offset(-1, -5),
                            color: AppColor.gradientSecond.withOpacity(0.3),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      margin: EdgeInsets.only(right: 200, bottom: 30),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/figure.png')),
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 100,
                      margin: const EdgeInsets.only(left: 150, top: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'You are doing great',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.homePageDetail,
                            ),
                          ),
                          const SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              text: 'Keep it up\n',
                              style: TextStyle(
                                color: AppColor.homePagePlanColor,
                                fontSize: 16,
                              ),
                              children: [
                                TextSpan(
                                  text: 'stick to your plan',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  Text(
                    'Area of focus',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: AppColor.homePageTitle),
                  )
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: OverflowBox(
                  maxWidth: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: (info.length.toDouble() / 2).toInt(),
                    itemBuilder: (_, i) {
                      int a = 2 * i;
                      int b = 2 * i + 1;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 30, top: 15),
                            height: 170,
                            width: (MediaQuery.of(context).size.width - 90) / 2,
                            padding: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(
                                  info[a]['img'],
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(5, 5),
                                  color:
                                      AppColor.gradientSecond.withOpacity(0.1),
                                ),
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(-5, -5),
                                  color:
                                      AppColor.gradientSecond.withOpacity(0.1),
                                ),
                              ],
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                info[a]['title'],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColor.homePageDetail,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          Container(
                            margin: EdgeInsets.only(bottom: 30, top: 15),
                            height: 170,
                            width: (MediaQuery.of(context).size.width - 90) / 2,
                            padding: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(
                                  info[b]['img'],
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(5, 5),
                                  color:
                                      AppColor.gradientSecond.withOpacity(0.1),
                                ),
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(-5, -5),
                                  color:
                                      AppColor.gradientSecond.withOpacity(0.1),
                                ),
                              ],
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                info[b]['title'],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: AppColor.homePageDetail,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
