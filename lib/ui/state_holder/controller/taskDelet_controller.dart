
import 'package:get/get.dart';
import 'package:task1/data/urls.dart';
import 'package:task1/network/networkcaller.dart';
import 'package:task1/network/networkresponse.dart';


class DeletPostController extends GetxController{
  bool _getDeletPostInProgress = false;
  String _errorMessage = '';

  bool get getDeletPostInProgress => _getDeletPostInProgress;
  String get errorMessage => _errorMessage;

  Future<bool>deletPost(String taskId)async{
    _getDeletPostInProgress = true;
    update();
    final Networkresponse response =await Networkcall.getRequest(Urls.TaskDelet("$taskId"));
    _getDeletPostInProgress = false;
    if(response.issuccess){
      _errorMessage='Task delete Successfully';
      update();
      return true;
    }else{
      _errorMessage='Task delete Failed';
      update();
      return false;
    }

  }
}