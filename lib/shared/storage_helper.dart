import 'dart:convert';

import 'package:graduationproject/core/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/user_model.dart';

class StorageHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getStoredToken() {
    return sharedPreferences!.getString(AppConstants.token);
  }

  static Future<bool> storeToken(String token) async {
    return await sharedPreferences!.setString(AppConstants.token, token);
  }

  static dynamic getStoredUserData() {
    try {
      // Read the stored response asynchronously
      String? responseString = sharedPreferences!.getString(AppConstants.userData);

      // Log the raw value
      print("value: $responseString");

      // Validate response
      if (responseString != null) {
        // Decode JSON data
        Map<String, dynamic> jsonData = jsonDecode(responseString);

        // Convert JSON to userModel
        UserModel userModel = UserModel.fromJson(jsonData);

        // Log the entity
        print("Data: ${userModel.toJson()}");

        // Return the entity
        return userModel;
      } else {
        throw Exception("No data found in storage for 'userData'");
      }
    } catch (e) {
      print("Error in getStoredUserData: $e");
      rethrow; // Propagate the error to the caller
    }
  }

  static Future<bool> storeUserData(UserModel response) async {
    String responseString = jsonEncode(response.toJson());
    return await sharedPreferences!.setString(AppConstants.userData, responseString);
  }
}