import 'package:foodies/Features/Cart/Screens/cart_history_screen.dart';
import 'package:foodies/Features/Account/Screens/account_screen.dart';
import 'package:foodies/Features/Home/Screens/home_screen.dart';
import 'package:foodies/Controllers/location_controller.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:foodies/Constants/colors.dart';
import 'package:foodies/Constants/utils.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:foodies/Features/Order/Screens/order_screen.dart';
import 'package:get/get.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _loadResources();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.mainBackground,
      resizeToAvoidBottomInset: false,
      // animations package

      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation,
        ) {
          return SharedAxisTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.vertical,
            fillColor: AppColors.mainBackground,
            // key: Key(_selectedIndex.hashCode.toString()),
            child: child,
          );
        },
        child: IndexedStack(
          key: Key(_selectedIndex.hashCode.toString()),
          index: _selectedIndex,
          children: _buildScreens(),
        ),
      ),

      bottomNavigationBar: Builder(
        builder: (BuildContext context) => ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
          child: BottomNavigationBar(
            elevation: 0.0,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            unselectedIconTheme: IconThemeData(
              color: Colors.black54,
              size: rValue(
                context: context,
                defaultValue: 22.0,
                whenSmaller: 19.0,
              ),
            ),
            selectedIconTheme: IconThemeData(
              size: rValue(
                context: context,
                defaultValue: 27.0,
                whenSmaller: 22.5,
              ),
            ),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                backgroundColor: AppColors.mainRed,
                icon: Icon(Icons.home),
                label: "",
                activeIcon: Icon(
                  Icons.home,
                  color: AppColors.mainBackground,
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: AppColors.catGreen,
                icon: Icon(
                  Icons.archive,
                ),
                activeIcon: Icon(
                  Icons.archive,
                  color: AppColors.mainBackground,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                backgroundColor: AppColors.catRed,
                icon: Icon(Icons.shopping_cart),
                label: "",
                activeIcon: Icon(
                  Icons.shopping_cart,
                  color: AppColors.mainBackground,
                ),
              ),
              BottomNavigationBarItem(
                  backgroundColor: AppColors.pizzaYellow,
                  icon: Icon(Icons.person),
                  label: "",
                  activeIcon: Icon(
                    Icons.person,
                    color: AppColors.mainBackground,
                  )),
            ],
            currentIndex: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
  // ****************************** Helper Methods ******************************

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const OrderScreen(),
      const CartHistoryScreen(),
      const AccountScreen(),
    ];
  }

  Future<void> _loadResources() async {
    await Get.find<LocationController>().getAddressListFromServer();
  }
}




/*
    PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: AppColors.secondaryBackground,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: const NavBarDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style12,
    );
*/

/*
  List<Widget> _buildScreens() {
    return [
   const HomeScreen(),
      const Center(child: Text("Archive Page")),
      const CartHistoryScreen(),
      const AccountScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.mainRed,
        inactiveColorPrimary: AppColors.mainBackground,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.archive),
        title: ("Settings"),
        activeColorPrimary: AppColors.mainRed,
        inactiveColorPrimary: AppColors.mainBackground,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart_rounded),
        title: ("Settings"),
        activeColorPrimary: AppColors.mainRed,
        inactiveColorPrimary: AppColors.mainBackground,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Settings"),
        activeColorPrimary: AppColors.mainRed,
        inactiveColorPrimary: AppColors.mainBackground,
      ),
    ];
  }
}
*/

/* 

//

      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
        child: BottomNavigationBar(
          elevation: 0.0,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          unselectedIconTheme: IconThemeData(
            color: AppColors.secondaryBackground,
            size: rValue(
              context: context,
              defaultValue: 22.0,
              whenSmaller: 19.0,
            ),
          ),
          selectedIconTheme: IconThemeData(
            size: rValue(
              context: context,
              defaultValue: 27.0,
              whenSmaller: 22.5,
            ),
          ),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                backgroundColor: AppColors.mainRed,
                icon: Icon(Icons.home),
                label: "",
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.white70,
                )),
            BottomNavigationBarItem(
              backgroundColor: Colors.black87,
              icon: Icon(Icons.archive),
              label: "",
            ),
            BottomNavigationBarItem(
              backgroundColor: AppColors.catRed,
              icon: Icon(Icons.shopping_cart),
              label: "",
              activeIcon: Icon(
                Icons.shopping_cart,
                color: AppColors.catGreen,
              ),
            ),
            BottomNavigationBarItem(
                backgroundColor: AppColors.pizzaYellow,
                icon: Icon(Icons.person),
                label: "",
                activeIcon: Icon(
                  Icons.person,
                  color: AppColors.pizzaRed,
                )),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),

*/


/*

  ConvexAppBar(
        style: TabStyle.react,
        backgroundColor: AppColors.mainBackground,
        curve: Curves.easeInOut,
        color: AppColors.secondaryBackground,
        elevation: 5.0,
        activeColor: activeColor(),
        initialActiveIndex: 0,
        items: const <TabItem>[
          TabItem(
            icon: Icons.home,
            activeIcon: Icon(
              Icons.home,
              size: 32.0,
            ),
          ),
          TabItem(
            icon: Icons.archive,
            activeIcon: Icon(
              Icons.archive,
              size: 32.0,
            ),
          ),
          TabItem(
            icon: Icons.shopping_cart,
            activeIcon: Icon(
              Icons.shopping_cart,
              size: 32.0,
            ),
          ),
          TabItem(
            icon: Icons.person,
            activeIcon: Icon(
              Icons.person,
              size: 32.0,
            ),
          ),
        ],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const Center(child: Text("Archive Page")),
      const CartHistoryScreen(),
      const AccountScreen(),
    ];
  }

  Color? activeColor() {
    if (_selectedIndex == 0) {
      return Colors.white;
    } else if (_selectedIndex == 1) {
      return Colors.black45;
    } else if (_selectedIndex == 2) {
      return AppColors.catRed;
    } else {
      return AppColors.pizzaYellow;
    }
  }



 */