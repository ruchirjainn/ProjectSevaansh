import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_sevaansh/causes_details/causes_details.dart';
import 'package:project_sevaansh/constants/routes.dart';
import 'package:project_sevaansh/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:project_sevaansh/models/category_models/category_model.dart';
import 'package:project_sevaansh/models/product_models/product_model.dart';
import 'package:project_sevaansh/provider/app_provider.dart';
import 'package:project_sevaansh/screens/category_view/category_view.dart';
import 'package:project_sevaansh/widgets/top_titles/top_titles.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];
  bool isLoading = false;

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getAllCauses();
    productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  const SizedBox(
                        //   height: .0,
                        // ),
                        const TopTitles(
                            title: "Project Sevaansh", subtitle: ""),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Text(
                          "Categories",
                          style: GoogleFonts.openSans(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  categoriesList.isEmpty
                      ? const Center(
                          child: Text("Categories is empty"),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoriesList
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: CupertinoButton(
                                      onPressed: () {
                                        Routes.instance.push(
                                            widget:
                                                CategoryView(categoryModel: e),
                                            context: context);
                                      },
                                      padding: EdgeInsets.zero,
                                      child: Card(
                                        color: Colors.white,
                                        elevation: 3.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: SizedBox(
                                          height: 120,
                                          width: 120,
                                          child: Image.network(e.image),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Different Causes",
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  productModelList.isEmpty
                      ? const Center(
                          child: Text("Product list is empty"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GridView.builder(
                            padding: const EdgeInsets.only(bottom: 50),
                            shrinkWrap: true,
                            primary: false,
                            itemCount: productModelList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    childAspectRatio:
                                        2.2, // Adjust the aspect ratio as needed
                                    crossAxisCount:
                                        1 // Change the crossAxisCount to 1
                                    ),
                            itemBuilder: (ctx, index) {
                              ProductModel singleProduct =
                                  productModelList[index];
                              return SizedBox(
                                height: 200, // Adjust the height as needed
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        Colors.black87.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Image.network(
                                          singleProduct.image,
                                          height: 120,
                                          width: 120,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 33,
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
                                              height: 15,
                                            ),
                                            SizedBox(
                                              height: 50,
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
                                                style: OutlinedButton.styleFrom(
                                                  foregroundColor: Colors.blue,
                                                  side: const BorderSide(
                                                    color: Colors.blue,
                                                    width: 1.7,
                                                  ),
                                                  disabledForegroundColor:
                                                      Colors.blue
                                                          .withOpacity(0.38),
                                                ),
                                                child: Text(
                                                  "Support",
                                                  style: GoogleFonts.lato(
                                                    textStyle: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blueGrey,
                                                    ),
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
                            },
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}



// List<ProductModel> bestProducts = [
//   ProductModel(
//       image:
//           "https://freepngimg.com/thumb/vector/159878-photos-vector-noodles-chopsticks-free-download-png-hq.png",
//       id: "1",
//       name: "Banana",
//       price: "1",
//       isFavourite: false,
//       description:
//           "Good for Health, Prefer it for pre workout gives 3gm protien",
//       status: "pending"),
//   ProductModel(
//       image:
//           "https://www.pngmart.com/files/21/Single-Strawberries-PNG-Photo.png",
//       id: "2",
//       name: "Strawberries",
//       price: "1",
//       isFavourite: false,
//       description: "Eat it n fresh eat karo",
//       status: "pending"),
//   ProductModel(
//       image:
//           "https://www.transparentpng.com/thumb/apple-fruit/GhtiN4-single-apple-fruit-clipart-png-file.png",
//       id: "3",
//       name: "Apple",
//       price: "1",
//       isFavourite: false,
//       description: "Eat it n fresh eat karo",
//       status: "pending"),
//   ProductModel(
//       image:
//           "https://purepng.com/public/uploads/large/purepng.com-fresh-single-blackberry-fruitfruitsberryberriesblackberriesblackberry-981524764315uxckj.png",
//       id: "4",
//       name: "Watermelon",
//       price: "9",
//       isFavourite: false,
//       description: "Good for health",
//       status: "pending"),
// ];
