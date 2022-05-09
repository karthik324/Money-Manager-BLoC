import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_bloc/db/functions/db_functions.dart';
import 'package:money_manager_bloc/db/models/db_model.dart';
import 'package:money_manager_bloc/logic/bloc/bloc_search/search_bloc.dart';
import 'package:money_manager_bloc/logic/cubit/cubit_categories/categories_cubit.dart';
import 'package:money_manager_bloc/logic/cubit/cubit_reminder/reminder_cubit.dart';
import 'package:money_manager_bloc/logic/cubit/cubit_transactions/transaction_cubit.dart';
import 'package:money_manager_bloc/logic/cubit/search_icon_cubit/icon_cubit.dart';
import 'package:money_manager_bloc/presentations/screens/screens.dart';

import 'presentations/api/local_notifications.dart';
import 'presentations/constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(CategoriesAdapter());
  Hive.registerAdapter(TransactionsAdapter());
  Hive.registerAdapter(ReminderDbAdapter());
  Hive.registerAdapter(UserNameAdapter());
  await Hive.openBox<Categories>(categoryBox);
  await Hive.openBox<Transactions>(transactionBox);
  await Hive.openBox<ReminderDb>(reminderBox);
  await Hive.openBox<UserName>(loginBox);
  AwesomeNotifications().initialize('resource://drawable/ic_launcher', [
    NotificationChannel(
      channelKey: 'scheduled_channel',
      channelName: 'Sheduled Notifications',
      channelDescription: 'Fin Trac',
      importance: NotificationImportance.Max,
      channelShowBadge: true,
      defaultColor: Colors.grey,
    ),
  ]);
  reminderNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoriesCubit(
            DbFunctions.getCatsList(),
          ),
        ),
        BlocProvider(
          create: (context) => ReminderCubit(DbFunctions.getRemList()),
        ),
        BlocProvider(
          create: (context) => TransactionCubit(DbFunctions.getTraList()),
        ),
        BlocProvider(
          create: (context) => IconCubit(),
        ),
        BlocProvider(
          create: (context) => SearchBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'FIN Trac',
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        theme: ThemeData(
          fontFamily: 'Prompt',
          primarySwatch: Colors.green,
        ),
      ),
    );
  }
}
