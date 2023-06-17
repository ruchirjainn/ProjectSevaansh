import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_sevaansh/causes_details/causes_details.dart';
import 'package:project_sevaansh/constants/routes.dart';
import 'package:project_sevaansh/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:project_sevaansh/models/category_models/category_model.dart';
import 'package:project_sevaansh/models/product_models/product_model.dart';

class CategoryView extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<ProductModel> productModelList = [];

  bool isLoading = false;
  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance
        .getCategoryViewProduct(widget.categoryModel.id);
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kToolbarHeight * 1),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const BackButton(),
                        Text(
                          widget.categoryModel.name,
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  productModelList.isEmpty
                      ? const Center(
                          child: Text("Category is empty"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: productModelList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: 2.4,
                                      crossAxisCount: 1),
                              itemBuilder: (ctx, index) {
                                ProductModel singleProduct =
                                    productModelList[index];
                                return SizedBox(
                                  height: 200,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Expanded(
                                          child: Image.network(
                                            singleProduct.image,
                                            height: 115,
                                            width: 115,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 26,
                                              ),
                                              Text(
                                                singleProduct.name,
                                                style: GoogleFonts.lora(
                                                  textStyle: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              SizedBox(
                                                height: 40,
                                                width: 165,
                                                child: OutlinedButton(
                                                  onPressed: () {
                                                    Routes.instance.push(
                                                      widget: ProductDetails(
                                                        singleProduct:
                                                            singleProduct,
                                                      ),
                                                      context: context,
                                                    );
                                                  },
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.blue,
                                                    side: const BorderSide(
                                                      color: Colors.black54,
                                                      width: 1.7,
                                                    ),
                                                    disabledForegroundColor:
                                                        Colors.blue
                                                            .withOpacity(0.38),
                                                  ),
                                                  child: const Text(
                                                    "Support",
                                                    style: TextStyle(
                                                      color: Colors.blueGrey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                  const SizedBox(
                    height: 12.0,
                  ),
                ],
              ),
            ),
    );
  }
}

// Text(
//                                           singleProduct.name,
//                                           style: const TextStyle(
//                                             fontSize: 18.0,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 30.0,
//                                         ),
//                                         SizedBox(
//                                           height: 45,
//                                           width: 140,
//                                           child: OutlinedButton(
//                                             onPressed: () {
//                                               Routes.instance.push(
//                                                   widget: ProductDetails(
//                                                       singleProduct:
//                                                           singleProduct),
//                                                   context: context);
//                                             },
//                                             child: const Text(
//                                               "Buy",
//                                             ),
//                                           ),
//                                         ),
