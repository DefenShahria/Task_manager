import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/data/urls.dart';
import 'package:task1/network/networkcaller.dart';
import 'package:task1/network/networkresponse.dart';


class AddNewTaskController extends GetxController {
  bool _newTaskInProgress = false;
  bool get newTaskInProgress => _newTaskInProgress;

  Future<bool> addNewTask(String title, String des, String status) async {
    _newTaskInProgress = true;
    update();
    Networkresponse response = await Networkcall().postRequest(Urls.Addtask,{
      "title": title,
      "description": des,
      "status": status,
    } );
    _newTaskInProgress = false;
    update();
    log('Response: ${response.responseJson}');
    if (response.issuccess) {
      Get.snackbar(
        'Task Status',
        'Task added successfully',
      );
      return true;
    } else {
      Get.snackbar(
        'Task Status',
        'Task add failed',
        backgroundColor: Colors.red,
      );
      return false;
    }
  }
}