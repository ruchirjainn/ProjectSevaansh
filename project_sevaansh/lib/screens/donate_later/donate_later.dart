import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_sevaansh/provider/app_provider.dart';
import 'package:project_sevaansh/screens/donate_later/widget/single_donate_later.dart';
import 'package:provider/provider.dart';

class DonateLaterScreen extends StatefulWidget {
  // final ProductModel singleProduct;

  const DonateLaterScreen({super.key});

  @override
  State<DonateLaterScreen> createState() => _DonateLaterScreenState();
}

class _DonateLaterScreenState extends State<DonateLaterScreen> {
  int qty = 0;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Donate Later Screen",
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: appProvider.getCartProductList.isEmpty
          ? const Center(
              child: Text("Donation later is Empty"),
            )
          : ListView.builder(
              itemCount: appProvider.getCartProductList.length,
              padding: const EdgeInsets.all(12.0),
              itemBuilder: (ctx, index) {
                return SingleCartItem(
                  singleProduct: appProvider.getCartProductList[index],
                );
              },
            ),
    );
  }
}
