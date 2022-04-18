import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:los_pasar/app/data/rest_provider.dart';
import 'package:los_pasar/app/data/utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportController extends GetxController
    with StateMixin<List<Map<String, dynamic>>> {
  final List<Map<String, dynamic>> dayItems = [
    {'value': 10, 'label': '10 Hari Terkahir'},
    {'value': 30, 'label': '30 Hari Terkahir'},
  ];

  final TextEditingController startC = new TextEditingController();
  final TextEditingController endC = new TextEditingController();

  var transaksi = 0.obs;
  var terima = 0.obs;
  var berikan = 0.obs;
  var utangSaya = 0.obs;
  var utangPelanggan = 0.obs;
  var sisa = 0.obs;

  getAllDataBetweenDate(DateTime start, DateTime end) {
    if (start.isAfter(end)) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Tanggal awal harus lebih awal dari tanggal akhir",
        textCancel: 'OK',
      );
      return;
    }

    RestProvider()
        .getAllDataBetweenDate('transaction', 'createdDate', start, end)
        .then((value) {
      var data =
          value.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

      transaksi.value = 0;
      terima.value = 0;
      berikan.value = 0;
      utangSaya.value = 0;
      utangPelanggan.value = 0;

      List<Map<String, dynamic>> listDetail = [];
      data.forEach((x) {
        x['detail'].forEach((y) {
          // timestamp to datetime
          y['createdDate'] = DateTime.fromMillisecondsSinceEpoch(
              y['createdDate'].millisecondsSinceEpoch);

          if ((y['createdDate'] as DateTime).isAfter(start) &&
              (y['createdDate'] as DateTime).isBefore(end)) {
            y['createdDate'] =
                Timestamp.fromDate((y['createdDate'] as DateTime));

            var map = {
              'name': x['name'],
              'amount': y['amount'],
              'createdDate': y['createdDate'],
              'type': y['type'],
            };

            listDetail.add(map);

            transaksi += 1;
            if (y['type'] == 'BAYAR') {
              terima += 1;
              utangSaya += y['amount'];
            } else {
              berikan += 1;
              utangPelanggan += y['amount'];
            }
            sisa.value = utangSaya.value - utangPelanggan.value;
            if (sisa.value < 0) {
              sisa.value = 0;
            }
          }
        });
      });
      update();
      change(listDetail, status: RxStatus.success());
    });
  }

  changeDropdown(int day) {
    endC.text = DateTime.now().toIso8601String();
    // datetime add day
    startC.text =
        DateTime.now().subtract(Duration(days: day)).toIso8601String();

    getAllDataBetweenDate(
        DateTime.parse(startC.text), DateTime.parse(endC.text));
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
                      x['name'],
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
    final file = File('${dir.path}/report.pdf');
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
}
