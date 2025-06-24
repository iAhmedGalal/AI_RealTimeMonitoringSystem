import 'package:flutter/material.dart';
import 'package:graduationproject/core/utils/app_colors.dart';
import 'package:graduationproject/core/utils/app_strings.dart';
import 'package:graduationproject/core/utils/app_styles.dart';
import 'package:graduationproject/features/about/presentation/pages/about_page.dart';
import 'package:graduationproject/features/adjust_camera/presentation/pages/camera_stream_page.dart';
import 'package:graduationproject/features/profile/presentation/pages/profile_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    CameraStreamPage(),
    AboutUsPage(),
    UserProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _currentIndex == 0 ? AppStrings.adjustCamera : _currentIndex == 1 ? AppStrings.aboutUs : AppStrings.profile,
          style: textStyleColorBoldSize(AppColors.black, 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.greenBackground,
        selectedLabelStyle: textStyleColorNormalSize(AppColors.greenBackground, 16),
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_indoor),
            label: AppStrings.camera,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: AppStrings.aboutUs
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppStrings.profile
          ),
        ],
      ),
    );
  }
}
