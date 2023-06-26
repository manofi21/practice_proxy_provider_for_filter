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

  Future<void> processFilter({
    required BuildContext context,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  });

  Future<void> processUpdateData({
    required BuildContext context,
    required BaseModelEntity inputModel,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
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

  Future<void> initFilterData(BuildContext context) async {
    _loading = true;
    notifyListeners();

    return processFilter(
      context: context,
      onSuccess: (result) {
        _getListValue = result;
        _loading = false;

        notifyListeners();
      },
    );
  }

  Future<void> addData(BuildContext context, BaseModelEntity inputModel) {
    _loading = true;
    notifyListeners();

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

  Future<void> updateData(
    BuildContext context,
    BaseModelEntity inputModel,
  ) async {
    _loading = true;
    notifyListeners();

    return processUpdateData(
      context: context,
      inputModel: inputModel,
      onSuccess: (result) {
        _getListValue = result;
        _loading = false;

        notifyListeners();
      },
    );
  }
}
