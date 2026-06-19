import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Keys/AllKeys.dart';

class Counterprovider extends ChangeNotifier{
   int _count=0;
   Counterprovider(){
      _loadCount();
   }

   int currentcount()=> _count;
    void addCount() async {
      _count+=10;
      notifyListeners();
      var pref= await SharedPreferences.getInstance();
      pref.setInt(CountKey,_count);
   }

   void removeCount()async{
       _count-=10;
       notifyListeners();
       var pref= await SharedPreferences.getInstance();
       pref.setInt(CountKey,_count);
   }

   void _loadCount()async{
      var pref= await SharedPreferences.getInstance();
      _count= pref.getInt(CountKey) ?? 0;
      notifyListeners();

   }
   void setCountZero()async{
     _count=0;
     notifyListeners();
      var ref= await SharedPreferences.getInstance();
      await ref.remove(CountKey);
   }
}