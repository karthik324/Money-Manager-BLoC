import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_bloc/db/models/db_model.dart';
import 'package:money_manager_bloc/logic/cubit/cubit_transactions/transaction_cubit.dart';
import 'package:money_manager_bloc/presentations/constants/constants.dart';
import 'package:money_manager_bloc/presentations/utils/utils.dart';
import 'package:money_manager_bloc/presentations/widgets/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? version;

  Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    version = context.read<TransactionCubit>().versionName(packageInfo.version);
  }

  Box<Categories> categories = Hive.box<Categories>(categoryBox);

  Box<Transactions> transactions = Hive.box<Transactions>(transactionBox);

  Box<ReminderDb> reminder = Hive.box<ReminderDb>(reminderBox);

  Box<UserName> userBox = Hive.box<UserName>(loginBox);

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenTheme,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.person,
              color: greenTheme,
            ),
            title: Text(userBox.values.first.userName),
          ),
          GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    'Warning!',
                    style: TextStyle(color: redTheme),
                  ),
                  content: const Text(
                    'Do you want to Reset all Data?',
                  ),
                  actions: [
                    TextButton(
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        categories.clear();
                        transactions.clear();
                        reminder.clear();
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text(
                        'NO',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                );
              },
            ),
            child: ListTile(
              leading: Icon(
                Icons.remove_circle_sharp,
                color: greenTheme,
              ),
              title: const Text('Reset Data'),
            ),
          ),
          GestureDetector(
            onTap: () => Utils.openEmail(
              toEmail: Uri.parse('karthikdileep003@gmail.com'),
              subject: 'Feedback about FIN Trac',
            ),
            child: ListTile(
              leading: Icon(
                Icons.feedback,
                color: greenTheme,
              ),
              title: const Text('Feedback'),
            ),
          ),
          GestureDetector(
            onTap: () => Share.share(
              'You should definitely check this app out. Such a simple and cool Money Manager App.\n https://play.google.com/store/apps/details?id=in.brototype.money_manager_app',
            ),
            child: ListTile(
              leading: Icon(
                Icons.share,
                color: greenTheme,
              ),
              title: const Text('Share App'),
            ),
          ),
          GestureDetector(
            onTap: () {
              StoreRedirect.redirect(
                androidAppId: 'in.brototype.money_manager_app',
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.star,
                color: greenTheme,
              ),
              title: const Text('Rate App'),
            ),
          ),
          GestureDetector(
            onTap: () {
              Utils.openLink(
                url: Uri.parse(
                  'https://www.freeprivacypolicy.com/live/cd781538-d5d8-46e4-bfe1-2cc49b2791c4',
                ),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.privacy_tip,
                color: greenTheme,
              ),
              title: const Text('Privacy Policy'),
            ),
          ),
          GestureDetector(
            onTap: () {
              showAboutDialog(
                context: context,
                applicationIcon: const FlutterLogo(),
                applicationName: 'FIN Trac',
                applicationVersion: version,
                applicationLegalese: '©2022 FIN Trac',
                children: [
                  const Text(
                    'Hola..! I\'m Kathik Dileep, and this is my first project.',
                  ),
                ],
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.info,
                color: greenTheme,
              ),
              title: const Text('About Me'),
            ),
          ),
          VerticalSpace(height: mediaQueryHeight * 0.33),
          BlocBuilder<TransactionCubit, TransactionState>(
            builder: (context, state) {
              return Text(
                'Version $version',
                style: const TextStyle(color: Colors.grey),
              );
            },
          )
        ],
      ),
    );
  }
}
