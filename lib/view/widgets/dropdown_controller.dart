import 'package:flutter/widgets.dart';

class DropdownController extends TextEditingController {
  String _key = '';

  String get key => _key;

  void setValue(MapEntry<String, dynamic> valuePair) {
    _key = valuePair.key;
    text = valuePair.value.toString();
  }
}
