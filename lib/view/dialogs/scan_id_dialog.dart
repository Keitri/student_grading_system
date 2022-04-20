import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanIdDialog extends StatelessWidget {
  const ScanIdDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      allowDuplicates: false,
      onDetect: (barcode, args) {
        final String code = barcode.rawValue!;
        debugPrint('Barcode found! $code');
        Navigator.of(context).pop(code);
      },
    );
  }
}
