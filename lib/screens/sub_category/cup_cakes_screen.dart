import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/screens/sub_category/sup_sub_category/products/product_screen.dart';
import '../../provider/short_provider.dart';
import '../account_screen.dart';
import '../search_screen.dart';

class CupCakesScreen extends StatefulWidget {
  const CupCakesScreen({super.key});

  @override
  State<CupCakesScreen> createState() => _CupCakesScreenState();
}

class _CupCakesScreenState extends State<CupCakesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _){
      List<Map<String, dynamic>> cake = provider.cupCakes.toList();
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
                            'CUP CAKES',
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
                            mainAxisSpacing: 15,
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
    child: GestureDetector(
      onTap: () async {
        final int? id = cake['id'];
        print(id);
        if(id != null){
          provider.fetchCakeSizes(id);
          provider.fetchSponges(id);
          provider.fetchFilling(id);
          provider.fetchDescription(id);
          provider.selectedProduct(cake);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductScreen(),
            ),
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid ID')),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: (){
                final int? id = cake['id'];
                print(id);
                if(id != null){
                  provider.fetchCakeSizes(id);
                  provider.fetchSponges(id);
                  provider.fetchFilling(id);
                  provider.fetchDescription(id);
                  provider.selectedProduct(cake);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductScreen(),
                    ),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Invalid ID')),
                  );
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.rs),
                child: Image.network(
                  cake['image'],
                  width: 400.rw,
                  height: 450.rh,
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
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 20.rh),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'From ',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 36.rt,
                        fontWeight: FontWeight.w400
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '£${cake['final_price']}',
                      style: TextStyle(
                        color: Color(0xFFEE2938),
                        fontSize: 40.rt,
                        fontWeight: FontWeight.w700
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    final int? id = cake['id'];
                    if(id != null){
                      await provider.fetchCakeSizes(id);
                      await provider.fetchSponges(id);
                      await provider.fetchFilling(id);
                      provider.selectedProduct(cake);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductScreen(),
                        ),
                      );
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Invalid ID')),
                      );
                    }
                  },
                  child: Container(
                    width: 40.rw,
                    height: 40.rh,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEF3645),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Color(0xFFFFFFFF),
                        size: 30.rt,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}