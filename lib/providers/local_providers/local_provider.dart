import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:path_provider/path_provider.dart';
import '../../custom_widgets/custom_text.dart';
import '../../repository/local_repository.dart';
import '../../services/firebase_helper.dart';
import '../../utils/global_functions.dart';
import '../../utils/global_variables.dart';
import '../../utils/routes.dart';
import '../my_notifier.dart';

class LocaleProvider extends ChangeNotifier with MyNotifier {
  BuildContext? context;

  final LocalRepository _localRepository = LocalRepository();
  FirebaseHelper firebaseHelper = Get.find();

  String? _fcmToken = "";

  String? get fcmToken => _fcmToken;

  init(BuildContext context) async {
    // setUpFirebase();

    _fcmToken = await FirebaseMessaging.instance.getToken();

    print("trokeeeeee $_fcmToken ");
    notifyListeners();
  }

  // Future setUpFirebase(String userId) async {
  //   var path = fbCheckInPath.replaceAll("{{check_in_id}}", userId);
  //   firebaseHelper.userDatabase = FirebaseDatabase.instance.ref(path);
  //   if (firebaseHelper.fbListener != null) {
  //     firebaseHelper.fbListener!.cancel();
  //   }
  //
  //   firebaseHelper.fbListener = firebaseHelper.userDatabase?.onValue
  //       .listen((DatabaseEvent event) async {
  //     if (!firebaseHelper.isFirstChecked) {
  //       firebaseHelper.isFirstChecked = true;
  //     } else {
  //       ///CheckIn
  //       var login = sharedPref.getMap(PrefKeys.loginData);
  //       bool checkInStatus = false;
  //
  //       /// Access the user section of the response
  //       var user = login['data'];
  //
  //       var userId = "${user['employee_check_id']}";
  //       var path = fbCheckInPath.replaceAll("{{check_in_id}}", userId);
  //
  //       firebaseHelper.userDatabase = FirebaseDatabase.instance.ref(path);
  //
  //       ///<===================================================================>
  //
  //       ///user check in status
  //
  //       try {
  //         /// Listen for changes in the database
  //         firebaseHelper.fbListener =
  //             firebaseHelper.userDatabase!.onValue.listen(
  //                   (DatabaseEvent event) async {
  //                 print("Listener triggered");
  //                 try {
  //                   checkInStatus =
  //                       event.snapshot.child("check_in_status").value == true;
  //                   print("checkInStatus: $checkInStatus");
  //                   if (!checkInStatus) {
  //                     print("Get.currentRoute ${Get.currentRoute}");
  //                     if (!(Get.currentRoute == "${AppRoutes.splashScreen}" ||
  //                         Get.currentRoute == "${AppRoutes.loginScreen}" ||
  //                         Get.currentRoute == "${AppRoutes.otpScreen}" ||
  //                         Get.currentRoute == "${AppRoutes.requestOTPScreen}")) {
  //                       //  print("auto checkout");
  //                       SnackBarHelper().showToast(
  //                         "checkout_info".i18n(),
  //                         false,
  //                         false,
  //                       );
  //                       Future.delayed(const Duration(seconds: 5), () {
  //                         exit(0);
  //                       });
  //                     }
  //                   }
  //                 } catch (e) {
  //                   print("Error in listener: $e");
  //                 }
  //               },
  //               onError: (error) {
  //                 print("Listener error: $error");
  //               },
  //             );
  //       } catch (e) {
  //         print("Error setting up listener: $e");
  //         return;
  //       }
  //
  //       ///<===================================================================>
  //
  //       ///USER DELETED
  //       try {
  //         var isDeleted = event.snapshot.child("is_deleted").value == true;
  //         //   print(isDeleted);
  //         if (isDeleted) {
  //           sharedPref.clearPref();
  //           notifyListeners();
  //           SnackBarHelper().showToast("user_delete_info".i18n(), false, false);
  //           Future.delayed(const Duration(seconds: 5), () {
  //             exit(0);
  //           });
  //         } else {}
  //       } catch (E) {
  //         print(E);
  //       }
  //
  //       ///<===================================================================>
  //
  //       ///ROLE CHANGED
  //
  //       try {
  //         var isRoleChange =
  //             event.snapshot.child("is_role_changed").value == true;
  //         if (isRoleChange) {
  //           SnackBarHelper().showToast("update_info".i18n(), false, false);
  //           Future.delayed(const Duration(seconds: 5), () {
  //             sharedPref.clearPref();
  //             notifyListeners();
  //             navigateDeleteAll(AppRoutes.loginScreen);
  //             // exit(0);
  //           });
  //         } else {}
  //       } catch (E) {
  //         print(E);
  //       }
  //     }
  //   });
  // }
}
