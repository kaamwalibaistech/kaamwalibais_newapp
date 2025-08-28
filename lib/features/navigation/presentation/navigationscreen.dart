import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:kaamwalijobs_new/constant/colors.dart';
>>>>>>> 3c365715246824f55bd1c788ec0eb6b7fe2a3825
import 'package:kaamwalijobs_new/features/dashboard/presentation/bookmaid_screen.dart';
import 'package:kaamwalijobs_new/features/dashboard/presentation/homepage_screen.dart';

<<<<<<< HEAD
import '../../../assets/colors.dart';
import '../../auth/presentation/login_popup.dart';
=======
>>>>>>> 3c365715246824f55bd1c788ec0eb6b7fe2a3825
import '../../dashboard/presentation/menu_screen.dart';
import '../../dashboard/presentation/profile_screen.dart';

class Navigationscreen extends StatefulWidget {
  const Navigationscreen({super.key});

  @override
  State<Navigationscreen> createState() => _NavigationscreenState();
}

class _NavigationscreenState extends State<Navigationscreen> {
<<<<<<< HEAD
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
=======
  int selectedIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
>>>>>>> 3c365715246824f55bd1c788ec0eb6b7fe2a3825
  }

  void changeTab(int index) {
    setState(() {
      selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          changeTab(value);
          setState(() => selectedIndex = value); // Update selected index
          _pageController
              .jumpToPage(value); // Update PageView when tapping tabs
        }, // Update PageView when tapping tabs
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.amber,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        selectedItemColor: blueColor,
        unselectedItemColor: Colors.blueGrey,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
              activeIcon: Icon(Icons.home_rounded)),
          const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: "BookMaid",
              activeIcon: Icon(Icons.shopping_bag_rounded)),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person_3_outlined),
              label: "Profile",
              activeIcon: Icon(Icons.person_3_outlined)),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: "Menu",
              activeIcon: Icon(Icons.menu)),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => selectedIndex = index);
        },
        children: [
          const HomepageScreen(),
          const BookmaidScreen(),
          const ProfileScreen(),
          const MenuScreen(),
        ],
      ),
    );
  }
<<<<<<< HEAD

  checkLoginPopup() async {
    // String isLogin = await LocalStoragePref.instance?.isLogin() ?? 'false';
    // if (!(bool.tryParse(isLogin) ?? false)) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(content: LoginPopup()));
    // }
  }
=======
>>>>>>> 3c365715246824f55bd1c788ec0eb6b7fe2a3825
}
