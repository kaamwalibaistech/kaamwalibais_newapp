import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/core/local_storage.dart';
import 'package:kaamwalijobs_new/features/dashboard/presentation/bookmaid_screen.dart';
import 'package:kaamwalijobs_new/features/dashboard/presentation/homepage_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../constant/colors.dart';
import '../../auth/presentation/login_popup.dart';
import '../../dashboard/presentation/menu_screen.dart';
import '../../dashboard/presentation/profile_screen.dart';

class Navigationscreen extends StatefulWidget {
  const Navigationscreen({super.key});

  @override
  State<Navigationscreen> createState() => _NavigationscreenState();
}

class _NavigationscreenState extends State<Navigationscreen> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "lib/assets/images/home2.png",
          height: 20,
          width: 20,
        ),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey3,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          "lib/assets/images/job.png",
          height: 20,
          width: 20,
        ),
        title: ("BookMaid"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey3,
      ),
      PersistentBottomNavBarItem(
        onPressed: (p0) {
          final userLogIn = LocalStoragePref().getUserProfile();
          if (userLogIn != null) {
            controller.index = 2;
          } else {
            checkLoginPopup();
          }
        },
        icon: Image.asset(
          'lib/assets/images/person2.png',
          height: 20,
          width: 20,
        ),
        title: ("Profile"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey3,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.menu),
        title: ("Menu"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey3,
      ),
    ];
  }

  List<Widget> buildScreens() {
    return [
      const HomepageScreen(),
      const BookmaidScreen(),
      const ProfileScreen(),
      const MenuScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: controller,
        screens: buildScreens(),
        items: navBarsItems(),
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardAppears: true,

        padding: const EdgeInsets.only(top: 8),
        // backgroundColor: Colors.grey.shade900,
        isVisible: true,

        confineToSafeArea: true,
        navBarHeight: kBottomNavigationBarHeight,
        navBarStyle: NavBarStyle.style1,
        // Choose the nav bar style with this property
        backgroundColor: blueColor,
      ),
    );
  }

  checkLoginPopup() async {
    // String isLogin = await LocalStoragePref.instance?.isLogin() ?? 'false';
    // if (!(bool.tryParse(isLogin) ?? false)) {
    showDialog(
        context: context,
        builder: (context) =>
            const AlertDialog(scrollable: true, content: LoginPopup()));
    // }
  }
}
