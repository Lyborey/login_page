import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:login_page/controller/api_base_helper.dart';
import 'package:login_page/models/login_model.dart';

class AppController extends GetxController {
  final codePhone = '+855'.obs;
  final userphone = ''.obs;
  final phoneNumber = ''.obs;

  final userSignin = ''.obs;
  final userphoneSignin = ''.obs;
  final passSignin = ''.obs;

  final otp = ''.obs;
  final password = ''.obs;
  final isView1 = false.obs;
  final rePassword = ''.obs;
  final isView2 = false.obs;

  final isPhoneNumber =false.obs;
  final isPassword =false.obs;

  int start = 30;
  late Timer _timer;

  void startTime() {
    const one = Duration(seconds: 1);
    start = 30;
    _timer = Timer.periodic(one, (timer) {
      if (start == 0) {
        timer.cancel();
      } else {
        start--;
      }
      update();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  ApiBaseHelper api = ApiBaseHelper();
  LoginModel loginModel = const LoginModel();
  final errorMsg = ''.obs;
  final isLoading = true.obs;

  loginApi({required String phone, required String pass}) {
    api
        .onNetworkRequesting(
            url: '/api/v1/customer/login/',
            methode: METHODE.post,
            body: {"username": phone, "password": pass},
            isAuthorize: false)
        .then((value) {
      Future.delayed(const Duration(seconds: 3), () {
        isLoading.value = false;
      });
      loginModel = LoginModel.fromJson(value);
      debugPrint('Login Success:');
    }).onError((ErrorModel error, stackTrace) {
      isLoading.value = false;
      loginModel = LoginModel.fromJson(error.bodyString);
    });
  }

  sentOtp({required String phone}) {
    api
        .onNetworkRequesting(
            url: '/api/v1/customer/getotp/',
            methode: METHODE.post,
            body: {"phone": phone},
            isAuthorize: false)
        .then((value) {
          loginModel = LoginModel.fromJson(value);
      debugPrint('Sent Otp Success:');
    }).onError((ErrorModel error, stackTrace) {
      isLoading.value = false;
      loginModel = LoginModel.fromJson(error.bodyString);
    });
  }

  verifyOtp({required String phone, required String otp}) {
    api
        .onNetworkRequesting(
            url: '/api/v1/customer/verify/',
            methode: METHODE.post,
            body: {"phone": phone, "otp": otp, "channel": "sms"},
            isAuthorize: false)
        .then((value) {
      loginModel = LoginModel.fromJson(value);
      debugPrint('Vertify Success:');
    }).onError((ErrorModel error, stackTrace) {
      isLoading.value = false;
      loginModel = LoginModel.fromJson(error.bodyString);
    });
  }

  signUpApi({required String password, required String phone}) {
    api
        .onNetworkRequesting(
            url: '/api/v1/customer/signup/',
            methode: METHODE.post,
            body: {
              "password": password,
              "username": phone,
              "phone": phone,
              "channel": "sms"
            },
            isAuthorize: false)
        .then((value) {
      debugPrint('Sign up Success:');
    }).onError((ErrorModel error, stackTrace) {
      isLoading.value = false;
      loginModel = LoginModel.fromJson(error.bodyString);
    });
  }
}
