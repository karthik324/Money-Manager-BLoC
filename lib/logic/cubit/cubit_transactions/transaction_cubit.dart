import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_bloc/db/functions/db_functions.dart';
import 'package:money_manager_bloc/db/models/db_model.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final List<Transactions> transactions;
  TransactionCubit(this.transactions) : super(TransactionInitial()) {
    emit(AllTransactionsState(transactions: transactions));
  }

  void transactionsUpdated(List<Transactions> trans) {
    emit(AllTransactionsState(transactions: trans));
  }

  void addTransactionsListUpdated(Box<Transactions> box, Transactions trans) {
    DbFunctions.addTransaction(trans);
    emit(AllTransactionsState(transactions: box.values.toList()));
    emit(TransactionsState2());
  }

  void editTransactionsListUpdated(
      Box<Transactions> box, Transactions trans, int key) {
    DbFunctions.updateTransaction(key, trans);
    emit(AllTransactionsState(transactions: box.values.toList()));
  }

  void deleteTransactionsListUpdated(Box<Transactions> box, int key) {
    DbFunctions.deleteTransaction(key);
    emit(AllTransactionsState(transactions: box.values.toList()));
  }

  DateTime dateChangeDecrement(DateTime date) {
    DateTime newDate;
    newDate = DateTime(date.year, date.month - 1);
    emit(DateChanger(
      dateTime: newDate,
    ));
    return newDate;
  }

  DateTime dateChangeIncrement(DateTime date) {
    DateTime newDate;
    newDate = DateTime(date.year, date.month + 1);
    emit(DateChanger(
      dateTime: newDate,
    ));
    return newDate;
  }

  DateTime dateYearDecrement(DateTime date) {
    DateTime newDate;
    newDate = DateTime(date.year - 1);
    emit(DateChanger(dateTime: newDate));
    return newDate;
  }

  DateTime dateYearIncrement(DateTime date) {
    DateTime newDate;
    newDate = DateTime(date.year + 1);
    emit(DateChanger(dateTime: newDate));
    return newDate;
  }

  DateTime dateTimeTake(DateTime date) {
    emit(DatePicker(dateTime: date));
    return date;
  }

  void versionName(String version) {
    emit(VersionName(version: version));
  }
}
