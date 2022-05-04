import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_bloc/db/functions/db_functions.dart';
import 'package:money_manager_bloc/db/models/db_model.dart';
import 'package:money_manager_bloc/presentations/constants/constants.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc()
      : super(SearchResultState(transactions: DbFunctions.getTraList())) {
    on<SearchEvent>(
      (event, emit) {
        if (event is EnterInputEvent) {
          final traList = Hive.box<Transactions>(transactionBox)
              .values
              .toList()
              .where(
                (element) =>
                    element.categoryType.category.toLowerCase().contains(
                          event.searchInput.toLowerCase(),
                        ),
              )
              .toList();
          traList.sort(
            (first, second) => second.dateTime.compareTo(first.dateTime),
          );
          emit(SearchResultState(transactions: traList));
        }
        if (event is ClearInputEvent) {
          emit(
            SearchResultState(
              transactions: DbFunctions.getTraList(),
            ),
          );
        }
      },
    );
  }
}
