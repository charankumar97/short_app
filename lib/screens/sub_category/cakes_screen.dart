import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/sub_category/sup_sub_category/all_cakes_screen.dart';

import '../account_screen.dart';
import '../search_screen.dart';

class CakesScreen extends StatefulWidget {
  const CakesScreen({super.key});

  @override
  State<CakesScreen> createState() => _CakesScreenState();
}

class _CakesScreenState extends State<CakesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _){
      List<Map<String, dynamic>> cake = provider.cakes.toList();
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox.expand(
                child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.rw,
                        vertical: 50.rh,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 316.rw,
                            height: 130.rh,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100.rs),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(250, 18, 40, 0.15),
                                  offset: Offset(0, 4),
                                  blurRadius: 50,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 10.rh),
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/Vector(1).svg',
                                    width: 59.rw,
                                    height: 59.rh,
                                  ),
                                  15.horizontalSpace,
                                  Text(
                                    'Back',
                                    style: TextStyle(
                                      color: Color(0xFF1E4489),
                                      fontSize: 40.rt,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100.rs),
                                  border: Border.all(color: Colors.white, width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(250, 18, 40, 0.15),
                                      offset: Offset(0, 4),
                                      blurRadius: 50,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SearchScreen(showBackButton: true),
                                      ),
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/images/magnifier.svg',
                                    width: 59.rw,
                                    height: 59.rh,
                                    colorFilter: ColorFilter.mode(Color(0xFFEE2938),BlendMode.srcIn),
                                  ),
                                ),
                              ),
                              30.horizontalSpace,
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFDEDE),
                                  borderRadius: BorderRadius.circular(100.rs),
                                  border: Border.all(color: Color(0xFFFFDEDE), width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(250, 18, 40, 0.15),
                                      offset: Offset(0, 4),
                                      blurRadius: 50,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => AccountScreen()),
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/images/user.svg',
                                    width: 59.rw,
                                    height: 59.rh,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.rh),
                      child: Center(
                        child: Text(
                          'Cakes',
                          style: TextStyle(
                            color: Color(0xFF283577),
                            fontSize: 67.rt,
                            fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 80.rh),
                      child: GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 30.rw),
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.9,
                        ),
                        itemCount: cake.length,
                        itemBuilder: (context,index){
                          return _buildCakes(cake[index], context);
                        },
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget _buildCakes(Map<String, dynamic> cake, BuildContext context){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.rs),
      border: Border.all(
        color: Colors.black12,
        width: 1,
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 15.rw, vertical: 15.rh),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => AllCakesScreen(
                        title: cake['title'],
                        subCategory: cake['sub_category']
                      )
                  )
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.rs),
              child: Image.asset(
                'assets/images/category(1).png',
                width: 350.rw,
                height: 350.rh,
                fit: BoxFit.contain
              ),
            ),
          ),
        ),
        10.verticalSpace,
        Text(
          cake['title'],
          style: TextStyle(
            color: Color(0xFF283577),
            fontSize: 40.rt,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
