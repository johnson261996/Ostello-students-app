import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/institute_provider.dart';
import '../../../../../utils/colours.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({Key? key}) : super(key: key);

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  @override
  Widget build(BuildContext context) {
    InstituteProvider instituteProvider = context.read<InstituteProvider>();

    return Scaffold(
      backgroundColor: kPureWhite,
      body: SafeArea(
        child: MobileScanner(
          controller: MobileScannerController(
            torchEnabled: false,
            facing: CameraFacing.back,
          ),
          onDetect: (barcode) {
            if (barcode.barcodes[0].rawValue != null) {
              final String code = barcode.barcodes[0].rawValue!;

              instituteProvider.getInstitutes(code).then((value) {
                Navigator.of(context).pop();
              });
            }
          },
        ),
      ),
    );
  }
}
