import 'package:flutter/material.dart';
import '../entities/dropdown_item.dart';

class FilterProvider extends ChangeNotifier {
  bool? _favorite;
  DateTime? _startDate, _endDate;
  DropdownItem? _status, _type;

  bool? get favorite => _favorite;
  set favorite(bool? setValue) {
    _favorite = setValue;
    notifyListeners();
  }

  DateTime? get startDate => _startDate;
  set startDate(DateTime? setValue) {
    _startDate = setValue;
    notifyListeners();
  }

  DateTime? get endDate => _endDate;
  set endDate(DateTime? setValue) {
    _endDate = setValue;
    notifyListeners();
  }

  DropdownItem? get status => _status;
  set status(DropdownItem? setValue) {
    _status = setValue;
    notifyListeners();
  }

  DropdownItem? get type => _type;
  set type(DropdownItem? setValue) {
    _type = setValue;
    notifyListeners();
  }

  void onReset() {
    _favorite = null;
    _startDate = null;
    _endDate = null;
    _status = null;
    _type = null;
    notifyListeners();
  }

  void onUpdate() {}
}
