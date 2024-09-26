class Urls {
  static const String baseUrl = 'http://152.42.163.176:2006/api/v1';

  static const String SignUp = '$baseUrl/Registration';
  static const String SignIn = '$baseUrl/Login';
  static const String Addtask = '$baseUrl/createTask';
  static const String NewTask = '$baseUrl/listTaskByStatus/New';
  static const String CompletedTask = '$baseUrl/listTaskByStatus/Completed';
  static const String All_Category = '$baseUrl/get-all/category';
  static String TaskDelet(String id) => '$baseUrl/deleteTask/$id';
  static String TaskEdit(String id,String status) => '$baseUrl/updateTaskStatus/$id/$status';

}
