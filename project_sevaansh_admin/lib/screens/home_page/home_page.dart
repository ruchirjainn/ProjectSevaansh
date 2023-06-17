import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_sevaansh_admin/constants/routes.dart';
import 'package:project_sevaansh_admin/provider/app_provider.dart';
import 'package:project_sevaansh_admin/screens/category_view/categories_view.dart';
import 'package:project_sevaansh_admin/screens/causes_view/causes_view.dart';
import 'package:project_sevaansh_admin/screens/home_page/widgets/single_dash_type.dart';
import 'package:project_sevaansh_admin/screens/user_view/user_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    await appProvider.callbakFunction();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title:  Center(
            child: Text(
          "Sevaansh Dashboard",
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        )),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.only(top: 12),
                      crossAxisCount: 2,
                      children: [
                        SingleDashType(
                          title: appProvider.getUserList.length.toString(),
                          subtitle: 'USERS',
                          onPressed: () {
                            Routes.instance.push(
                                widget: const UserView(), context: context);
                          },
                        ),
                        SingleDashType(
                          title:
                              appProvider.getCategoriesList.length.toString(),
                          subtitle: 'CATEGORY',
                          onPressed: () {
                            Routes.instance.push(
                                widget: const CategoriesVIew(),
                                context: context);
                          },
                        ),
                        SingleDashType(
                          subtitle: 'CAUSES',
                          title: appProvider.getCauses.length.toString(),
                          onPressed: () {
                            Routes.instance.push(
                                widget: const CausesView(), context: context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
