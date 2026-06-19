import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Keys/AllKeys.dart';

class Taskprovider extends ChangeNotifier {
  String _userTask='';
  String get usertask=> _userTask;

  Taskprovider(){
    _getTask();
  }

  void addTask(String task)async{
    _userTask=task;
    notifyListeners();
    var ref= await SharedPreferences.getInstance();
    ref.setString(TaskKey, task );
  }

  void _getTask()async{
    var ref= await SharedPreferences.getInstance();
    _userTask=ref.getString(TaskKey) ?? '';
    notifyListeners();
  }
   void removeTask()async{
     _userTask='';
     notifyListeners();
     var ref = await SharedPreferences.getInstance();
     await ref.remove(TaskKey);
   }

}