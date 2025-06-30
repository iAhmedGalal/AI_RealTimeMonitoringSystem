import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject/core/utils/app_assets.dart';
import 'package:graduationproject/core/utils/app_colors.dart';
import 'package:graduationproject/core/utils/app_strings.dart';
import 'package:graduationproject/core/utils/app_styles.dart';
import 'package:graduationproject/shared/widgets/custome_button_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  final Stream<QuerySnapshot> _liveStream = FirebaseFirestore.instance
      .collection('live_detection').snapshots();

  bool isGood = true;

  void initializeVideo(String path) {
    _controller = VideoPlayerController.asset(path)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  void switchVideo(bool showGoodVideo) {
    setState(() {
      isGood = showGoodVideo;
      _controller.pause();
      _controller.dispose();
      initializeVideo(isGood ? AppAssets.good : AppAssets.bad);
    });
  }

  @override
  void initState() {
    super.initState();
    initializeVideo(AppAssets.good);
  }

  @override
  void dispose() {
    _controller.dispose(); // مهم جدًا تنظيف الموارد
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            width: double.infinity,
            height: 350,
            child: _controller.value.isInitialized ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ) : Center(
              child: CircularProgressIndicator(
                color: AppColors.greenBackground,
              ),
            ),
          ),

          StreamBuilder<QuerySnapshot>(
            stream: _liveStream,
            builder: (context, snapshot) {
              List list = snapshot.data?.docs ?? [];

              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      AppStrings.somethingWentWrong,
                      style: textStyleColorBoldSize(AppColors.black, 18),
                    ),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      AppStrings.loading,
                      style: textStyleColorBoldSize(AppColors.black, 18),
                    ),
                  ),
                );
              }

              if (list.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      AppStrings.noData,
                      style: textStyleColorBoldSize(AppColors.black, 18),
                    ),
                  ),
                );
              }

              String detectedClass = list[0]['detected_classes'][0] ?? '';

              // Switch video based on detected class
              if ((isGood && detectedClass == "bad") ||
                  (!isGood && detectedClass != "bad")) {
                switchVideo(detectedClass != "bad");
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    list[0]['detected_classes'][0] ?? '',
                    style: textStyleColorBoldSize(AppColors.black, 18),
                  ),
                ),
              );
            }
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: AppStrings.focusAdjustment,
                textAlign: TextAlign.start,
                onPressed: () {},
              ),
              SizedBox(height: 12),
              CustomButton(
                text: AppStrings.resolutionSettings,
                textAlign: TextAlign.start,
                onPressed: () {},
              ),
              SizedBox(height: 12),
              CustomButton(
                text: AppStrings.zoomAndPan,
                textAlign: TextAlign.start,
                onPressed: () {},
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: AppStrings.stop,
                      textAlign: TextAlign.center,
                      textColor: AppColors.black,
                      borderColor: AppColors.borderColor,
                      backgroundColor: AppColors.white,
                      onPressed: () {
                        _controller.pause();
                      },
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      text: AppStrings.start,
                      textAlign: TextAlign.center,
                      textColor: AppColors.white,
                      backgroundColor: AppColors.primaryColor,
                      onPressed: () {
                        _controller.play();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
            ],
          ),
        ],
      )
    );
  }
}
