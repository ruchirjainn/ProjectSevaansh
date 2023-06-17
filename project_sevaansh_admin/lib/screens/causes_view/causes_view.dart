import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_sevaansh_admin/constants/routes.dart';
import 'package:project_sevaansh_admin/models/product_models/product_model.dart';
import 'package:project_sevaansh_admin/provider/app_provider.dart';
import 'package:project_sevaansh_admin/screens/category_view/add_category/add_category.dart';
import 'package:project_sevaansh_admin/screens/causes_view/add_causes/add_causes.dart';
import 'package:project_sevaansh_admin/screens/causes_view/widgets/single_cause_view.dart';
import 'package:provider/provider.dart';

class CausesView extends StatefulWidget {
  const CausesView({super.key});

  @override
  State<CausesView> createState() => _CausesViewState();
}

class _CausesViewState extends State<CausesView> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Causes View',
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
              Routes.instance.push(widget: const AddCause(), context: context);
            },
            icon: const Icon(Icons.add_circle),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '  Causes',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              GridView.builder(
                padding: const EdgeInsets.all(12),
                shrinkWrap: true,
                primary: false,
                itemCount: appProvider.getCauses.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 2.3, // Adjust the aspect ratio as needed
                    crossAxisCount: 1 // Change the crossAxisCount to 1
                    ),
                itemBuilder: (ctx, index) {
                  CauseModel singleProduct = appProvider.getCauses[index];
                  return SingleCauseView(
                    singleCause: singleProduct,
                    index: index,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
