import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/screens/sub_category/sup_sub_category/products/cakes_products.dart';

import '../../provider/short_provider.dart';
import '../account_screen.dart';
import '../search_screen.dart';

class TreatsScreen extends StatefulWidget {
  const TreatsScreen({super.key});

  @override
  State<TreatsScreen> createState() => _TreatsScreenState();
}

class _TreatsScreenState extends State<TreatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _){
      List<Map<String, dynamic>> cake = provider.treats.toList();
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
                            'TREATS',
                            style: TextStyle(
                              color: Color(0xFF283577),
                              fontSize: 67.rt,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
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
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.9,
                          ),
                          itemCount: cake.length,
                          itemBuilder: (context,index){
                            return _buildCakes(cake[index], context, provider);
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

Widget _buildCakes(Map<String, dynamic> cake, BuildContext context, ShortProvider provider){
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
          flex: 3,
          child: GestureDetector(
            onTap: () async {
              final int? categoryId = cake['category_id'];
              print(categoryId);

              if (categoryId != null) {
                provider.fetchCategoryProducts(categoryId, context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CakesProducts(
                        title: cake['title']
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Invalid category ID')),
                );
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.rs),
              child: Image.asset(
                  'assets/images/category(1).png',
                  width: 276.rw,
                  height: 276.rh,
                  fit: BoxFit.cover
              ),
            ),
          ),
        ),
        10.verticalSpace,
        Expanded(
          child: Text(
            cake['title'],
            style: TextStyle(
              color: Color(0xFF283577),
              fontSize: 40.rt,
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.ellipsis
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}