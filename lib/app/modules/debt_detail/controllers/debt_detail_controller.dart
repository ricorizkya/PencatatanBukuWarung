import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:los_pasar/app/data/rest_provider.dart';
import 'package:los_pasar/app/data/utils.dart';
import 'package:los_pasar/app/modules/home/controllers/home_controller.dart';
import 'package:los_pasar/app/routes/app_pages.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DebtDetailController extends GetxController
    with StateMixin<Map<String, dynamic>> {
  final HomeController homeController = Get.find();

  final transaction = FirebaseFirestore.instance.collection('transaction');
  var argId = Get.arguments['id'];
  var doc = {}.obs;
  var listData = [].obs;
  late DocumentSnapshot<Object?> documentSnapshot;

  getTransactionById(String id) async {
    RestProvider().getDataById('transaction', id).then((value) {
      documentSnapshot = value;
      print(documentSnapshot);
      var data = value.data() as Map<String, dynamic>;
      listData.value =
          data['detail'].map((x) => x as Map<String, dynamic>).toList();
      doc.value = data;
      update();
      change(data, status: RxStatus.success());
    });
  }

  int calculateDataAmount(var docDetail) {
    var amount = 0;
    docDetail.forEach((x) {
      if (x['type'] == 'PINJAM') amount += x['amount'] as int;
    });
    return amount;
  }

  void payOff(int amount) async {
    var newDetail = {
      "id": Uuid().v1(),
      "amount": amount,
      "note": 'LUNASKAN',
      "type": 'BAYAR',
      "createdDate": DateTime.now(),
    };

    Get.defaultDialog(
        title: "Konfirmasi",
        middleText: "Apakah anda yakin melunaskan sisa pembayaran " +
            Utils().currencyFormatter.format(amount).toString() +
            "?",
        textCancel: 'Batal',
        onCancel: () {},
        textConfirm: "Ya",
        onConfirm: () async {
          await RestProvider().editData('transaction', argId, {
            "status": "LUNAS",
            "detail": FieldValue.arrayUnion([newDetail]),
          });
          Get.back();
          getTransactionById(argId);
        });
  }

  deleteData(String id) async {
    Get.defaultDialog(
        title: "Konfirmasi",
        middleText: "Yakin hapus data?",
        textCancel: "BATAL",
        textConfirm: "OKE",
        onConfirm: () async {
          await RestProvider().deleteData('transaction', id);
          Get.offAllNamed(Routes.HOME);
        });
  }

  createPDFFromData(context, var data) async {
    final pw.Document pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        orientation: pw.PageOrientation.natural,
        build: (context) => pw.Column(
          children: [
            pw.Container(
              color: PdfColors.white,
              child: pw.Table(
                border: pw.TableBorder.all(color: PdfColors.black),
                children: [
                  tableRow(["Nama", "Tanggal", "Jenis", "Jumlah"],
                      headerTextStyle()),
                  ...data.map((x) {
                    return tableRow([
                      doc['name'],
                      Utils().timestampToDateFormat(x['createdDate']),
                      x['type'],
                      Utils().currencyFormatter.format(x['amount']).toString()
                    ], dataTextStyle());
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/reportpersonal.pdf');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  tableRow(List<String> attributes, pw.TextStyle textStyle) {
    return pw.TableRow(
      children: attributes
          .map(
            (e) => pw.Text(
              " " + e,
              style: textStyle,
            ),
          )
          .toList(),
    );
  }

  pw.TextStyle headerTextStyle() {
    return pw.TextStyle(
      color: PdfColors.blueGrey500,
      fontSize: 20,
      fontWeight: pw.FontWeight.bold,
    );
  }

  pw.TextStyle dataTextStyle() {
    return pw.TextStyle(
      color: PdfColors.blueGrey900,
      fontSize: 20,
    );
  }

  @override
  void onInit() async {
    getTransactionById(argId);
    // await this.getListData();
    super.onInit();
  }
}
