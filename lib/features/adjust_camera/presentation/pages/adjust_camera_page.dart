import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:graduationproject/core/utils/app_assets.dart';
import 'package:graduationproject/core/utils/app_colors.dart';
import 'package:graduationproject/core/utils/app_strings.dart';
import 'package:graduationproject/core/utils/app_styles.dart';
import 'package:graduationproject/features/adjust_camera/presentation/widgets/camera_widget.dart';
import 'package:graduationproject/shared/widgets/custome_button_widget.dart';

class AdjustCameraPage extends StatefulWidget {
  const AdjustCameraPage({super.key});

  @override
  State<AdjustCameraPage> createState() => _AdjustCameraPageState();
}

class _AdjustCameraPageState extends State<AdjustCameraPage> {
  late CameraController? cameraController;
  late List<CameraDescription> cameras;

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
      appBar: AppBar(
        title: Text(
          AppStrings.adjustCamera,
          style: textStyleColorBoldSize(AppColors.black, 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: (cameraController?.value.isInitialized ?? false)
                ? CameraView(controller: cameraController!)
                : Container(),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
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
                        onPressed: () {},
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
