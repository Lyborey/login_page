import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_page/controller/app_controller.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final con = Get.put(AppController());
    return Obx(()=>(con.isLoading.value)
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: AppBar(
              title: const Text('Success'),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              foregroundColor: Colors.green,
              elevation: 0,
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xFF12B8E2).withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 10)
                      ]),
                  child:
                      const Icon(Icons.check, color: Colors.white, size: 40),
                ),
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    'Password has been created successfully',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )),
          )
  );

    }
}
