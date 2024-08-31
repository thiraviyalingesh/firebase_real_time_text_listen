import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mvvmbasic/repository/home_repository.dart';

import '../models/text_response_model.dart';
import '../services/firebase_helper.dart';
import '../utils/firebase_paths.dart';
import 'my_notifier.dart';

class HomeProvider extends ChangeNotifier with MyNotifier {


  HomeProvider(){
    textApiCall();
    firebaseTextListen();
  }

  final HomeRepository _homeRepository = HomeRepository();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isError = false;

  bool get isError => _isError;

  set setIsError(bool value) {
    _isError = value;
    notifyListeners();
  }

  TextResponseModel? textResponseModel;

  Future<dynamic> textApiCall() async {
    setIsLoading = true;
    setIsError = false;
    var data = await _homeRepository.textApi();

    if (data != null) {
      data as TextResponseModel;
      textResponseModel = data;

      print("data get ${textResponseModel?.text}");
    } else {
      setIsError = true;
    }

    setIsLoading = false;
  }


  ///firebase listen function for orders

  FirebaseHelper firebaseHelper = Get.find();

  void firebaseTextListen() {
    bool textStatus = false;
    firebaseHelper.userDatabase =
        FirebaseDatabase.instance.ref(fbTextPath);
    if (firebaseHelper.fbListener != null) {
      firebaseHelper.fbListener!.cancel();
    }

    firebaseHelper.userDatabase?.onValue.listen((DatabaseEvent event) async {
      print("firebase start listening orders");

      firebaseHelper.userDatabase = FirebaseDatabase.instance.ref(fbTextPath);

      try {
        /// Directly get the data from the database
        DataSnapshot snapshot =
        await firebaseHelper.userDatabase!.child("status").get();

        if (snapshot.exists) {
          textStatus = snapshot.value == true;
          if (textStatus) {
            await textApiCall();
          }
        } else {
          debugPrint("No data available");
        }
      } catch (e) {
        print("Error getting data: $e");
      }

      ///<====================================================================>
    });
  }


}
