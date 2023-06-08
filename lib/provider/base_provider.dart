import 'package:flutter/material.dart';
import '../entities/base_dropdown_return.dart';
import '../entities/base_model_entity.dart';

abstract class BaseProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  List<BaseModelEntity> _getListValue = [];
  List<BaseModelEntity> get getListValue => _getListValue;

  Future<void> processInit({
    required BuildContext context,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
    // required void Function(Failure failure) onError,
  });

  Future<BaseDropdownReturn> processLoadDropdownData();

  Future<void> processAddData({
    required BuildContext context,
    required BaseModelEntity inputModel,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
    // required void Function(Failure failure) onError,
  });

  Future<void> initData(BuildContext context) async {
    _loading = true;
    notifyListeners();

    return processInit(
      context: context,
      onSuccess: (result) {
        _getListValue = result;
        _loading = false;

        notifyListeners();
      },
    );
  }

  Future<void> addData(BuildContext context, BaseModelEntity inputModel) {
    return processAddData(
      context: context,
      inputModel: inputModel,
      onSuccess: (result) {
        _getListValue = result;
        _loading = false;

        notifyListeners();
      },
    );
  }

  Future<BaseDropdownReturn> loadDropdown() async {
    _loading = true;
    notifyListeners();

    final getValueDropdown = await processLoadDropdownData();

    _loading = false;
    notifyListeners();

    return getValueDropdown;
  }
}
