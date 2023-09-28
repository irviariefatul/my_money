import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_money/app/modules/home/views/widgets/line_chart_widget.dart';
import 'package:my_money/app/modules/home/views/widgets/menu_widget.dart';
import 'package:my_money/app/routes/app_pages.dart';
import 'package:my_money/app/utils/app_color.dart';
import 'package:my_money/app/utils/currency_format.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final double mWidth = MediaQuery.of(context).size.width;
    final double mHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: mHeight,
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 15),
            Container(
              height: 170,
              child: Obx(
                () {
                  int totalIncome = 0;
                  int totalExpense = 0;

                  for (final cashflow in controller.cashflows) {
                    if (cashflow.status == "income") {
                      totalIncome += cashflow.nominal; // Menghitung totalIncome dari yang berstatus "income" pada cashflow
                    } else if (cashflow.status == "expense") {
                      totalExpense += cashflow.nominal; // Menghitung totalExpense dari yang berstatus "expense" pada cashflow
                    }
                  }

                  return Column(
                    children: [
                      Container(
                        width: mWidth,
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            'Rangkuman Bulan Ini',
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: mWidth,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.lightgrey,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: -5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Pengeluaran ${FormattedNominal(totalExpense)}', // Menampilkan totalExpense
                              style: TextStyle(
                                color: AppColor.contentColorRed,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Pemasukan ${FormattedNominal(totalIncome)}", // Menampilkan totalIncome
                              style: TextStyle(
                                color: AppColor.contentColorGreen,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              height: 200,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1.0),
                    spreadRadius: -5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: LineChartWidget(
                isShowingMainData: true,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: [
                  buildMenuItem(
                    title: 'Tambah Pemasukan',
                    imagePath: 'assets/images/icon_income.png',
                    onTap: () => Get.toNamed(Routes.ADD_INCOME),
                  ),
                  buildMenuItem(
                    title: 'Tambah Pengeluaran',
                    imagePath: 'assets/images/icon_expense.png',
                    onTap: () => Get.toNamed(Routes.ADD_EXPENSE),
                  ),
                  buildMenuItem(
                    title: 'Detail Cash Flow',
                    imagePath: 'assets/images/icon_cash_flow.png',
                    onTap: () => Get.toNamed(Routes.DETAIL_CASH_FLOW),
                  ),
                  buildMenuItem(
                    title: 'Pengaturan',
                    imagePath: 'assets/images/icon_setting.png',
                    onTap: () => Get.toNamed(Routes.SETTING),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String title,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: MenuItem(
        title: title,
        image: AssetImage(imagePath),
      ),
    );
  }
}
