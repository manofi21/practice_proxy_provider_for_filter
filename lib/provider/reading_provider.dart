import 'package:flutter/material.dart';
import 'package:proxy_provider_for_filter/entities/base_dropdown_return.dart';
import 'package:proxy_provider_for_filter/entities/base_model_entity.dart';

import '../entities/dropdown_item.dart';
import '../entities/reading_model_entity.dart';
import '../model/reading_model_v1.dart';
import '../repo/reading_repo.dart';
import 'base_provider.dart';

class ReadingProvider extends BaseProvider {
  @override
  Future<void> processInit({
    required BuildContext context,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  }) async {
    final readhRepoImpl = ReadingRepoImpl();
    final listResult = await readhRepoImpl.getListReadingHistory();
    onSuccess(listResult);
  }

  @override
  Future<void> processAddData({
    required BuildContext context,
    required BaseModelEntity inputModel,
    required void Function(List<BaseModelEntity> listItems) onSuccess,
  }) async {
    final readhRepoImpl = ReadingRepoImpl();
    if (inputModel is ReadingModelEntity) {
      final readingInputModel = ReadingModelV1(
        name: inputModel.name,
        isFavorite: inputModel.isFavorite ? 1 : 0,
        idStatusRead: inputModel.statusRead.key,
        idTypeRead: inputModel.typeRead.key,
      );
      await readhRepoImpl.addReadingHistory(readingInputModel);
    }

    final listResult = await readhRepoImpl.getListReadingHistory();
    onSuccess(listResult);
  }

  @override
  Future<BaseDropdownReturn> processLoadDropdownData() async {
    final readingRepoImpl = ReadingRepoImpl();
    final listStatus = await readingRepoImpl.getListReadStatusModel();
    final listType = await readingRepoImpl.getListReadTypeModel();
    return BaseDropdownReturn(
      listStatus: listStatus
          .map((e) => DropdownItem(key: e.id, title: e.nameStatus))
          .toList(),
      listType: listType
          .map((e) => DropdownItem(key: e.id, title: e.nameType))
          .toList(),
    );
  }
  
  @override
  Future<void> processFilter({required BuildContext context, required void Function(List<BaseModelEntity> listItems) onSuccess}) {
    // TODO: implement processFilter
    throw UnimplementedError();
  }
  
  @override
  Future<void> processUpdateData({required BuildContext context, required BaseModelEntity inputModel, required void Function(List<BaseModelEntity> listItems) onSuccess}) {
    // TODO: implement processUpdateData
    throw UnimplementedError();
  }
}
