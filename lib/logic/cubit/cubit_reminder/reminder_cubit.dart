// import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_bloc/db/functions/db_functions.dart';
import 'package:money_manager_bloc/db/models/db_model.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  List<ReminderDb> reminders;
  ReminderCubit(this.reminders) : super(ReminderInitial()) {
    emit(AllReminderState(reminder: reminders));
  }

  DateTime datePicker(DateTime date) {
    emit(DateTimePick(dateTime: date));
    return date;
  }

  void reminderListUpdated(List<ReminderDb> reminders) {
    emit(AllReminderState(reminder: reminders));
  }

  void addReminderListUpdated(Box<ReminderDb> box, ReminderDb reminder) {
    DbFunctions.addReminder(reminder);
    emit(AllReminderState(reminder: box.values.toList()));
  }

  void editReminderListUpdated(
      Box<ReminderDb> box, ReminderDb reminder, int key) {
    DbFunctions.updateReminder(key, reminder);
    emit(AllReminderState(reminder: box.values.toList()));
  }

  void deleteReminderListUpdated(Box<ReminderDb> box, int key) {
    DbFunctions.deleteReminder(key);
    emit(AllReminderState(reminder: box.values.toList()));
  }
}
