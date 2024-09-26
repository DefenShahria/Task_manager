
import 'package:get/get.dart';
import 'package:task1/data/urls.dart';
import 'package:task1/network/networkcaller.dart';
import 'package:task1/network/networkresponse.dart';


class UpdatePostController extends GetxController{
  bool _getUpdatePostInProgress = false;
  String _errorMessage = '';

  bool get getUpdatePostInProgress => _getUpdatePostInProgress;
  String get errorMessage => _errorMessage;

  Future<bool>updatePost(String taskId, String status)async{
    _getUpdatePostInProgress = true;
    update();
    final Networkresponse response =await Networkcall.getRequest(Urls.TaskEdit("$taskId", "$status"));
    _getUpdatePostInProgress = false;
    if(response.issuccess){
      _errorMessage='Task Update Successfully';
      update();
      return true;
    }else{
      _errorMessage='Task Update Failed';
      update();
      return false;
    }

  }
}