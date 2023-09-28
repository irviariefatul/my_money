import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_money/app/routes/app_pages.dart';
import 'package:my_money/app/utils/app_color.dart';
import 'package:my_money/app/utils/database_helper.dart';
import 'package:my_money/app/utils/hash_password.dart';

class SettingController extends GetxController {
  //TODO: Implement SettingController

  RxBool isLoading = false.obs;
  RxBool obsecureText = true.obs;
  RxBool obsecureTextNew = true.obs;
  TextEditingController passC = TextEditingController();
  TextEditingController passNewC = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  final box = GetStorage();

  @override
  void onInit() {
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

  // Mengganti password
  Future<void> changePassword() async {
    String currentPassword = passC.text;
    String newPassword = passNewC.text;
    final db = await dbHelper.database; // Mengakses database 

    // Mendapatkan password saat ini dari database untuk username yang telah ditentukan
    final List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [box.read('user_id')],
    );

    if (users.isNotEmpty) {
      final storedPassword = users[0]['password'] as String;

      // Periksa apakah password saat ini cocok dengan password yang disimpan
      if (checkPassword(currentPassword, storedPassword)) {
        // Encrypt password baru sebelum menyimpannya
        final hashedPassword = HashPassword(newPassword);

        // Update password di dalam database
        await db.update(
          'users',
          {'password': hashedPassword},
          where: 'id = ?',
          whereArgs: [box.read('user_id')],
        );

        passC.clear();
        passNewC.clear();

        Get.snackbar(
          'Berhasil',
          'Password berhasil diperbarui',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColor.primaryColor,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
          maxWidth: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20.0),
        );
      } else {
        // Menampilkan pesan error jika gagal memperbarui password
        Get.snackbar(
          'Error',
          'Gagal memperbarui password',
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

  bool checkPassword(String inputPassword, String storedPassword) {
    // Implementasi metode enkripsi yang sama seperti yang digunakan sebelumnya
    final hashedInputPassword = HashPassword(inputPassword);

    // Membandingkan password yang dimasukkan dengan yang disimpan di database
    return hashedInputPassword == storedPassword;
  }
  
  Future<void> logout() async {
    box.remove("user_id");
    box.remove("username");
    Get.offNamed(Routes.LOGIN);
  }
}
