import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager_bloc/logic/bloc/search_bloc.dart';

part 'icon_state.dart';

class IconCubit extends Cubit<IconState> {
  IconCubit()
      : super(
          const IconChange(
              myField: Text('All Transactions'), iconData: Icons.search),
        );

  IconData changeIcon(
      IconData iconData, String searchInput, BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    if (iconData == Icons.search) {
      emit(
        IconChange(
          iconData: Icons.clear,
          myField: SizedBox(
            width: mediaQueryWidth * 0.7,
            height: mediaQueryHeight * 0.07,
            child: TextField(
              onChanged: (value) {
                // searchInput = value;
                context.read<SearchBloc>().add(
                      EnterInputEvent(searchInput: value),
                    );
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Search here',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      emit(
        const IconChange(
          iconData: Icons.search,
          myField: Text('All Transactions'),
        ),
      );
      context.read<SearchBloc>().add(ClearInputEvent());
    }
    return iconData;
  }
}
