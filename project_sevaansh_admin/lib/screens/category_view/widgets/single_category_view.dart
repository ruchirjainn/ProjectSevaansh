import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project_sevaansh_admin/constants/routes.dart';
import 'package:project_sevaansh_admin/models/category_models/category_model.dart';
import 'package:project_sevaansh_admin/provider/app_provider.dart';
import 'package:project_sevaansh_admin/screens/category_view/edit_category/edit_category.dart';
import 'package:provider/provider.dart';

class SingleCategoryView extends StatefulWidget {
  final CategoryModel singleCategory;
  final int index;
  const SingleCategoryView(
      {super.key, required this.singleCategory, required this.index});

  @override
  State<SingleCategoryView> createState() => _SingleCategoryViewState();
}

class _SingleCategoryViewState extends State<SingleCategoryView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Card(
      color: Colors.white,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              child: Image.network(
                widget.singleCategory.image,
                scale: 2,
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IgnorePointer(
                    ignoring: isLoading,
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await appProvider
                            .deleteCategoryFromFirebase(widget.singleCategory);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      Routes.instance.push(
                          widget: EditCategory(
                              categoryModel: widget.singleCategory,
                              index: widget.index),
                          context: context);
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
