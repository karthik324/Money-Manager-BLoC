// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class EnterInputEvent extends SearchEvent {
  final String searchInput;
  const EnterInputEvent({
    required this.searchInput,
  });
  @override
  List<Object?> get props => [];
}

class ClearInputEvent extends SearchEvent {
  @override
  List<Object?> get props => [];
}
