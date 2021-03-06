import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_bloc/db/models/db_model.dart';
import 'package:money_manager_bloc/logic/bloc/bloc_search/search_bloc.dart';
import 'package:money_manager_bloc/logic/cubit/cubit_transactions/transaction_cubit.dart';
import 'package:money_manager_bloc/logic/cubit/search_icon_cubit/icon_cubit.dart';
import 'package:money_manager_bloc/presentations/constants/constants.dart';
import 'package:money_manager_bloc/presentations/screens/screens.dart';
import 'package:money_manager_bloc/presentations/widgets/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

List<Transactions> yearType(List<Transactions> list, DateTime year) {
  List<Transactions> transac = [];
  for (int i = 0; i < list.length; i++) {
    if (list[i].dateTime.year == year.year) {
      transac.add(list[i]);
    }
  }
  return transac;
}

class YearlyScreen extends StatelessWidget {
  YearlyScreen({Key? key}) : super(key: key);

  Box<Categories> categories = Hive.box<Categories>(categoryBox);
  Box<Transactions> transactions = Hive.box<Transactions>(transactionBox);
  IconData? myIcon;
  Widget? myFields;
  final String searchInput = "";
  double? totalIncome;
  double? totalExpense;
  DateTime thisYear = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          List<Transactions> boxList =
              yearType(transactions.values.toList(), thisYear);
          double incomeAmount = amountType(boxList)[0];
          double expenseAmount = amountType(boxList)[1];
          return Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      thisYear = context
                          .read<TransactionCubit>()
                          .dateYearDecrement(thisYear);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 14,
                    ),
                  ),
                  Text(DateFormat('yyyy').format(thisYear)),
                  IconButton(
                    onPressed: () {
                      thisYear = context
                          .read<TransactionCubit>()
                          .dateYearIncrement(thisYear);
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                    ),
                  )
                ],
              ),
              boxList.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: mediaQueryHeight * 0.335),
                      child: const Text('No Transactions'),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: mediaQueryHeight * 0.35,
                          width: double.maxFinite,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: mediaQueryHeight * 0.03),
                            child: SfCircularChart(
                              tooltipBehavior: TooltipBehavior(
                                enable: true,
                                textStyle: const TextStyle(
                                  fontFamily: 'Prompt',
                                ),
                              ),
                              palette: [redTheme, blueTheme],
                              legend: Legend(
                                isVisible: true,
                                position: LegendPosition.bottom,
                                textStyle: const TextStyle(
                                  fontFamily: 'Prompt',
                                  fontSize: 13,
                                ),
                              ),
                              series: <CircularSeries>[
                                DoughnutSeries<Data, String>(
                                  radius: '90',
                                  innerRadius: '60',
                                  dataSource: getChartData(
                                    expenseAmount,
                                    ((incomeAmount) - (expenseAmount)),
                                  ),
                                  xValueMapper: (Data data, _) => data.datas,
                                  yValueMapper: (Data data, _) => data.values,
                                  dataLabelSettings: const DataLabelSettings(
                                    labelPosition:
                                        ChartDataLabelPosition.outside,
                                    isVisible: true,
                                    textStyle: TextStyle(
                                      fontFamily: 'Prompt',
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        VerticalSpace(height: mediaQueryHeight * 0.04),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Income',
                                      style: TextStyle(
                                          fontWeight: bold,
                                          fontSize: customFontSizeTitle)),
                                  const VerticalDivider(
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                  Text('Expenses',
                                      style: TextStyle(
                                          fontWeight: bold,
                                          fontSize: customFontSizeTitle)),
                                  const VerticalDivider(
                                      thickness: 1, color: Colors.black),
                                  Text(
                                    'Balance',
                                    style: TextStyle(
                                        fontWeight: bold,
                                        fontSize: customFontSizeTitle),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '???$incomeAmount',
                                  style: TextStyle(
                                      fontWeight: bold,
                                      fontSize: customFontSizeTitle,
                                      color: greenTheme),
                                ),
                                const VerticalDivider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                Text(
                                  '???$expenseAmount',
                                  style: TextStyle(
                                      fontWeight: bold,
                                      fontSize: customFontSizeTitle,
                                      color: redTheme),
                                ),
                                const VerticalDivider(
                                    thickness: 1, color: Colors.black),
                                Text(
                                  '???${((incomeAmount) - (expenseAmount))}',
                                  style: TextStyle(
                                      fontWeight: bold,
                                      fontSize: customFontSizeTitle,
                                      color: blueTheme),
                                ),
                              ],
                            ),
                            VerticalSpace(height: mediaQueryHeight * 0.02),
                            Container(
                              width: double.maxFinite,
                              height: mediaQueryHeight * 0.07,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: BlocBuilder<IconCubit, IconState>(
                                builder: (context, state) {
                                  myIcon = state.props[0] as IconData;
                                  myFields = state.props[1] as Widget;
                                  return Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: mediaQueryWidth * 0.055),
                                        child: myFields,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: mediaQueryWidth * 0.03),
                                        child: IconButton(
                                          onPressed: () {
                                            myIcon = context
                                                .read<IconCubit>()
                                                .changeIcon(
                                                  myIcon!,
                                                  searchInput,
                                                  context,
                                                );
                                          },
                                          icon: Icon(myIcon),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                            BlocBuilder<SearchBloc, SearchState>(
                              builder: (context, state) {
                                final traList =
                                    state.props[0] as List<Transactions>;
                                return traList.isEmpty
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            top: mediaQueryHeight * 0.165),
                                        child: const Text(
                                            'No Transactions found :('),
                                      )
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onLongPress: () => showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    'Warning!',
                                                    style: TextStyle(
                                                        color: redTheme),
                                                  ),
                                                  content: const Text(
                                                      'Do you want to delete?'),
                                                  actions: [
                                                    TextButton(
                                                        child: const Text(
                                                          'Yes',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                  TransactionCubit>()
                                                              .deleteTransactionsListUpdated(
                                                                transactions,
                                                                traList[index]
                                                                    .key,
                                                              );
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                    TextButton(
                                                      child: const Text(
                                                        'NO',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    )
                                                  ],
                                                );
                                              },
                                            ),
                                            onTap:
                                                traList[index].categoryType.type
                                                    ? () => Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                IncomeScreen(
                                                              currentKey:
                                                                  traList[index]
                                                                      .key,
                                                            ),
                                                          ),
                                                        )
                                                    : () => Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ExpenseScreen(
                                                              currentKey:
                                                                  traList[index]
                                                                      .key,
                                                            ),
                                                          ),
                                                        ),
                                            child: CustomTransactionCard(
                                              color: traList[index]
                                                      .categoryType
                                                      .type
                                                  ? greenTheme
                                                  : redTheme,
                                              amount:
                                                  '???${traList[index].amount}',
                                              category: traList[index]
                                                  .categoryType
                                                  .category,
                                              date: DateFormat('EEEE, d MMM')
                                                  .format(
                                                      traList[index].dateTime),
                                            ),
                                          );
                                        },
                                        itemCount: traList.length,
                                        separatorBuilder: (context, index) {
                                          return const SizedBox.shrink();
                                        },
                                      );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
            ],
          );
        },
      ),
    );
  }

  List<Data> getChartData(double totalIncome, double totalExpense) {
    final List<Data> chartData = [
      Data('Expense', totalIncome),
      Data('Balance', totalExpense)
    ];
    return chartData;
  }
}
