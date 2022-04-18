import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:login_page/controller/app_controller.dart';
import 'package:login_page/page/signup_page.dart';
import 'package:login_page/page/success_page.dart';
import 'package:login_page/widgets/custom_button.dart';
import 'package:login_page/widgets/custom_text_field.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Welcome',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Please enter your phone number and password to continue.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GetBuilder(
                      initState: (_) {
                        con.userSignin.value = '';
                        con.passSignin.value = '';
                      },
                      init: con,
                      builder: (_) {
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
                                          if (con.userphoneSignin.value != '') {
                                            if (con.userphoneSignin.value[0] ==
                                                '0') {
                                              con.userSignin.value =
                                                  con.codePhone.value +
                                                      con.userphoneSignin
                                                          .substring(1)
                                                          .replaceAll(' ', '');
                                            } else {
                                              con.userSignin.value =
                                                  con.codePhone.value +
                                                      con.userphoneSignin.value
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
                                        value: con.userphoneSignin.value,
                                        format: [
                                          MaskedInputFormatter('000 000 000',
                                              allowedCharMatcher:
                                                  RegExp(r'[0-9]'))
                                        ],
                                        isHaveText:
                                            con.userphoneSignin.value != '',
                                        onChange: (val) {
                                          con.userphoneSignin.value = val!;
                                          if (con.userphoneSignin.value != '') {
                                            if (con.userphoneSignin.value[0] ==
                                                '0') {
                                              con.userSignin.value =
                                                  con.codePhone.value +
                                                      con.userphoneSignin
                                                          .substring(1)
                                                          .replaceAll(' ', '');
                                            } else {
                                              con.userSignin.value =
                                                  con.codePhone.value +
                                                      con.userphoneSignin.value
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
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 30),
                              child: CustomTextFeild(
                                  label: 'Password',
                                  inputType: TextInputType.visiblePassword,
                                  value: con.passSignin.value,
                                  isPassword: true,
                                  isHaveText: con.passSignin.value != '',
                                  isView: con.isView1.value,
                                  onView: () {
                                    con.isView1.value = !con.isView1.value;
                                    con.update();
                                  },
                                  onChange: (val) {
                                    con.passSignin.value = val!;
                                    con.update();
                                  }),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: con.userSignin.value.length >= 12 &&
                                      con.passSignin.isNotEmpty
                                  ? CustomAppButton(
                                      text: 'Sign In',
                                      onTap: () {
                                        con.loginApi(
                                            phone: con.userSignin.value,
                                            pass: con.passSignin.value);
                                        Future.delayed(
                                            const Duration(seconds: 1), () {
                                          if (con.loginModel.token == null) {
                                            Get.snackbar('Warning',
                                                '${con.loginModel.message}');
                                          } else {
                                            con.isLoading.value = true;
                                            con.update();
                                            Get.to(const SuccessPage());
                                          }
                                        });
                                      },
                                    )
                                  : const CustomAppButton(
                                      bgColor: Colors.grey,
                                      text: 'Sign In',
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
                          'Haven\'t registered yet?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(SignUpPage());
                          },
                          child: const Text(
                            'Create an account',
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
            ),
          ),
        ],
      ),
    );
  }
}
