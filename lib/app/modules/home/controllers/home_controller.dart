import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:my_money/app/data/cashflow.dart';
import 'package:my_money/app/utils/database_helper.dart';
import 'package:my_money/app/utils/extract_month.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final dbHelper = DatabaseHelper.instance;
  RxList<CashFlow> cashflows = RxList<CashFlow>();

  // Deklarasi dan inisialisasi untuk list data totalIncome dan totalExpense
  RxList<FlSpot> incomeSpots = RxList<FlSpot>();
  RxList<FlSpot> expenseSpots = RxList<FlSpot>();

  @override
  void onInit() {
    super.onInit();
    loadCashflows();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void reInitialize() {
    onInit();
  }

  // Fungsi untuk mengisi data totalIncome dan totalExpense dari halaman cashflow
  void fillSpotsFromCashflows(List<CashFlow> cashflows) {
    // Membersikan list sebelum mengisi ulang
    incomeSpots.clear();
    expenseSpots.clear();

    // Membuat map untuk mengelompokkan nilai berdasarkan tanggal
    final incomeMap = <double, double>{};
    final expenseMap = <double, double>{};

    // Iterasi melalui cashflows
    for (final cashflow in cashflows) {
      final date = cashflow.date; 
      final nominal = cashflow.nominal.toDouble(); // Mengubah ke double

      // Menentukan apakah ini income atau expense berdasarkan status
      if (cashflow.status == 'income') {
        if (incomeMap.containsKey(extractMonth(date))) {
          // Jika tanggal sudah ada, menambahkan nominal ke nilai yang sudah ada
          incomeMap[extractMonth(date)] =
              (incomeMap[extractMonth(date)] ?? 0) + nominal;
        } else {
          // Jika tanggal belum ada, menambahkan sebagai kunci baru
          incomeMap[extractMonth(date)] = nominal;
        }
      } else if (cashflow.status == 'expense') {
        if (expenseMap.containsKey(extractMonth(date))) {
          // Jika tanggal sudah ada, menambahkan nominal ke nilai yang sudah ada
          expenseMap[extractMonth(date)] =
              (expenseMap[extractMonth(date)] ?? 0) + nominal;
        } else {
          // Jika tanggal belum ada, menambakan sebagai kunci baru
          expenseMap[extractMonth(date)] = nominal;
        }
      }
    }

    // Konversi map menjadi daftar FlSpot
    incomeSpots.addAll(
        incomeMap.entries.map((entry) => FlSpot(entry.key, entry.value)));
    expenseSpots.addAll(
        expenseMap.entries.map((entry) => FlSpot(entry.key, entry.value)));

    print(incomeSpots);
    print(expenseSpots);
  }

  void loadCashflows() async {
    final cashflowList = await dbHelper.getCashflows();
    cashflows.assignAll(cashflowList);

    fillSpotsFromCashflows(cashflowList);
    update();
  }
}
