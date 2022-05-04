import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_manager_bloc/db/models/db_model.dart';
import 'package:money_manager_bloc/logic/cubit/cubit_categories/categories_cubit.dart';
import 'package:money_manager_bloc/logic/cubit/cubit_transactions/transaction_cubit.dart';
import 'package:money_manager_bloc/presentations/constants/constants.dart';
import 'package:money_manager_bloc/presentations/screens/screens.dart';
import 'package:money_manager_bloc/presentations/widgets/widgets.dart';

class ExpenseScreen extends StatefulWidget {
  final int? currentKey;
  const ExpenseScreen({Key? key, this.currentKey}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController amountController = TextEditingController();
  late Box<Categories> categories;
  late Box<Transactions> transactions;
  bool redCol = true;
  DateTime? date;
  Categories? selectedCategory;

  @override
  void initState() {
    categories = Hive.box<Categories>(categoryBox);
    transactions = Hive.box<Transactions>(transactionBox);
    amountController.text = widget.currentKey != null
        ? transactions.get(widget.currentKey)!.amount.toString()
        : "";
    date = widget.currentKey != null
        ? transactions.get(widget.currentKey)!.dateTime
        : date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: widget.currentKey == null
            ? const Text('Expense')
            : const Text('Update Expense'),
        centerTitle: true,
        backgroundColor: redTheme,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomSubHead(text: 'Amount'),
            Form(
              key: formKey,
              child: CustomTextFieldExpense(
                controller: amountController,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: mediaQueryHeight * 0.02),
              child: const CustomSubHead(text: 'Category'),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: mediaQueryWidth * 0.045, right: mediaQueryWidth * 0.5),
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  return DropdownButton<dynamic>(
                    onChanged: (value) {
                      selectedCategory =
                          context.read<CategoriesCubit>().dropDownValue(value);
                    },
                    isExpanded: true,
                    value: selectedCategory,
                    borderRadius: BorderRadius.circular(10),
                    iconEnabledColor: redTheme,
                    hint: const Text('Select Category'),
                    items: type(categories.values.toList())[1].map(
                      (Categories e) {
                        return DropdownMenuItem(
                          child: Text(e.category),
                          value: e,
                          onTap: () {
                            selectedCategory = e;
                          },
                        );
                      },
                    ).toList(),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: mediaQueryWidth * 0.02),
              child: Row(
                children: [
                  TextButton(
                    style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all(redTheme)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExpenseCategory()));
                    },
                    child: Text(
                      'Add Category',
                      style: TextStyle(color: redTheme),
                    ),
                  ),
                ],
              ),
            ),
            const CustomSubHead(text: 'Date'),
            SizedBox(
              height: mediaQueryHeight * 0.04,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                        builder: (context, child) => Theme(
                          child: child!,
                          data: ThemeData().copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: Colors.red,
                            ),
                          ),
                        ),
                      );
                      date = context
                          .read<CategoriesCubit>()
                          .dateTimeTake(newDate!);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: mediaQueryWidth * 0.043),
                      child: Row(
                        children: [
                          BlocBuilder<CategoriesCubit, CategoriesState>(
                            builder: (context, state) {
                              return Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(date ?? DateTime.now()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  HorizontalSpace(width: mediaQueryWidth * 0.552),
                  IconButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                        builder: (context, child) => Theme(
                          child: child!,
                          data: ThemeData().copyWith(
                              colorScheme: const ColorScheme.light(
                            primary: Colors.red,
                          )),
                        ),
                      );
                      date = context
                          .read<CategoriesCubit>()
                          .dateTimeTake(newDate!);
                    },
                    icon: Icon(
                      Icons.date_range,
                      color: redCol ? redTheme : greenTheme,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: mediaQueryHeight * 0.03,
              thickness: 1,
              indent: mediaQueryWidth * 0.047,
              endIndent: mediaQueryWidth * 0.047,
              color: Colors.black,
            ),
            VerticalSpace(height: mediaQueryHeight * 0.37),
            CustomElevatedButtonExpense(
              text:
                  widget.currentKey == null ? 'Add Expense' : 'Update Expense',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final parseAmont = double.tryParse(amountController.text);
                  if (selectedCategory == null) {
                    return;
                  }
                  date ??= DateTime.now();
                  Transactions newTransaction = Transactions(
                    amount: parseAmont!,
                    categoryType: selectedCategory!,
                    dateTime: date!,
                  );
                  widget.currentKey == null
                      ? context
                          .read<TransactionCubit>()
                          .addTransactionsListUpdated(
                            transactions,
                            newTransaction,
                          )
                      : context
                          .read<TransactionCubit>()
                          .editTransactionsListUpdated(
                            transactions,
                            newTransaction,
                            widget.currentKey!,
                          );
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
