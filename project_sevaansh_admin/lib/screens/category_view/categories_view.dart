import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_sevaansh_admin/constants/routes.dart';
import 'package:project_sevaansh_admin/models/category_models/category_model.dart';
import 'package:project_sevaansh_admin/models/user_models/user_model.dart';
import 'package:project_sevaansh_admin/provider/app_provider.dart';
import 'package:project_sevaansh_admin/screens/category_view/add_category/add_category.dart';
import 'package:project_sevaansh_admin/screens/category_view/widgets/single_category_view.dart';
import 'package:project_sevaansh_admin/screens/user_view/widgets/single_user_view.dart';
import 'package:provider/provider.dart';

class CategoriesVIew extends StatelessWidget {
  const CategoriesVIew({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cateogries View',
          style: GoogleFonts.lora(
            textStyle: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Routes.instance
                  .push(widget: const AddCategory(), context: context);
            },
            icon: const Icon(Icons.add_circle),
          )
        ],
      ),
      body: Consumer<AppProvider>(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: GoogleFonts.ubuntu(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: value.getCategoriesList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      CategoryModel categoryModel =
                          value.getCategoriesList[index];
                      return SingleCategoryView(
                        singleCategory: categoryModel,
                        index: index,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
