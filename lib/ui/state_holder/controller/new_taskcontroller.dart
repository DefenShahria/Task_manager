import 'package:get/get.dart';
import 'package:task1/data/urls.dart';
import 'package:task1/network/networkcaller.dart';
import 'package:task1/network/networkresponse.dart';
import 'package:task1/ui/state_holder/model_calsses/newTask_model.dart';


class NewTaskController extends GetxController{
  bool _getNewTaskInProgress = false;
  NewTask _newTask = NewTask();
  NewTask get newtask => _newTask;
  String _errorMessage = '';

  bool get getNewTaskInProgress => _getNewTaskInProgress;
  String get errorMessage => _errorMessage;

  Future<bool>getNewTask()async{
    _getNewTaskInProgress = true;
    update();
    final Networkresponse response =await Networkcall.getRequest(Urls.NewTask);
    _getNewTaskInProgress = false;
    if(response.issuccess){
      _newTask = NewTask.fromJson(response.responseJson!);
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