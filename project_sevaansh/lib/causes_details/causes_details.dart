import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_sevaansh/constants/constants.dart';
import 'package:project_sevaansh/constants/routes.dart';
import 'package:project_sevaansh/models/product_models/product_model.dart';
import 'package:project_sevaansh/provider/app_provider.dart';
import 'package:project_sevaansh/screens/donate_later/donate_later.dart';
import 'package:project_sevaansh/screens/donate_payment_screen.dart/donate_screen_payment.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel singleProduct;

  const ProductDetails({Key? key, required this.singleProduct})
      : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // int qty = 1;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions:  [
          IconButton(
            onPressed: () {
              Routes.instance
                  .push(widget: const DonateLaterScreen(), context: context);
            },
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.singleProduct.image,
                height: 300,
                width: 400,
              ),
              const SizedBox(height: 16),
              Text(
                widget.singleProduct.name,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  // IconButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       widget.singleProduct.isFavourite = !widget.singleProduct.isFavourite;
                  //     });
                  //     if (widget.singleProduct.isFavourite) {
                  //       appProvider.addFavoriteProduct(widget.singleProduct);
                  //     } else {
                  //       appProvider.removeFavoriteProduct(widget.singleProduct);
                  //     }
                  //   },
                  //   icon: Icon(
                  //     appProvider.getFavoriteProductList.contains(widget.singleProduct)
                  //         ? Icons.favorite
                  //         : Icons.favorite_border,
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.singleProduct.description,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 20),
              
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 45,
                    width: 150,
                    child: OutlinedButton(
                      
                      onPressed: () {
                        AppProvider appProvider =
                            Provider.of<AppProvider>(context, listen: false);
                        ProductModel productModel =
                            widget.singleProduct.copyWith();
                        appProvider.addCartProduct(productModel);
                        showMessage("Added to Donate Later");
                      },
                      child: const Text("DONATE LATER"),
                    ),
                  ),
                  const SizedBox(
                    width: 24.0,
                  ),
                  SizedBox(
                    height: 45,
                    width: 140,
                    child: ElevatedButton(
                      onPressed: () {
                        Routes.instance.push(
                            widget: const DonatePayment(), context: context);
                      },
                      child: const Text("SUPPORT"),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
