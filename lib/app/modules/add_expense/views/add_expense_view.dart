import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_money/app/utils/app_color.dart';
import 'package:my_money/app/widgets/custom_input.dart';

import '../controllers/add_expense_controller.dart';

// ignore: must_be_immutable
class AddExpenseView extends GetView<AddExpenseController> {
  late double mWidth;
  late double mHeight;
  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height / 1.2;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title: const Text('Tambah Pengeluaran',
               style: TextStyle(
                color: Color(0xFFFF5A5A)),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: mHeight,
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Form untuk tanggal
                    CustomInput(
                      controller: controller.dateC,
                      label: "Tanggal",
                      hint: "Pilih tanggal",
                      suffixIcon: const Icon(
                        Icons.date_range,
                        color: Colors.grey,
                      ),
                      isDate: true,
                    ),
                    // Form untuk nominal uang
                    CustomInput(
                      controller: controller.nominalC,
                      label: "Nominal",
                      hint: "Masukkan nominal",
                      suffixIcon: const Icon(
                        Icons.money,
                        color: Colors.grey,
                      ),
                      isNumber: true,
                      isNominal: true,
                    ),
                    // Form untuk keterangan
                    CustomInput(
                      controller: controller.descriptionC,
                      label: "Keterangan",
                      hint: "Masukkan keterangan",
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.resetForm();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      primary: AppColor.warning,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'FontLato',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          await controller.addExpense();
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
                        (controller.isLoading.isFalse)
                            ? 'Simpan'
                            : 'Loading...',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'FontLato',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      primary: AppColor.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      '<< Kembali',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'FontLato',
                        fontWeight: FontWeight.w500,
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
