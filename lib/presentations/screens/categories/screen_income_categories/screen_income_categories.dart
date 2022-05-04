import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager_bloc/db/functions/db_functions.dart';
import 'package:money_manager_bloc/db/models/db_model.dart';
import 'package:money_manager_bloc/logic/cubit/cubit_categories/categories_cubit.dart';
import 'package:money_manager_bloc/presentations/constants/constants.dart';
import 'package:money_manager_bloc/presentations/widgets/widgets.dart';

List<List<Categories>> type(List<Categories> list) {
  List<Categories> incomeList = [];
  List<Categories> expenseList = [];
  List<List<Categories>> categoriesList = [incomeList, expenseList];
  for (int i = 0; i < list.length; i++) {
    if (list[i].type == true) {
      incomeList.add(list[i]);
    } else {
      expenseList.add(list[i]);
    }
  }
  return categoriesList;
}

class IncomeCategory extends StatelessWidget {
  IncomeCategory({Key? key}) : super(key: key);

  final Box<Categories> categories = Hive.box<Categories>(categoryBox);

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenTheme,
        title: const Text('Income Category'),
        centerTitle: true,
      ),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          List<Categories> catgoriesList = type(categories.values.toList())[0];
          return catgoriesList.isEmpty
              ? const Center(
                  child: Text(
                    'Add some Categories',
                  ),
                )
              : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: mediaQueryWidth * 0.01,
                          right: mediaQueryWidth * 0.01),
                      child: Card(
                        child: ListTile(
                          title: Text(catgoriesList[index].category),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  categoryAddPopup(
                                      context, catgoriesList[index].key);
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Warning!',
                                            style: TextStyle(color: redTheme)),
                                        content: const Text(
                                            'Do you want to delete?'),
                                        actions: [
                                          TextButton(
                                              child: const Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                              onPressed: () {
                                                BlocProvider.of<
                                                    CategoriesCubit>(
                                                  context,
                                                ).deleteCategoryListUpdated(
                                                  categories,
                                                  catgoriesList[index].key,
                                                );
                                                Navigator.pop(context);
                                              }),
                                          TextButton(
                                            child: const Text(
                                              'NO',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const SizedBox.shrink();
                  },
                  itemCount: catgoriesList.length,
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          categoryAddPopup(context, null);
        },
        backgroundColor: greenTheme,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> categoryAddPopup(BuildContext context, int? key) async {
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    final formKey = GlobalKey<FormState>();
    TextEditingController controller = TextEditingController();
    controller.text = key != null ? categories.get(key)!.category : "";

    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: key == null
              ? const Text('Add Category')
              : const Text('Update Category'),
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: mediaQueryWidth * 0.02, right: mediaQueryWidth * 0.02),
              child: Form(
                key: formKey,
                child: TextFormField(
                    cursorColor: greenTheme,
                    controller: controller,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 241, 241, 241),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return "Add a Category";
                      }
                      return null;
                    }),
              ),
            ),
            VerticalSpace(height: mediaQueryHeight * 0.01),
            Padding(
              padding: EdgeInsets.only(
                  left: mediaQueryWidth * 0.2, right: mediaQueryWidth * 0.2),
              child: ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        Size(mediaQueryWidth * 0.05, mediaQueryHeight * 0.05),
                      ),
                      backgroundColor: MaterialStateProperty.all(greenTheme)),
                  child: key == null ? const Text('Add') : const Text('Update'),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (controller.text != '') {
                        Categories newCategory =
                            Categories(category: controller.text, type: true);
                        if (key == null) {
                          BlocProvider.of<CategoriesCubit>(context)
                              .addCategoryListUpdated(
                            DbFunctions.getCatBox(),
                            newCategory,
                          );
                        } else {
                          BlocProvider.of<CategoriesCubit>(context)
                              .editCategoryListUpdated(
                            DbFunctions.getCatBox(),
                            newCategory,
                            key,
                          );
                        }
                        Navigator.pop(context);
                      }
                    }
                  }),
            )
          ],
        );
      },
    );
  }
}
