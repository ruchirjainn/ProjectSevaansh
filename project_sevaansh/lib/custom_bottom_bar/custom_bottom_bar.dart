// ignore_for_file: library_private_types_in_public_api

import "package:persistent_bottom_nav_bar/persistent_tab_view.dart";
import 'package:flutter/material.dart';
import 'package:project_sevaansh/account_screen/account_screen.dart';
import 'package:project_sevaansh/homepage/home.dart';
import 'package:project_sevaansh/mailing_system/mail_system.dart';
import 'package:project_sevaansh/screens/donate_later/donate_later.dart';
// import 'package:ecommerce_app/screens/cart_screen/cart_screen.dart';
// import 'package:ecommerce_app/screens/homepage/home.dart';
// import 'package:ecommerce_app/screens/favorite_screen/favorite_screen.dart';
// import 'package:ecommerce_app/screens/account_screen/account_screen.dart';

// import 'package:ecommerce_app/constants/theme.dart';
// import 'package:ecommerce_app/firebase_helper/firbase_auth_helper/firebase_auth_helper.dart';
// import 'package:ecommerce_app/provider/app_provider.dart';
// import 'package:ecommerce_app/screens/auth_ui/welcome/welcome.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';
// import 'package:ecommerce_app/screens/custom_bottom_bar/custom_bottom_bar';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({
    final Key? key,
  }) : super(key: key);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  final PersistentTabController _controller = PersistentTabController();
  final bool _hideNavBar = false;

  List<Widget> _buildScreens() => [
        const Home(),
        const DonateLaterScreen(),
        const MailScreen(),
        const AccountScreen(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          inactiveIcon: const Icon(Icons.home_outlined),
          title: "Home",
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.save),
          inactiveIcon: const Icon(Icons.save_alt_outlined),
          title: "Donate",
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.mail),
          inactiveIcon: const Icon(Icons.mail_outline),
          title: "Mails",
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          inactiveIcon: const Icon(Icons.person_outline),
          title: "Account",
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.white,
        ),
      ];

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          resizeToAvoidBottomInset: true,
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight,
          bottomScreenMargin: 0,

          backgroundColor: const Color.fromRGBO(33, 33, 33, 0.75),
          hideNavigationBar: _hideNavBar,
          decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
          ),
          navBarStyle:
              NavBarStyle.style1, // Choose the nav bar style with this property
        ),
      );
}
