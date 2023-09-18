// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;
  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    myRepo.loginApi(data).then((value) {
      setLoading(false);
      Utils.toastMessage('Login Successfully');
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBar(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> signupApi(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    myRepo.signUpApi(data).then((value) {
      setSignUpLoading(false);
      Utils.toastMessage('SignUp Successfully');
      Navigator.pushNamed(context, RoutesName.login);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setSignUpLoading(false);
      Utils.flushBar(error.toString(), context);
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
