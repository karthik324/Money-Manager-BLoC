// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'reminder_cubit.dart';

abstract class ReminderState extends Equatable {
  const ReminderState();
}

class ReminderInitial extends ReminderState {
  @override
  List<Object?> get props => [];
}

class AllReminderState extends ReminderState {
  final List<ReminderDb> reminder;
  const AllReminderState({
    required this.reminder,
  });

  @override
  List<Object?> get props => [reminder];
}

class DateTimePick extends ReminderState {
  final DateTime dateTime;
  const DateTimePick({
    required this.dateTime,
  });

  @override
  List<Object> get props => [dateTime];
}
