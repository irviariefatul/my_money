import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_money/app/routes/app_pages.dart';
import 'package:my_money/app/utils/app_color.dart';
import 'package:my_money/app/utils/database_helper.dart';
import 'package:my_money/app/utils/hash_password.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool obsecureText = true.obs;
  TextEditingController usernameC = TextEditingController();
  TextEditingController passC = TextEditingController();

  @override
  void onInit() {
    final hashedPassword = HashPassword('user');
    DatabaseHelper.instance.addUser("user", hashedPassword); // Memasukkan data ke dalam database 
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> login() async {
    final username = usernameC.text;
    final password = passC.text;

    if (username.isEmpty || password.isEmpty) {
      // Menampilkan pesan login gagal karena form belum di isi
      Get.snackbar(
        'Login Gagal',
        'Masukkan username atau password',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColor.warning,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        maxWidth: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
      );
      return;
    }

    try {
      final isLoginSuccessful =
          await DatabaseHelper.instance.login(username, password); // Memasukkan data ke dalam database 

      if (isLoginSuccessful) {
        // Menampilan halaman home ketika login berhasil
        Get.offNamed(Routes.HOME);
        Get.snackbar(
          'Selamat Datang',
          'Ayo catat keuanganmu',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColor.primaryColor,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
          maxWidth: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
        );
      } else {
        // Menampilkan pesan error jika login yang dilakukan gagal
        Get.snackbar(
          'Login Gagal',
          'Username atau password salah',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColor.secondary,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
          maxWidth: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
        );
      }
    } catch (error) {
      // Menampilkan pesan error jika terdapat error
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: $error',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColor.secondary,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        maxWidth: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
      );
    }
  }
}
