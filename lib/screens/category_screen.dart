import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:short_app/screens/search_screen.dart';
import 'package:short_app/screens/sub_category/accessories_screen.dart';
import 'package:short_app/screens/sub_category/cup_cakes_screen.dart';
import 'package:short_app/screens/sub_category/treats_screen.dart';
import 'package:short_app/screens/sub_category/wedding_cakes_screen.dart';
import 'package:short_app/screens/sub_category/cakes_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 460.rh,
                    color: Color(0xFF283577),
                  ),
                  Positioned(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 50.rh),
                      child: Container(
                        height: 130.rh,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60.rs),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 10.rh),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SearchScreen(showBackButton: true)),
                            );
                          },
                          child: AbsorbPointer(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search Delicious Cakes',
                                hintStyle: TextStyle(
                                  color: Color(0xFF1E4489),
                                  fontSize: 40.rt,
                                  fontWeight: FontWeight.w400
                                ),
                                suffixIcon: Icon(
                                  Icons.search,
                                  size: 59.rs,
                                  color: Color(0xFFDC2328),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ),
                  Positioned(
                    child: Padding(
                      padding: EdgeInsets.only(left: 50.rw, right: 50.rw, top: 250.rh, bottom: 50.rh),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            transform: GradientRotation(222 * 3.1415926535 / 180),
                            stops: [0.4409, 0.7504, 0.8799],
                            colors: [
                              Color(0xFFFFFFFF),
                              Color(0xFFFFB7DD),
                              Color(0xFFFFD3B7),
                            ],
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 20.rh),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.rs),
                              child: Image.asset(
                                'assets/images/category-cake.png',
                                width: 430.rw,
                                height: 450.rh,
                                fit: BoxFit.cover,
                              ),
                            ),
                            30.horizontalSpace,
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  transform: GradientRotation(222 * 3.1415926535 / 180),
                                  stops: [0.4409, 0.7504, 0.8799],
                                  colors: [
                                    Color(0xFFFFFFFF),
                                    Color(0xFFFFFFF2),
                                    Color(0xFFFFD3B7),
                                  ],
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 15.rw),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Best Selling  Cake of the Month',
                                    style: TextStyle(
                                      color: Color(0xFFD04A3F),
                                      fontSize: 40.rt,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  10.verticalSpace,
                                  Text(
                                    'RAINBOW RELISH CAKE',
                                    style: TextStyle(
                                      color: Color(0xFFD04A3F),
                                      fontSize: 35.rt,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient : LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        transform: GradientRotation(222 * 3.1415926535 / 180),
                                        stops: [0.4409, 0.7504, 0.8799],
                                        colors: [
                                          Color(0xFFFFFFFF),
                                          Color(0xFFFFFFF2),
                                          Color(0xFFFFD3B7),
                                        ],
                                      )
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '20',
                                          style: TextStyle(
                                            fontSize: 150.rt,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFE56605)
                                          ),
                                        ),
                                        Text(
                                          '% OFF',
                                          style: TextStyle(
                                            fontSize: 80.rt,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFE56605)
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  10.verticalSpace,
                                  Text(
                                    'HURRY UP!',
                                    style: TextStyle(
                                      color: Color(0xFFD47A5C),
                                      fontSize: 50.rt,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                  10.verticalSpace,
                                  Text(
                                    'Limited Time Only.',
                                    style: TextStyle(
                                      color: Color(0xFFD47A5C),
                                      fontSize: 30.rt,
                                      fontWeight: FontWeight.w400
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  )
                ],
              ),
              GridView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 50.rw),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.9,
                ),
                children: [
                  _buildCategoryItem(
                    'assets/images/category(1).png',
                    'CAKES',
                    Color(0xFFFFF1DE),
                    () => Navigator.push(context, MaterialPageRoute(builder: (_) => CakesScreen())),
                  ),
                  _buildCategoryItem(
                    'assets/images/category(2).png',
                    'CUP CAKES',
                    Color(0xFFFFB7DD),
                    () => Navigator.push(context, MaterialPageRoute(builder: (_) => CupCakesScreen())),
                  ),
                  _buildCategoryItem(
                    'assets/images/category(3).png',
                    'WEDDING',
                    Color(0xFFFFB7DD),
                    () => Navigator.push(context, MaterialPageRoute(builder: (_) => WeddingCakesScreen())),
                  ),
                  _buildCategoryItem(
                    'assets/images/category(4).png',
                    'TREATS',
                    Color(0xFFFDEEDB),
                    () => Navigator.push(context, MaterialPageRoute(builder: (_) => TreatsScreen())),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 50.rh),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AccessoriesScreen()
                      )
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 20.rh),
                    decoration: BoxDecoration(
                      color: Color(0xFFE6FFF5),
                      borderRadius: BorderRadius.circular(30.rs),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Image.asset(
                            'assets/images/category(5).png',
                            width: 350.rw,
                            height: 350.rh,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Center(
                            child: Text(
                              'ACCESSORIES',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                                fontSize: 40.rt,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        // bottomNavigationBar: SafeArea(
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: Color(0xFFFFFFFF),
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.black.withOpacity(0.1),
        //           offset: Offset(0, -15),
        //           blurRadius: 40,
        //           spreadRadius: 0,
        //         ),
        //       ],
        //     ),
        //     child: BottomNavigationBar(
        //       currentIndex: _currentIndex,
        //       backgroundColor: Color(0xFFFFFFFF),
        //       type: BottomNavigationBarType.fixed,
        //       selectedItemColor: Color.fromRGBO(238, 41, 56, 0.8),
        //       unselectedItemColor: Color.fromRGBO(0, 0, 0, 0.5),
        //       selectedLabelStyle: TextStyle(
        //         fontSize: 25.rt,
        //         fontWeight: FontWeight.w800,
        //         color: Color.fromRGBO(238, 41, 56, 0.8),
        //       ),
        //       unselectedLabelStyle: TextStyle(
        //         fontSize: 25.rt,
        //         fontWeight: FontWeight.w800,
        //         color: Color.fromRGBO(0, 0, 0, 0.5),
        //       ),
        //       onTap: (index) {
        //         setState(() {
        //           _currentIndex = index;
        //         });
        //         if (index == 0) {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => HomeScreen(),
        //             ),
        //           );
        //         }
        //         if (index == 1) {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => CategoryScreen(),
        //             ),
        //           );
        //         }
        //         if (index == 2) {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => StoreLocation(),
        //             ),
        //           );
        //         }
        //         if (index == 3) {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => CartScreen(),
        //             ),
        //           );
        //         }
        //         if (index == 4) {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => SearchScreen(),
        //             ),
        //           );
        //         }
        //       },
        //       items: [
        //         BottomNavigationBarItem(
        //           icon: SvgPicture.asset(
        //             'assets/images/home.svg',
        //             width: 70.rw,
        //             height: 70.rh,
        //             colorFilter: ColorFilter.mode(_currentIndex == 0 ? Color.fromRGBO(238, 41, 56, 0.8):Color.fromRGBO(0, 0, 0, 0.5),BlendMode.srcIn),
        //           ),
        //           label: 'HOME',
        //         ),
        //         BottomNavigationBarItem(
        //           icon: SvgPicture.asset(
        //             'assets/images/cake.svg',
        //             width: 70.rw,
        //             height: 70.rh,
        //             colorFilter: ColorFilter.mode(_currentIndex == 1 ? Color.fromRGBO(238, 41, 56, 0.8):Color.fromRGBO(0, 0, 0, 0.5),BlendMode.srcIn),
        //           ),
        //           label: 'CAKES',
        //         ),
        //         BottomNavigationBarItem(
        //           icon: SvgPicture.asset(
        //             'assets/images/store.svg',
        //             width: 70.rw,
        //             height: 70.rh,
        //             colorFilter: ColorFilter.mode(_currentIndex == 2 ? Color.fromRGBO(238, 41, 56, 0.8):Color.fromRGBO(0, 0, 0, 0.5),BlendMode.srcIn),
        //           ),
        //           label: 'STORES',
        //         ),
        //         BottomNavigationBarItem(
        //           icon: SvgPicture.asset(
        //             'assets/images/basket.svg',
        //             width: 70.rw,
        //             height: 70.rh,
        //             colorFilter: ColorFilter.mode(_currentIndex == 3 ? Color.fromRGBO(238, 41, 56, 0.8):Color.fromRGBO(0, 0, 0, 0.5),BlendMode.srcIn),
        //           ),
        //           label: 'BASKET',
        //         ),
        //         BottomNavigationBarItem(
        //           icon: SvgPicture.asset(
        //             'assets/images/magnifier.svg',
        //             width: 70.rw,
        //             height: 70.rh,
        //             colorFilter: ColorFilter.mode(_currentIndex == 4 ? Color.fromRGBO(238, 41, 56, 0.8):Color.fromRGBO(0, 0, 0, 0.5),BlendMode.srcIn),
        //           ),
        //           label: 'SEARCH',
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      )
    );
  }
}

Widget _buildCategoryItem(String image, String label, Color bgColor, VoidCallback onTap) {
  return Container(
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(20.rs),
    ),
    padding: EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Image.asset(
              image,
              width: 350.rw,
              height: 350.rh,
              fit: BoxFit.contain
            )
          ),
        ),
        10.verticalSpace,
        Text(
          label,
          style: TextStyle(
            color: Colors.red,
            fontSize: 40.rt,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}