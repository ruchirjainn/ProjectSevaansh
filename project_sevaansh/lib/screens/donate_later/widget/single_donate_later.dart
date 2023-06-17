import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_sevaansh/causes_details/causes_details.dart';
import 'package:project_sevaansh/constants/constants.dart';
import 'package:project_sevaansh/constants/routes.dart';
import 'package:project_sevaansh/models/product_models/product_model.dart';
import 'package:project_sevaansh/provider/app_provider.dart';
import 'package:provider/provider.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel singleProduct;
  const SingleCartItem({super.key, required this.singleProduct});

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red, width: 2),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 95,
              // width: 100,
              color: Colors.white.withOpacity(0.5),
              child: Image.network(
                widget.singleProduct.image,
                height: 90,
                width: 50,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 140,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 14,
                          ),
                          Text(
                            widget.singleProduct.name,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 90,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Routes.instance.push(
                                      widget: ProductDetails(
                                        singleProduct: widget.singleProduct,
                                      ),
                                      context: context,
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.blue,
                                    side: const BorderSide(
                                      color: Colors.blue,
                                      width: 1.5,
                                    ),
                                    disabledForegroundColor:
                                        Colors.blue.withOpacity(0.38),
                                  ),
                                  child: const Text(
                                    "Support",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    appProvider.removeCartProduct(
                                        widget.singleProduct);
                                    showMessage("Removed from Donate Later");
                                  },
                                  child: const CircleAvatar(
                                    maxRadius: 18,
                                    child: Icon(
                                      Icons.delete,
                                      size: 20,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
