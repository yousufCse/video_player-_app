import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_app/core/uitls/colors.dart';
import 'package:video_player_app/core/uitls/size_config.dart';

class VideoInfoPage extends StatefulWidget {
  const VideoInfoPage({Key? key}) : super(key: key);

  @override
  _VideoInfoPageState createState() => _VideoInfoPageState();
}

class _VideoInfoPageState extends State<VideoInfoPage> {
  List videoInfo = [];
  bool _playArea = false;
  late VideoPlayerController _controller;
  bool _isPlying = false;
  bool _disposed = false;
  int _playingIndex = 0;

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
  void dispose() {
    super.dispose();
    _controller.pause();
    _controller.dispose();
    _disposed = true;
  }

  _initializeVideo(int index) {
    _controller = VideoPlayerController.network(videoInfo[index]['videoUrl'])
      ..initialize().then((_) {
        _controller.addListener(_onControllerUpdate);
        setState(() {});
        _controller.play();
      });
  }

  _onTapVideo(int index) {
    _playingIndex = index;
    _initializeVideo(index);
  }

  void _onControllerUpdate() async {
    if (!_controller.value.isInitialized) {}

    _isPlying = _controller.value.isPlaying;
  }

  @override
  Widget build(BuildContext context) {
    print('build: ');
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: _playArea == false
            ? BoxDecoration(
                gradient: LinearGradient(
                colors: [
                  AppColor.gradientFirst.withOpacity(0.9),
                  AppColor.gradientSecond.withOpacity(0.9)
                ],
                begin: FractionalOffset(0.0, 0.4),
                end: Alignment.topRight,
              ))
            : BoxDecoration(color: AppColor.gradientSecond),
        child: Column(
          children: [
            // First Section
            if (_playArea == false)
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
              )
            else
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        // top
                        Container(
                          height: 100,
                          width: SizeConfig.screenWidth,
                          padding: const EdgeInsets.only(
                              top: 50, left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  debugPrint('tapped');
                                  setState(() {
                                    _playArea = false;
                                    _controller.pause();
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                  color: AppColor.secondPageIconColor,
                                ),
                              ),
                              Icon(
                                Icons.info_outline,
                                size: 20,
                                color: AppColor.secondPageTopIconColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // middle
                    _buildPlayView(context),

                    // bottom
                    _buildControlView(context),
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

  Widget _buildPlayView(BuildContext context) {
    if (_controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(_controller),
      );
    } else {
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: Text(
            'Preparing...',
            style: TextStyle(fontSize: 20, color: Colors.white60),
          ),
        ),
      );
    }
  }

  Widget _buildControlView(BuildContext context) {
    return Container(
      height: 80,
      width: SizeConfig.screenWidth,
      color: AppColor.gradientSecond,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () async {
              int idx = _playingIndex - 1;

              if (idx >= 0 && videoInfo.length >= 0) {
                _initializeVideo(idx);
              } else {
                Get.snackbar('No Videos', 'No more videos');
              }
            },
            child: const Icon(
              Icons.fast_rewind,
              size: 36,
              color: Colors.white,
            ),
          ),
          TextButton(
            onPressed: () async {
              if (_isPlying) {
                _controller.pause();
              } else {
                _controller.play();
              }

              setState(() {});
            },
            child: Icon(
              _isPlying ? Icons.pause : Icons.play_arrow,
              size: 36,
              color: Colors.white,
            ),
          ),
          TextButton(
            onPressed: () async {
              int idx = _playingIndex + 1;

              if (idx <= videoInfo.length - 1) {
                _initializeVideo(idx);
              } else {
                Get.snackbar('No Videos', 'No more videos');
              }
            },
            child: const Icon(
              Icons.fast_forward,
              size: 36,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: videoInfo.length,
      itemBuilder: (_, index) {
        return GestureDetector(
            onTap: () {
              setState(() {
                if (_playArea == false) {
                  _playArea = true;
                }
              });
              _onTapVideo(index);
            },
            child: _buildCard(index));
      },
    );
  }

  _buildCard(int index) {
    final video = videoInfo[index];
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
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
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    video['time'],
                    style: const TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFFeaeefc),
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
