// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'icon_cubit.dart';

abstract class IconState extends Equatable {
  const IconState();
}

class IconChange extends IconState {
  final IconData iconData;
  final Widget myField;
  const IconChange({
    required this.iconData,
    required this.myField,
  });

  @override
  List<Object?> get props => [iconData, myField];
}
