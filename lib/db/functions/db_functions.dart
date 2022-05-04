import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_bloc/db/models/db_model.dart';
import 'package:money_manager_bloc/presentations/constants/constants.dart';

class DbFunctions {
  static Box<Categories> getCatBox() {
    final box = Hive.box<Categories>(categoryBox);
    return box;
  }

  static List<Categories> getCatsList() {
    final List<Categories> catsList =
        Hive.box<Categories>(categoryBox).values.toList();
    return catsList;
  }

  static void addCategory(Categories category) {
    Hive.box<Categories>(categoryBox).add(category);
  }

  static Categories getCategory(int key) {
    Categories category = Hive.box<Categories>(categoryBox).get(key)!;
    return category;
  }

  static int updateCategory(int key, Categories category) {
    Hive.box<Categories>(categoryBox).put(key, category);
    return key;
  }

  static int deleteCategory(int key) {
    Hive.box<Categories>(categoryBox).delete(key);
    return key;
  }

  //************************************************************/

  static Box<Transactions> getTraBox() {
    final box = Hive.box<Transactions>(transactionBox);
    return box;
  }

  static List<Transactions> getTraList() {
    final List<Transactions> traList =
        Hive.box<Transactions>(transactionBox).values.toList();
    return traList;
  }

  static void addTransaction(Transactions transactions) {
    Hive.box<Transactions>(transactionBox).add(transactions);
  }

  static Transactions getTransaction(int key) {
    Transactions transactions =
        Hive.box<Transactions>(transactionBox).get(key)!;
    return transactions;
  }

  static int updateTransaction(int key, Transactions transactions) {
    Hive.box<Transactions>(transactionBox).put(key, transactions);
    return key;
  }

  static int deleteTransaction(int key) {
    Hive.box<Transactions>(transactionBox).delete(key);
    return key;
  }

  //************************************************************/

  static Box<ReminderDb> getRemBox() {
    final box = Hive.box<ReminderDb>(reminderBox);
    return box;
  }

  static List<ReminderDb> getRemList() {
    final List<ReminderDb> remList =
        Hive.box<ReminderDb>(reminderBox).values.toList();
    return remList;
  }

  static void addReminder(ReminderDb reminder) {
    Hive.box<ReminderDb>(reminderBox).add(reminder);
  }

  static ReminderDb getReminder(int key) {
    ReminderDb reminder = Hive.box<ReminderDb>(reminderBox).get(key)!;
    return reminder;
  }

  static int updateReminder(int key, ReminderDb reminder) {
    Hive.box<ReminderDb>(reminderBox).put(key, reminder);
    return key;
  }

  static int deleteReminder(int key) {
    Hive.box<ReminderDb>(reminderBox).delete(key);
    return key;
  }
}
