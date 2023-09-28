import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_money/app/modules/home/controllers/home_controller.dart';
import 'package:my_money/app/routes/app_pages.dart';
import 'package:my_money/app/utils/app_color.dart';
import 'package:my_money/app/utils/database_helper.dart';

class AddExpenseController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController dateC = TextEditingController();
  TextEditingController nominalC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();

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

  Future<void> resetForm() async {
    dateC.text = "01-01-2021";
    nominalC.clear();
    descriptionC.clear();
  }

  // Mengambil input dari pengguna terkait pengeluaran kemudian menyimpannya dalam database status "expense".
  Future<void> addExpense() async {
    final date = dateC.text;
    final nominalWithRp = nominalC.text;
    final numericText = nominalWithRp.replaceAll("Rp ", "").replaceAll(".", "");
    final nominal = int.tryParse(numericText);
    final description = descriptionC.text;
    final status = "expense"; // Status income

    final cashflow = {
      'user_id': box.read('user_id'),
      'date': date,
      'nominal': nominal,
      'description': description,
      'status': status, // Konversi ke integer
    };

    final id = await dbHelper.insertCashflow(cashflow); // Memasukkan data ke dalam database dalam bentuk cashflow

    if (id != null) {
      final HomeController homeController = Get.put(HomeController());
      homeController.reInitialize();
      Get.offNamed(Routes.HOME);
      Get.snackbar(
        'Berhasil',
        'Data pengeluaran berhasil disimpan',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColor.primaryColor,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
        maxWidth: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20.0),
      );
    } else {
      // Menampilkan pesan error jika gagal menyimpan data
      Get.snackbar(
        'Error',
        'Gagal menyimpan data pengeluaran',
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
