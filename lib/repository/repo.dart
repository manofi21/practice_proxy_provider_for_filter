import '../model/filter_model/filter_history_model.dart';

abstract class Repo<T> {
  Future<void> addFromEntityToLocalSource(T addedItem);
  Future<void> updateFromEntityToLocalSource(T addedItem);
  Future<List<T>> filterFromListSource(FilterHistoryModel filterHistoryModel);
  Future<List<T>> getListFromListSource();
}