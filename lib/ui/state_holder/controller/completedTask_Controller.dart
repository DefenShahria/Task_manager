import 'package:get/get.dart';
import 'package:task1/data/urls.dart';
import 'package:task1/network/networkcaller.dart';
import 'package:task1/network/networkresponse.dart';
import 'package:task1/ui/state_holder/model_calsses/completedTask_model.dart';

class CompleteTaskController extends GetxController{
  bool _getCompleteTaskInProgress = false;
  CompletedTask _completedTask = CompletedTask();
  CompletedTask get completedtask => _completedTask;
  String _errorMessage = '';

  bool get getNewTaskInProgress => _getCompleteTaskInProgress;
  String get errorMessage => _errorMessage;

  Future<bool>getCompleteTask()async{
    _getCompleteTaskInProgress = true;
    update();
    final Networkresponse response =await Networkcall.getRequest(Urls.CompletedTask);
    _getCompleteTaskInProgress = false;
    if(response.issuccess){
      _completedTask = CompletedTask.fromJson(response.responseJson!);
      _errorMessage='Get Task Successfully';
      update();
      return true;
    }else{
      _errorMessage='Get Task Failed';
      update();
      return false;
    }

  }
}