import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/features/dashboard/presentation/bookmaid_screen.dart';
import 'package:kaamwalijobs_new/features/dashboard/presentation/homepage_screen.dart';

import '../../dashboard/presentation/menu_screen.dart';
import '../../dashboard/presentation/profile_screen.dart';

class Navigationscreen extends StatefulWidget {
  const Navigationscreen({super.key});

  @override
  State<Navigationscreen> createState() => _NavigationscreenState();
}

class _NavigationscreenState extends State<Navigationscreen> {
  int selectedIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  // final loginModel = LocalStoragePref().getLoginModel();

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

  // PersistentTabController controller = PersistentTabController(initialIndex: 0);
//  final bottomNavigationBar: BottomNavigationBar(
//           currentIndex = selectedIndex,
//           onTap = changeTab, // Update PageView when tapping tabs
//           type = BottomNavigationBarType.fixed,
//           // backgroundColor: Colors.amber,
//           showSelectedLabels = false,
//           showUnselectedLabels = false,
//           iconSize = 30,
//           selectedItemColor = Colors.deepOrangeAccent,
//           unselectedItemColor = Colors.blueGrey,
//           items = [
//             const BottomNavigationBarItem(
//                 icon: Icon(Icons.home_outlined),
//                 label: "Home",
//                 activeIcon: Icon(Icons.home_rounded)),
//             const BottomNavigationBarItem(
//                 icon: Icon(Icons.shopping_bag_outlined),
//                 label: "Needs",
//                 activeIcon: Icon(Icons.shopping_bag_rounded)),
//             const BottomNavigationBarItem(
//                 icon: Icon(Icons.message_outlined),
//                 label: "Messege",
//                 activeIcon: Icon(Icons.message)),
//             BottomNavigationBarItem(
//                 icon: Image.asset(
//                   "lib/assets/man.png",
//                   scale: 14,
//                 ),
//                 label: "Profile",
//                 activeIcon: Container(
//                   padding: const EdgeInsets.all(4),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(100),
//                       border: Border.all(
//                           width: 0.5, color: Colors.deepOrangeAccent)),
//                   child: Image.asset(
//                     "lib/assets/man.png",
//                     scale: 18,
//                   ),
//                 )),
//           ],
//         ),

  // List<Widget> buildScreens() {
  //   return [
  //     const HomepageScreen(),
  //     const BookmaidScreen(),
  //     const ProfileScreen(),
  //     const MenuScreen(),
  //   ];
  // }

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
        selectedItemColor: Colors.green,
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

  // checkLoginPopup() async {
  //   // String isLogin = await LocalStoragePref.instance?.isLogin() ?? 'false';
  //   // if (!(bool.tryParse(isLogin) ?? false)) {
  //   showDialog(
  //       contColor.fromARGB(255, 255, 255, 255)builder: (context) =>
  //           const AlertDialog(scrollable: true, content: LoginPopup()));
  //   // }
  // }
}
