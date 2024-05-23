import 'dart:developer';
import 'package:architecture/general/core/sort_enum.dart';
import 'package:architecture/general/services/toast_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../data/model/user_model.dart';
import '../../repo/i_home_impl.dart';

class HomeProvider extends ChangeNotifier {
  AgeType selectedValue = AgeType.all;
  changeValue(AgeType value) {
    selectedValue = value;
    notifyListeners();
  }

  HomeProvider() {
    getUsers(selectedValue);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isMoreDataLoading) {
        getUsers(selectedValue); // lazy loading funtionality
      }
    });
  }
  List<UserModel> usersList = [];
  QueryDocumentSnapshot<Object>? lastDocs;
  UserRepository userRepository = UserRepository();
  final ScrollController scrollController = ScrollController();
  bool isMoreDataLoading = true;
  bool isLoading = false;

  //Get Users Data
  Future<void> getUsers(AgeType ageType) async {
    isLoading = true;
    final data = await userRepository.getUsers(ageType);
    data.fold((error) {
      log(error);
      if (error == 'No More Data') {
        isMoreDataLoading = false;
        ToastMessage.showMessage(error, Colors.red);
        isMoreDataLoading = true;
        notifyListeners();
      } else {
        isMoreDataLoading = false;
        notifyListeners();
      }
    }, (data) {
      if (data.length != 7) {
        isMoreDataLoading = false;
        log('----------$isMoreDataLoading.toString()');
      }
      log(isMoreDataLoading.toString());
      usersList = [...usersList, ...data];
      notifyListeners();
    });
    isLoading = false;
    // isMoreDataLoading = false;
    notifyListeners();
  }

  //add user user localy
  void addUserLocaly(UserModel userData) {
    usersList.insert(0, userData);
    notifyListeners();
  }

  //clear previous datas
  void clearData() {
    userRepository.lastDocs = null;
    isMoreDataLoading = true;
    usersList.clear();
    notifyListeners();
  }
}
