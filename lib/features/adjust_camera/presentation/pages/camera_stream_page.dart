import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:graduationproject/core/utils/app_colors.dart';
import 'package:graduationproject/core/utils/app_constants.dart';
import 'package:graduationproject/core/utils/app_strings.dart';
import 'package:graduationproject/core/utils/app_styles.dart';
import 'package:graduationproject/shared/widgets/custome_button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CameraStreamPage extends StatefulWidget {
  const CameraStreamPage({super.key});

  @override
  State<CameraStreamPage> createState() => _CameraStreamPageState();
}

class _CameraStreamPageState extends State<CameraStreamPage> {
  bool isStreaming = false;

  VlcPlayerController _vlcViewController = VlcPlayerController.network(
    AppConstants.rtsp,
    hwAcc: HwAcc.full,
    autoPlay: true,
    options: VlcPlayerOptions(),
  );

  final Stream<QuerySnapshot> _liveStream = FirebaseFirestore.instance
      .collection('live_detection').snapshots();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      startStream();
    });
  }

  Future startStream() async {
    _vlcViewController = VlcPlayerController.network(
      AppConstants.rtsp,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );

    setState(() {
      isStreaming = true;
    });
  }

  void stopStream() {
    _vlcViewController.stop();
    _vlcViewController.dispose();

    setState(() {
      isStreaming = false;
    });
  }

  @override
  void dispose() {
    super.dispose();

    stopStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            SizedBox(
              width: double.infinity,
              height: 350,
              child: isStreaming ? VlcPlayer(
                controller: _vlcViewController,
                aspectRatio: 16 / 9,
                placeholder: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.greenBackground,
                  ),
                ),
              ) : Center(
                child: Text(
                  AppStrings.noStream,
                  style: textStyleColorBoldSize(AppColors.black, 18),
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
                          stopStream();
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
                          startStream();
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