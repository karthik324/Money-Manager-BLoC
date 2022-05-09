// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchResultState extends SearchState {
  final List<Transactions> transactions;
  const SearchResultState({
    required this.transactions,
  });
  @override
  List<Object?> get props => [transactions];
}

class SearchResultState1 extends SearchState {
  final List<Transactions> transactions;
  const SearchResultState1({required this.transactions});

  @override
  List<Object?> get props => [transactions];
}
