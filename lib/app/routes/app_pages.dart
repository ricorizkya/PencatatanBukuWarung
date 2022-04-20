import 'package:get/get.dart';

import '../modules/debt_detail/bindings/debt_detail_binding.dart';
import '../modules/debt_detail/views/debt_detail_view.dart';
import '../modules/due_date/bindings/due_date_binding.dart';
import '../modules/due_date/views/due_date_view.dart';
import '../modules/get_started/bindings/get_started_binding.dart';
import '../modules/get_started/views/get_started_view.dart';
import '../modules/give/bindings/give_binding.dart';
import '../modules/give/views/give_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/record_debt/bindings/record_debt_binding.dart';
import '../modules/record_debt/views/record_debt_view.dart';
import '../modules/report/bindings/report_binding.dart';
import '../modules/report/views/report_view.dart';
import '../modules/resource/bindings/resource_binding.dart';
import '../modules/resource/views/resource_view.dart';
import '../modules/transaction_detail/bindings/transaction_detail_binding.dart';
import '../modules/transaction_detail/views/transaction_detail_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.RESOURCE,
      page: () => ResourceView(),
      binding: ResourceBinding(),
    ),
    GetPage(
      name: _Paths.GET_STARTED,
      page: () => GetStartedView(),
      binding: GetStartedBinding(),
    ),
    GetPage(
      name: _Paths.RECORD_DEBT,
      page: () => RecordDebtView(),
      binding: RecordDebtBinding(),
    ),
    GetPage(
      name: _Paths.DEBT_DETAIL,
      page: () => DebtDetailView(),
      binding: DebtDetailBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_DETAIL,
      page: () => TransactionDetailView(),
      binding: TransactionDetailBinding(),
    ),
    GetPage(
      name: _Paths.GIVE,
      page: () => GiveView(),
      binding: GiveBinding(),
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.DUE_DATE,
      page: () => DueDateView(),
      binding: DueDateBinding(),
    ),
  ];
}
