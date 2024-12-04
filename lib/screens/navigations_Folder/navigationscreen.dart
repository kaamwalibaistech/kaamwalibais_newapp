import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/screens/navigations_Folder/bookmaid_screen.dart';
import 'package:kaamwalijobs_new/screens/navigations_Folder/homepage_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../assets/colors.dart';
import 'menu_screen.dart';
import 'profile_screen.dart';

class Navigationscreen extends StatefulWidget {
  const Navigationscreen({super.key});

  @override
  State<Navigationscreen> createState() => _NavigationscreenState();
}

class _NavigationscreenState extends State<Navigationscreen> {
  @override
  Widget build(BuildContext context) {





    List<PersistentBottomNavBarItem> navBarsItems() {
        return [
            PersistentBottomNavBarItem(
                icon: Image.asset("lib/assets/images/home2.png",  height: 20,
          width: 20,),
                title: ("Home"),
                activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey3,
                
            ),
            PersistentBottomNavBarItem(
                icon:  Image.asset("lib/assets/images/job.png",  height: 20,
          width: 20,),
                title: ("BookMaid"),
                   activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey3,
            ),

            PersistentBottomNavBarItem(
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





PersistentTabController controller;

controller = PersistentTabController(initialIndex: 0);


List<Widget> buildScreens() {
        return [
          const HomepageScreen(),
          const BookmaidScreen(),
          const ProfileScreen(),
          const MenuScreen(),
        ];
    }
 
    return Scaffold(
      body: PersistentTabView(
          context,
          controller: controller,
          screens: buildScreens(),
          items: navBarsItems(),
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardAppears: true,
          // popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
          padding: const EdgeInsets.only(top: 8),
          // backgroundColor: Colors.grey.shade900,
          isVisible: true,
          animationSettings: const NavBarAnimationSettings(
              navBarItemAnimation: ItemAnimationSettings( // Navigation Bar's items animation properties.
                  duration: Duration(milliseconds: 400),
                  curve: Curves.ease,
              ),
              screenTransitionAnimation: ScreenTransitionAnimationSettings( // Screen transition animation on change of selected tab.
                  animateTabTransition: true,
                  duration: Duration(milliseconds: 400),
                  screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
              ),
          ),
          confineToSafeArea: true,
          navBarHeight: kBottomNavigationBarHeight,
          navBarStyle: NavBarStyle.style1, 
          // Choose the nav bar style with this property
          backgroundColor: blueColor,
             
        ),
    );
  }
}

