import 'package:get/get.dart';
import 'package:my_money/app/data/cashflow.dart';
import 'package:my_money/app/utils/database_helper.dart';

class DetailCashFlowController extends GetxController {
  //TODO: Implement DetailCashFlowController
  final dbHelper = DatabaseHelper.instance;
  RxList<CashFlow> cashflows = RxList<CashFlow>();

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

  void loadCashflows() async {
    final cashflowList = await dbHelper.getCashflows();
    cashflows.assignAll(cashflowList);
  }
}
