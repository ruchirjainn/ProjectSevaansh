import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_sevaansh_admin/constants/routes.dart';
import 'package:project_sevaansh_admin/models/product_models/product_model.dart';
import 'package:project_sevaansh_admin/provider/app_provider.dart';
import 'package:project_sevaansh_admin/screens/causes_view/edit_causes/edit_causes.dart';
import 'package:provider/provider.dart';

class SingleCauseView extends StatefulWidget {
  const SingleCauseView({
    super.key,
    required this.singleCause,
    required this.index,
  });

  final CauseModel singleCause;
  final int index;

  @override
  State<SingleCauseView> createState() => _SingleCauseViewState();
}

class _SingleCauseViewState extends State<SingleCauseView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return SizedBox(
      height: 200, // Adjust the height as needed
      child: Container(
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Image.network(
                widget.singleCause.image,
                height: 120,
                width: 120,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 48,
                  ),
                  Text(
                    widget.singleCause.name,
                    style: const TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
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
                              .deleteCauseFromFirebase(widget.singleCause);
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
                      width: 12,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        Routes.instance
                            .push(widget: EditCause(productModel: widget.singleCause,index: widget.index), context: context);
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
      ),
    );
  }
}
