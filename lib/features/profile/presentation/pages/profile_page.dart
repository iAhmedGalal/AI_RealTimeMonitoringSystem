import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduationproject/core/utils/app_colors.dart';
import 'package:graduationproject/core/utils/app_strings.dart';
import 'package:graduationproject/core/utils/app_styles.dart';

class UserProfilePage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Center(
        child: Text(
          AppStrings.noUserFound,
          style: textStyleColorBoldSize(AppColors.black, 16),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.greenBackground, AppColors.greenText],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: user!.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : null,
                  backgroundColor: Colors.white,
                  child: user!.photoURL == null
                      ? Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                ),
                SizedBox(height: 10),
                Text(
                  user!.displayName ?? AppStrings.username,
                  style: textStyleColorBoldSize(AppColors.white, 22),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildUserInfoTile(Icons.email, AppStrings.email, user!.email),
                _buildUserInfoTile(Icons.phone, AppStrings.phone, user!.phoneNumber),
                _buildUserInfoTile(Icons.verified_user, AppStrings.userId, user!.uid),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppStrings.logoutSuccess)),
                    );
                  },
                  icon: Icon(Icons.logout, color: AppColors.white),
                  label: Text(AppStrings.logout, style: textStyleColorBoldSize(AppColors.white, 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoTile(IconData icon, String title, String? value) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.greenBackground
        ),
        title: Text(
          title,
          style: textStyleColorBoldSize(AppColors.greenBackground, 16)
        ),
        subtitle: Text(
          value ?? AppStrings.notAvailable,
          style: textStyleColorNormalSize(AppColors.black, 14)
        ),
      ),
    );
  }
}
