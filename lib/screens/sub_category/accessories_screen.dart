import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../provider/short_provider.dart';
import '../account_screen.dart';
import '../search_screen.dart';

class AccessoriesScreen extends StatefulWidget {
  const AccessoriesScreen({super.key});

  @override
  State<AccessoriesScreen> createState() => _AccessoriesScreenState();
}

class _AccessoriesScreenState extends State<AccessoriesScreen> {
  final List<Map<String, dynamic>> categories = [
    {'id': '184', 'title': 'Balloon Weights'},
    {'id': '153', 'title': 'Balloons'},
    {'id': '154', 'title': 'Candles'},
    {'id': '188', 'title': 'Toppers'},
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _) {
      List<Map<String, dynamic>> item = provider.products.toList();
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
                                  border: Border.all(
                                      color: Colors.white, width: 2),
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
                                        builder: (context) => SearchScreen(),
                                      ),
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/images/magnifier.svg',
                                    width: 59.rw,
                                    height: 59.rh,
                                    colorFilter: ColorFilter.mode(
                                        Color(0xFFEE2938), BlendMode.srcIn),
                                  ),
                                ),
                              ),
                              30.horizontalSpace,
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFDEDE),
                                  borderRadius: BorderRadius.circular(100.rs),
                                  border: Border.all(
                                      color: Color(0xFFFFDEDE),
                                      width: 2
                                  ),
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
                      padding: EdgeInsets.symmetric(vertical: 30.rh),
                      child: Center(
                        child: Text(
                          'Accessories',
                          style: TextStyle(
                            color: Color(0xFF283577),
                            fontSize: 67.rt,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.rh),
                      child: SizedBox(
                        height: 100.rh,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 30.rw),
                          itemCount: categories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 20.rw),
                              child: _buildCategory(categories[index], context, provider, index),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 50.rh),
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
                        itemCount: item.length,
                        itemBuilder: (context,index){
                          return _buildAccessories(item[index]);
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

Widget _buildCategory(Map<String, dynamic> category, BuildContext context, ShortProvider provider, int index,) {
  final int categoryId = int.parse(category['id']);
  return Container(
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(100.rs),
      border: Border.all(
        color: Colors.black12,
        width: 1,
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 20.rh),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                provider.fetchProducts(categoryId, context);
              },
              child: Text(
                category['title'],
                style: TextStyle(
                  color: provider.selectedCategoryId == categoryId
                      ? Color(0xFF283577)
                      : Colors.black26,
                  fontSize: 40.rt,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}


Widget _buildAccessories(Map<String, dynamic> item){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.rs),
      border: Border.all(color: Colors.black12, width: 1),
    ),
    padding: EdgeInsets.symmetric(horizontal: 25.rw, vertical: 15.rh),
    child: Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.rs),
              child: Image.network(
                item['image'],
                width: 428.rw,
                height: 426.rh,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        10.verticalSpace,
        Text(
          item['title'],
          style: TextStyle(
            color: Color(0xFF283577),
            fontSize: 40.rt,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        20.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '£${item['final_price']}',
              style: TextStyle(
                color: Color(0xFFEE2938),
                fontSize: 40.rt,
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 200.rw,
                height: 80.rh,
                decoration: BoxDecoration(
                  color: Color(0xFFEE2938),
                  borderRadius: BorderRadius.circular(20.rs),
                  border: Border.all(
                    color: Color(0xFFEE2938),
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 18.rh),
                child: Text(
                  'ADD',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 36.rt,
                    fontWeight: FontWeight.w400
                  ),
                  textAlign: TextAlign.center,
                )
              ),
            ),
          ],
        ),
      ],
    ),
  );
}