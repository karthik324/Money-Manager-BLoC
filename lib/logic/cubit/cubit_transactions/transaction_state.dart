// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'transaction_cubit.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();
}

class TransactionInitial extends TransactionState {
  @override
  List<Object?> get props => [];
}

class AllTransactionsState extends TransactionState {
  final List<Transactions> transactions;
  const AllTransactionsState({required this.transactions});

  @override
  List<Object?> get props => [transactions];
}

class TransactionsState2 extends TransactionState {
  @override
  List<Object?> get props => [];
}

class DateChanger extends TransactionState {
  final DateTime dateTime;
  const DateChanger({
    required this.dateTime,
  });

  @override
  List<Object?> get props => [dateTime];
}

class DatePicker extends TransactionState {
  final DateTime dateTime;
  const DatePicker({
    required this.dateTime,
  });

  @override
  List<Object?> get props => [dateTime];
}

class VersionName extends TransactionState {
  final String version;
  const VersionName({
    required this.version,
  });

  @override
  List<Object?> get props => [version];
}
