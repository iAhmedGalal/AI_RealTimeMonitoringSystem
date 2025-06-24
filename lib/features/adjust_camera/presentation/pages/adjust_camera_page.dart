import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject/core/utils/app_assets.dart';
import 'package:graduationproject/core/utils/app_colors.dart';
import 'package:graduationproject/core/utils/app_strings.dart';
import 'package:graduationproject/core/utils/app_styles.dart';
import 'package:graduationproject/features/adjust_camera/presentation/widgets/camera_widget.dart';
import 'package:graduationproject/shared/storage_helper.dart';
import 'package:graduationproject/shared/widgets/custome_button_widget.dart';

class AdjustCameraPage extends StatefulWidget {
  const AdjustCameraPage({super.key});

  @override
  State<AdjustCameraPage> createState() => _AdjustCameraPageState();
}

class _AdjustCameraPageState extends State<AdjustCameraPage> {
  late CameraController? cameraController;
  late List<CameraDescription> cameras;

  final Stream<QuerySnapshot> _liveStream = FirebaseFirestore.instance
      .collection('live_detection').snapshots();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initCamera();
    });
  }

  Future initCamera() async {
    cameras = await availableCameras();

    cameraController = CameraController(cameras[0], ResolutionPreset.max);

    cameraController?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text(
      //     AppStrings.adjustCamera,
      //     style: textStyleColorBoldSize(AppColors.black, 18),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   scrolledUnderElevation: 0,
      // ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _liveStream,
        builder: (context, snapshot) {
          List list = snapshot.data?.docs ?? [];

          if (snapshot.hasError) {
            return Center(
              child: Text(
                AppStrings.somethingWentWrong,
                style: textStyleColorBoldSize(AppColors.black, 18),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text(
                AppStrings.loading,
                style: textStyleColorBoldSize(AppColors.black, 18),
              ),
            );
          }

          if (list.isEmpty) {
            return Center(
              child: Text(
                AppStrings.noData,
                style: textStyleColorBoldSize(AppColors.black, 18),
              ),
            );
          }

          return ListView(
            children: [
              SizedBox(
                width: double.infinity,
                height: 260,
                child: (cameraController != null)
                  ? CameraView(controller: cameraController!)
                  : Container(),
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      list[0]['detected_classes'][0] ?? '',
                      style: textStyleColorBoldSize(AppColors.black, 18),
                    ),
                  ),
                  SizedBox(height: 12),
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
                            cameraController?.dispose();
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
          );

          // return ListView.builder(
          //   itemCount: list.length,
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Text(
          //         list[index]['timestamp'].toString(),
          //         style: textStyleColorNormalSize(AppColors.black, 16),
          //       ),
          //     );
          //   },
          // );
        },
      )
    );
  }
}