import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_money/app/utils/app_color.dart';
import 'package:my_money/app/widgets/custom_input.dart';

import '../controllers/login_controller.dart';

// ignore: must_be_immutable
class LoginView extends GetView<LoginController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: mHeight,
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: mWidth / 1.0,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'My Money',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'FontLato',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'V 1.0',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'FontLato',
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInput(
                  controller: controller.usernameC,
                  label: "Username",
                  hint: "Masukkan username",
                ),
                Obx(
                  () => CustomInput(
                    controller: controller.passC,
                    label: "Password",
                    hint: "Masukkan password",
                    obsecureText: controller.obsecureText.value,
                    suffixIcon: IconButton(
                      icon: (controller.obsecureText != false)
                          ? SvgPicture.asset('assets/icons/show.svg')
                          : SvgPicture.asset('assets/icons/hide.svg'),
                      onPressed: () {
                        controller.obsecureText.value =
                            !(controller.obsecureText.value);
                      },
                    ),
                  ),
                )
              ],
            ),
            Obx(
              () => Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      await controller.login();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    elevation: 0,
                    primary: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    (controller.isLoading.isFalse) ? 'Login' : 'Loading...',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'FontLato',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
