import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:los_pasar/app/data/constant.dart';
import 'package:los_pasar/app/data/utils.dart';
import 'package:los_pasar/app/modules/print/controllers/print_controller.dart';
import '../../../routes/app_pages.dart';

class PrintView extends StatefulWidget {
  @override
  State<PrintView> createState() => _PrintViewState();
}

class _PrintViewState extends State<PrintView> {
  final PrintController controller = Get.find();

  // PrinterBluetoothManager _printerBluetoothManager = PrinterBluetoothManager();
  // List<PrinterBluetooth> _device = [];
  String? _deviceMessage;
  // BluetoothManager bluetoothManager = BluetoothManager.instance;
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  @override
  void initState() {
    initPrinter();
    // if (Platform.isAndroid) {
    //   bluetoothManager.state.listen((event) {
    //     print('state = $event');
    //     if (!mounted) return;
    //     if (event == 12) {
    //       print('on');
    //       initPrinter();
    //     } else if (event == 10) {
    //       print('off');
    //       setState(() {
    //         _deviceMessage == 'Bluetooth not connected';
    //       });
    //     } else {
    //       initPrinter();
    //     }
    //   });
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Pilih Printer'),
          ],
        ),
      ),
      body: Text("data"),
      // _device.isEmpty
      //     ? Center(
      //         child: Text(_deviceMessage ?? ''),
      //       )
      //     : ListView.builder(
      //         itemCount: _device.length,
      //         itemBuilder: (c, i) {
      //           return ListTile(
      //             leading: Icon(Icons.print),
      //             title: Text(_device[i].name.toString()),
      //             subtitle: Text(_device[i].address.toString()),
      //             onTap: () {
      //               _startPrint(_device[i]);
      //             },
      //           );
      //         },
      //       ),
    );
  }

  void initPrinter() {
    bluetoothPrint.startScan(timeout: Duration(seconds: 2));
    bluetoothPrint.scanResults.listen((event) {
      print(event);
    });
    // _printerBluetoothManager.startScan(Duration(seconds: 2));
    // _printerBluetoothManager.scanResults.listen((val) {
    //   if (!mounted) return;
    //   print(val);
    // setState(() => _device = val);
    // if (_device.isEmpty) setState(() => _deviceMessage = 'No Devices');
    // });
  }

  // Future<void> _startPrint(PrinterBluetooth printer) async {
  //   _printerBluetoothManager.selectPrinter(printer);
  //   final result =
  //       await _printerBluetoothManager.printTicket(await testTicket());
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       content: Text(result.msg),
  //     ),
  //   );
  // }

  // Future<List<int>> testTicket() async {
  //   final List<int> bytes = [];
  //   final profle = await CapabilityProfile.load();
  //   final Generator ticket = Generator(PaperSize.mm80, profle);

  //   ticket.text('WARUNG OKE',
  //       styles: PosStyles(
  //           align: PosAlign.center,
  //           height: PosTextSize.size2,
  //           width: PosTextSize.size2,
  //           bold: true),
  //       linesAfter: 1);
  //   ticket.feed(2);

  //   ticket.text(controller.argDocDetail['createdDate'],
  //       styles: PosStyles(align: PosAlign.center));
  //   ticket.feed(1);

  //   ticket.row([
  //     PosColumn(text: 'Nama', width: 6),
  //     PosColumn(text: 'Nomor HP', width: 6)
  //   ]);
  //   ticket.row([
  //     PosColumn(text: controller.argDoc['name'], width: 6),
  //     PosColumn(text: controller.argDoc['phone'], width: 6),
  //   ]);
  //   ticket.feed(1);

  //   ticket.text(
  //     controller.argDocDetail['type'] == 'BAYAR' ? 'Terima' : 'Memberikan',
  //   );
  //   ticket.text(controller.argDocDetail['amount'],
  //       styles: PosStyles(
  //           height: PosTextSize.size2, width: PosTextSize.size2, bold: true));
  //   ticket.feed(1);

  //   ticket.text('Catatan');
  //   ticket.text(controller.argDocDetail['note']);
  //   ticket.feed(1);

  //   ticket.row([
  //     PosColumn(text: 'Total utang', width: 6),
  //     PosColumn(text: 'Total sudah dibayar', width: 6),
  //     PosColumn(text: 'Kurang Bayar', width: 6),
  //   ]);
  //   ticket.row([
  //     PosColumn(text: controller.argDocDetail['amount'], width: 6),
  //     PosColumn(text: controller.paidAmount.value.toString(), width: 6),
  //     PosColumn(
  //         text: controller.insufficientPayment.value.toString(), width: 6),
  //   ]);

  //   return bytes;
  // }

  // @override
  // void dispose() {
  //   _printerBluetoothManager.stopScan();
  //   super.dispose();
  // }
}
