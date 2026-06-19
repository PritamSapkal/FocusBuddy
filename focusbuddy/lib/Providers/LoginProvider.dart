import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Keys/AllKeys.dart';

class Loginprovider extends ChangeNotifier {
  bool _islogedin = false;
  String _username = '';
  bool _hasLoaded = false; // <-- NEW: Tracks if SharedPreferences is done

  Loginprovider() {
    _isLogedstatus();
  }

  bool get isLogedin => _islogedin;
  String get username => _username;
  bool get hasLoaded => _hasLoaded; // <-- NEW: Getter for the UI

  void setLoginStatus(bool status, String username) async {
    _islogedin = status;
    _username = status ? username : '';
    notifyListeners();
    var ref = await SharedPreferences.getInstance();
    if (status) {
      ref.setBool(LoginKey, status);
      ref.setString(UsernameKey, username);
    } else {
      ref.remove(LoginKey);
      ref.remove(UsernameKey);
    }
  }

  void _isLogedstatus() async {
    var ref = await SharedPreferences.getInstance();
    _islogedin = ref.getBool(LoginKey) ?? false;
    _username = ref.getString(UsernameKey) ?? '';
    _hasLoaded = true; // <-- NEW: Disk reading is officially finished!
    notifyListeners();
  }
}