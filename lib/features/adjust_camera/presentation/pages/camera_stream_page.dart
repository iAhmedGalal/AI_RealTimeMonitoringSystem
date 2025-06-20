import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:graduationproject/core/utils/app_assets.dart';
import 'package:graduationproject/core/utils/app_colors.dart';
import 'package:graduationproject/core/utils/app_strings.dart';
import 'package:graduationproject/core/utils/app_styles.dart';
import 'package:graduationproject/features/adjust_camera/presentation/widgets/camera_widget.dart';
import 'package:graduationproject/shared/storage_helper.dart';
import 'package:graduationproject/shared/widgets/custome_button_widget.dart';

class CameraStreamPage extends StatefulWidget {
  const CameraStreamPage({super.key});

  @override
  State<CameraStreamPage> createState() => _CameraStreamPageState();
}

class _CameraStreamPageState extends State<CameraStreamPage> {
  late VlcPlayerController _vlcViewController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initCamera();
    });
  }

  Future initCamera() async {
    _vlcViewController = VlcPlayerController.network(
      'rtsp://Camera1:Tapocam@192.168.1.12:554/stream1',
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() {
    _vlcViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            AppStrings.adjustCamera,
            style: textStyleColorBoldSize(AppColors.black, 18),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: ListView(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: VlcPlayer(
                controller: _vlcViewController,
                aspectRatio: 16 / 9,
                placeholder: Center(child: CircularProgressIndicator()),
              ),
            ),
            Spacer(),
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
                          _vlcViewController?.dispose();
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
                          initCamera();
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