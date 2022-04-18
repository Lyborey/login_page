import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:login_page/controller/app_controller.dart';
import 'package:login_page/page/verify_page.dart';
import 'package:login_page/widgets/custom_button.dart';
import 'package:login_page/widgets/custom_text_field.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
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
              child: SvgPicture.asset('assets/bg.svg', fit: BoxFit.fill)),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: SafeArea(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(Icons.close_outlined),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Create an account',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/logo.svg',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/dip_mart.svg',
                                color: Colors.white,
                                width: 100,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SvgPicture.asset(
                                'assets/phrase.svg',
                                color: Colors.white,
                                width: 100,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        child: Column(
                          children: const [
                            Text(
                              'Let\'s get started',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Please enter your phone number to receive your confirmation code.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF2B2F7E),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: CountryCodePicker(
                                        barrierColor: Colors.black12,
                                        dialogSize: Size(
                                            double.infinity,
                                            MediaQuery.of(context).size.height *
                                                0.5),
                                        onChanged: (e) {
                                          con.codePhone.value = e.toString();
                                          if (con.userphone.value != '') {
                                            if (con.userphone.value[0] == '0') {
                                              con.phoneNumber.value =
                                                  con.codePhone.value +
                                                      con.userphone
                                                          .substring(1)
                                                          .replaceAll(' ', '');
                                            } else {
                                              con.phoneNumber.value =
                                                  con.codePhone.value +
                                                      con.userphone.value
                                                          .replaceAll(' ', '');
                                            }
                                          }
                                          con.update();
                                        },
                                        initialSelection: 'KH',
                                        padding: const EdgeInsets.all(0),
                                        textStyle: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 3,
                                    child: CustomTextFeild(
                                        label: 'Phone Number',
                                        inputType: TextInputType.number,
                                        value: con.userphone.value,
                                        format: [
                                          MaskedInputFormatter('000 000 000',
                                              allowedCharMatcher:
                                                  RegExp(r'[0-9]'))
                                        ],
                                        isHaveText: con.userphone.value != '',
                                        onChange: (val) {
                                          con.userphone.value = val!;
                                          if (con.userphone.value != '') {
                                            if (con.userphone.value[0] == '0') {
                                              con.phoneNumber.value =
                                                  con.codePhone.value +
                                                      con.userphone
                                                          .substring(1)
                                                          .replaceAll(' ', '');
                                            } else {
                                              con.phoneNumber.value =
                                                  con.codePhone.value +
                                                      con.userphone.value
                                                          .replaceAll(' ', '');
                                            }
                                          }
                                          con.update();
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: con.phoneNumber.value.length >= 12
                                  ? CustomAppButton(
                                      text: 'Continue',
                                      onTap: () {
                                        con.sentOtp(
                                            phone: con.phoneNumber.value);
                                        con.update();
                                        Future.delayed(
                                            const Duration(seconds: 1), () {
                                          if (con.loginModel.message !=
                                              'SMS sent.') {
                                            Get.snackbar('Warning',
                                                '${con.loginModel.message}');
                                          } else {
                                            Get.to(VerifyPage());
                                          }
                                        });
                                      },
                                    )
                                  : const CustomAppButton(
                                      bgColor: Colors.grey,
                                      text: 'Continue',
                                    ),
                            ),
                          ],
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.only(top: 110, bottom: 20),
                        child: Column(
                          children: [
                            const Text(
                              'Already registered?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
