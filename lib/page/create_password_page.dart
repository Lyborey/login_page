import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:login_page/page/signup_page.dart';
import 'package:login_page/page/success_page.dart';
import 'package:login_page/widgets/custom_button.dart';
import 'package:login_page/widgets/custom_text_field.dart';

import '../controller/app_controller.dart';

class CreatePasswordPage extends StatelessWidget {
  CreatePasswordPage({Key? key}) : super(key: key);
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
                      Get.offAll(SignUpPage());
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  GetBuilder(
                    initState: (_) {
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
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(50)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.lock,
                                  size: 40,
                                  color: Colors.white,
                                ),
                                Text(
                                  '****',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 85),
                            child: Column(
                              children: const [
                                Text(
                                  'Create Password',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'You will require this password when you log in to DiPMarts App.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                CustomTextFeild(
                                    label: 'Password',
                                    inputType: TextInputType.visiblePassword,
                                    value: con.password.value,
                                    isPassword: true,
                                    isHaveText: con.password.value != '',
                                    isView: con.isView1.value,
                                    onView: () {
                                      con.isView1.value = !con.isView1.value;
                                      con.update();
                                    },
                                    onChange: (val) {
                                      con.password.value = val!;
                                      con.update();
                                    }),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomTextFeild(
                                    label: 'Re-type Password',
                                    inputType: TextInputType.visiblePassword,
                                    value: con.rePassword.value,
                                    isPassword: true,
                                    isHaveText: con.rePassword.value != '',
                                    isView: con.isView2.value,
                                    onView: () {
                                      con.isView2.value = !con.isView2.value;
                                      con.update();
                                    },
                                    onChange: (val) {
                                      con.rePassword.value = val!;
                                      con.update();
                                    }),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: (con.password.value.length >= 5 &&
                                              con.password.value.length <= 18)
                                          ? const Color(0xFF12B8E2)
                                          : Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Must have 5-18 characters',
                                      style: TextStyle(
                                        color: (con.password.value.length >=
                                                    5 &&
                                                con.password.value.length <= 18)
                                            ? const Color(0xFF12B8E2)
                                            : Colors.white,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: (con.password.value
                                              .toLowerCase()
                                              .contains(RegExp(
                                                  r'^(?=.*?[a-z])(?=.*?[0-9])')))
                                          ? const Color(0xFF12B8E2)
                                          : Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Must have at least 1 number & 1 letter',
                                      style: TextStyle(
                                        color: (con.password.value
                                                .toLowerCase()
                                                .contains(RegExp(
                                                    r'^(?=.*?[a-z])(?=.*?[0-9])')))
                                            ? const Color(0xFF12B8E2)
                                            : Colors.white,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: (!con.password.value.contains(' '))
                                          ? const Color(0xFF12B8E2)
                                          : Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Must not have spaces',
                                      style: TextStyle(
                                        color:
                                            (!con.password.value.contains(' '))
                                                ? const Color(0xFF12B8E2)
                                                : Colors.white,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 130),
                            child: (con.password.value ==
                                        con.rePassword.value &&
                                    con.password.value.length >= 5 &&
                                    con.password.value.length <= 18 &&
                                    con.password.value.toLowerCase().contains(
                                        RegExp(r'^(?=.*?[a-z])(?=.*?[0-9])')) &&
                                    !con.password.value.contains(' '))
                                ? CustomAppButton(
                                    text: 'Confirm',
                                    onTap: () {
                                      con.signUpApi(
                                          password: con.password.value,
                                          phone: con.phoneNumber.value);
                                      Get.to(const SuccessPage());
                                    },
                                  )
                                : const CustomAppButton(
                                    text: 'Confirm',
                                    bgColor: Colors.grey,
                                  ),
                          )
                        ],
                      );
                    },
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
