import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:login_page/controller/app_controller.dart';
import 'package:login_page/page/create_password_page.dart';

class VerifyPage extends StatelessWidget {
  VerifyPage({Key? key}) : super(key: key);
  final con = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SvgPicture.asset('assets/bg.svg',fit: BoxFit.fill)),
          SizedBox(
            height: double.infinity,
            width: double.infinity,           
            child: SafeArea(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  GetBuilder(
                    initState: (_){
                      con.startTime();
                    },
                      init: con,
                      builder: (_) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  border: Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Icon(
                                Icons.lock,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 80),
                              child: Column(
                                children: [
                                  const Text(
                                    'Phone Verification',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'We have sent a verification code to ${con.phoneNumber.value} via SMS',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            OTPField(con: con),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 200),
                              child: Text(
                                (con.start < 10)
                                    ? '00:0${con.start}'
                                    : '00:${con.start}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OTPField extends StatelessWidget {
  const OTPField({
    Key? key,
    required this.con,
  }) : super(key: key);

  final AppController con;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomOtpField(
          onChange: (val) {
            con.otp.value = '';
            if (val != '') {
              FocusScope.of(context).nextFocus();
              if (con.otp.value.length != 1) {
                con.otp.value += val!;
              }
            } else {
              FocusScope.of(context).previousFocus();
            }
            debugPrint('${con.otp}');
            con.update();
          },
        ),
        CustomOtpField(
          onChange: (val) {
            if (val != '') {
              FocusScope.of(context).nextFocus();
              if (con.otp.value.length != 2) {
                con.otp.value += val!;
              }
            } else {
              con.otp.value = con.otp.value.substring(0, 1);
              FocusScope.of(context).previousFocus();
            }
            debugPrint('${con.otp}');
            con.update();
          },
        ),
        CustomOtpField(
          onChange: (val) {
            if (val != '') {
              FocusScope.of(context).nextFocus();
              if (con.otp.value.length != 3) {
                con.otp.value += val!;
              }
            } else {
              con.otp.value = con.otp.value.substring(0, 2);
              FocusScope.of(context).previousFocus();
            }
            debugPrint('${con.otp}');
            con.update();
          },
        ),
        CustomOtpField(
          onChange: (val) {
            if (val != '') {
              FocusScope.of(context).nextFocus();
              if (con.otp.value.length != 4) {
                con.otp.value += val!;
              }
            } else {
              con.otp.value = con.otp.value.substring(0, 3);
              FocusScope.of(context).previousFocus();
            }
            debugPrint('${con.otp}');
            con.update();
          },
        ),
        CustomOtpField(
          onChange: (val) {
            if (val != '') {
              FocusScope.of(context).nextFocus();
              if (con.otp.value.length != 5) {
                con.otp.value += val!;
              }
            } else {
              con.otp.value = con.otp.value.substring(0, 4);
              FocusScope.of(context).previousFocus();
            }
            debugPrint('${con.otp}');
            con.update();
          },
        ),
        CustomOtpField(
          onChange: (val) {
            if (val != '') {
              if (con.otp.value.length != 6) {
                con.otp.value += val!;                
                FocusScope.of(context).unfocus();
              }
              if(con.otp.value.length == 6){
                con.verifyOtp(phone: con.phoneNumber.value, otp: con.otp.value);
                Future.delayed(const Duration(seconds: 1),(){
                  if(con.loginModel.message == 'Verified'){
                  Get.to(CreatePasswordPage());
                }
                });
              }
            }
            if (val == '') {
              con.otp.value = con.otp.value.substring(0, 5);
              FocusScope.of(context).previousFocus();
            }                            
            debugPrint('${con.otp}');       
            con.update();
          },
        ),
      ],
    );
  }
}

class CustomOtpField extends StatelessWidget {
  final Function(String?)? onChange;
  const CustomOtpField({
    Key? key,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        autofocus: true,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, color: Color(0xFF12B8E2)),
        inputFormatters: [
          MaskedInputFormatter('0', allowedCharMatcher: RegExp(r'[0-9]'))
        ],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(15)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        onChanged: onChange,
      ),
    );
  }
}
