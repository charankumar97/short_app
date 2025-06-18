import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/cart_screen.dart';
import 'package:short_app/screens/category_screen.dart';
import 'package:short_app/screens/empty_cart_screen.dart';
import 'package:short_app/screens/home_screen.dart';
import 'package:short_app/screens/search_screen.dart';
import 'package:short_app/screens/store_location.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  final List<int> _tabHistory = [0];

  static List<Widget> screens(bool isCartEmpty) {
    return [
      HomeScreen(),
      CategoryScreen(),
      StoreLocation(),
      isCartEmpty ? EmptyCartScreen() : CartScreen(showBackButton: false),
      SearchScreen(showBackButton: false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(
      builder: (context, provider, _) {
        final bool isCartEmpty = provider.cartProducts.isEmpty;
        // final bool isCartTab = _selectedIndex == 3;
        // final bool showBottomBar = !(isCartTab && !isCartEmpty);

        final List<Widget> currentScreens = screens(isCartEmpty);

        return PopScope(
          canPop: true,
          onPopInvokedWithResult: (bool didPop, result) async {
            if (didPop) return;

            if (_tabHistory.length > 1) {
              _tabHistory.removeLast();
              setState(() {
                _selectedIndex = _tabHistory.last;
              });
            } else {
              SystemNavigator.pop();
            }
          },
          child: SafeArea(
            child: Scaffold(
              body: IndexedStack(
                index: _selectedIndex,
                children: currentScreens,
              ),
              bottomNavigationBar: SafeArea(
                child: Container(
                  height: 177.rh,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0, -15),
                        blurRadius: 40,
                      ),
                    ],
                  ),
                  child: BottomNavigationBar(
                    currentIndex: _selectedIndex,
                    onTap: (index) {
                      setState(() {
                        if (_tabHistory.isEmpty || _tabHistory.last != index) {
                          _tabHistory.add(index);
                        }
                        _selectedIndex = index;
                      });
                    },
                    type: BottomNavigationBarType.fixed,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    selectedItemColor: Color.fromRGBO(238, 41, 56, 0.8),
                    unselectedItemColor: Color.fromRGBO(0, 0, 0, 0.5),
                    selectedLabelStyle: TextStyle(
                      fontSize: 25.rt,
                      fontWeight: FontWeight.w800,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 25.rt,
                      fontWeight: FontWeight.w800,
                    ),
                    items: [
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/images/home.svg',
                          width: 100.rw,
                          height: 70.rh,
                          colorFilter: ColorFilter.mode(
                            _selectedIndex == 0
                                ? Color.fromRGBO(238, 41, 56, 0.8)
                                : Color.fromRGBO(0, 0, 0, 0.5),
                            BlendMode.srcIn,
                          ),
                        ),
                        label: 'HOME',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/images/cake.svg',
                          width: 100.rw,
                          height: 70.rh,
                          colorFilter: ColorFilter.mode(
                            _selectedIndex == 1
                                ? Color.fromRGBO(238, 41, 56, 0.8)
                                : Color.fromRGBO(0, 0, 0, 0.5),
                            BlendMode.srcIn,
                          ),
                        ),
                        label: 'CAKES',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/images/store.svg',
                          width: 100.rw,
                          height: 70.rh,
                          colorFilter: ColorFilter.mode(
                            _selectedIndex == 2
                                ? Color.fromRGBO(238, 41, 56, 0.8)
                                : Color.fromRGBO(0, 0, 0, 0.5),
                            BlendMode.srcIn,
                          ),
                        ),
                        label: 'STORES',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/images/basket.svg',
                          width: 100.rw,
                          height: 70.rh,
                          colorFilter: ColorFilter.mode(
                            _selectedIndex == 3
                                ? Color.fromRGBO(238, 41, 56, 0.8)
                                : Color.fromRGBO(0, 0, 0, 0.5),
                            BlendMode.srcIn,
                          ),
                        ),
                        label: 'BASKET',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/images/magnifier.svg',
                          width: 100.rw,
                          height: 70.rh,
                          colorFilter: ColorFilter.mode(
                            _selectedIndex == 4
                                ? Color.fromRGBO(238, 41, 56, 0.8)
                                :Color.fromRGBO(0, 0, 0, 0.5),
                            BlendMode.srcIn,
                          ),
                        ),
                        label: 'SEARCH',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}