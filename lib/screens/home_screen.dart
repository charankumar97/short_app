import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/account_screen.dart';
import 'package:short_app/screens/contactus_screen.dart';
import 'package:short_app/screens/search_screen.dart';
import 'package:short_app/screens/sub_category/sup_sub_category/products/cakes_products.dart';
import 'package:short_app/screens/sub_category/sup_sub_category/products/product_screen.dart';
import 'franchise_enquiry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  final List<String> imageList = ['assets/images/Floral_Cake.png'];
  String getFirstAndLastLetters(String input) {
    if (input.trim().isEmpty) {
      return '';
    }
    String firstLetter = input[0].toUpperCase();
    String lastLetter = input[input.length - 1].toUpperCase();
    return '$firstLetter$lastLetter';
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ShortProvider>(context, listen: false).fetchBestSellers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(
      builder: (context, provider, _) {
        List<Map<String, dynamic>> bestSeller = provider.bestSellers.toList();
        List<Map<String, dynamic>> location = provider.stores.toList();
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xFFFFFFFF),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          CarouselSlider(
                            items: imageList.map((item) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset(item, fit: BoxFit.cover),
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: 1510.rh,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _index = index;
                                });
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: imageList.asMap().entries.map((entry) {
                              return Container(
                                width: 12.rw,
                                height: 12.rh,
                                margin: EdgeInsets.symmetric(horizontal: 4.rw),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                  _index == entry.key ? Colors.white : Colors.grey,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Positioned(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.rw,
                            vertical: 20.rh,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
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
                                        contentPadding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
                                        hintText: 'Search delicious cakes',
                                        hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 40.rt,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        suffixIcon: Icon(
                                          Icons.search,
                                          color: Color(0xFFDC2328),
                                        ),
                                        fillColor: Colors.transparent,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(60.rs),
                                          borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.white.withOpacity(0.2),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              30.horizontalSpace,
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFDEDE),
                                  borderRadius: BorderRadius.circular(100.rs),
                                  border: Border.all(
                                      color: Color(0xFFFFDEDE), width: 2
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
                        ),
                      ),
                    ],
                  ),
                  15.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.rw),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'BEST SELLING CAKES',
                              style: TextStyle(
                                color: Color(0xFFDC2328),
                                fontSize: 40.rt,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                final int categoryId = 157;
                                provider.fetchCategoryProducts(categoryId, context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CakesProducts(title: 'BEST SELLING CAKES'),
                                  ),
                                );
                              },
                              icon: Text(
                                'SEE ALL',
                                style: TextStyle(
                                  color: Color.fromRGBO(36, 14, 19, 0.60),
                                  fontSize: 30.rt,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        8.verticalSpace,
                        bestSeller.isEmpty
                        ?SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Oops!',
                                style: TextStyle(
                                  fontSize: 80.rt,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF000000)
                                ),
                              ),
                              20.verticalSpace,
                              Text(
                                'No products found',
                                style: TextStyle(
                                  fontSize: 48.rt,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF000000)
                                ),
                              )
                            ],
                          ),
                        )
                        : SizedBox(
                          height: 550.rh,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: bestSeller.length,
                            itemBuilder: (context, index) {
                              return _buildItem(
                                bestSeller[index],
                                provider,
                                context,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  15.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.rw),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'SAME DAY DELIVERY CAKES',
                              style: TextStyle(
                                color: Color(0xFFDC2328),
                                fontSize: 40.rt,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                final int categoryId = 157;
                                provider.fetchCategoryProducts(categoryId, context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CakesProducts(title: 'SAME DAY DELIVERY CAKES'),
                                  ),
                                );
                              },
                              icon: Text(
                                'SEE ALL',
                                style: TextStyle(
                                  color: Color.fromRGBO(36, 14, 19, 0.60),
                                  fontSize: 30.rt,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        8.verticalSpace,
                        bestSeller.isEmpty
                            ?SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Oops!',
                                style: TextStyle(
                                  fontSize: 80.rt,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF000000)
                                ),
                              ),
                              20.verticalSpace,
                              Text(
                                'No products found',
                                style: TextStyle(
                                  fontSize: 48.rt,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF000000)
                                ),
                              )
                            ],
                          ),
                        )
                            : SizedBox(
                          height: 550.rh,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: bestSeller.length,
                            itemBuilder: (context, index) {
                              return _buildItem(
                                bestSeller[index],
                                provider,
                                context,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  15.verticalSpace,
                  Container(
                    padding: EdgeInsets.only(left: 50.rw, top: 50.rh, right: 50.rw, bottom: 100.rh),
                    color: Color(0xFFF9F9F9),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.rs),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFFFE9CD),
                                Color(0xFFFFD59F),
                              ],
                              stops: [0.0305, 1.0],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 65.rw, top: 50.rh, bottom: 50.rh),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'FRANCHISES',
                                  style: TextStyle(
                                    color: Color(0xFF1E4489),
                                    fontSize: 60.rt,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                                20.verticalSpace,
                                Text(
                                  'We are One of the UK’s Fastest',
                                  style: TextStyle(
                                    color: Color(0xFF1E4489),
                                    fontSize: 40.rt,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                10.verticalSpace,
                                Text(
                                  'Growing Cake Brands!',
                                  style: TextStyle(
                                    color: Color(0xFF1E4489),
                                    fontSize: 40.rt,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                30.verticalSpace,
                                Padding(
                                  padding: EdgeInsets.only(right: 50.rw),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => FranchiseEnquiry(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.rs),
                                            color: Color(0xFFDC2328),
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 40.rw, vertical: 30.rh),
                                          child: Text(
                                            'JOIN WITH US',
                                            style: TextStyle(
                                              color: Color(0xFFFFFFFF),
                                              fontSize: 34.rt,
                                              fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){},
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.rs),
                                            color: Color(0xFFFFFFFF),
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 40.rw, vertical: 30.rh),
                                          child: Text(
                                            'DOWNLOAD PROSPECTUS',
                                            style: TextStyle(
                                              color: Color(0xFFDC2328),
                                              fontSize: 34.rt,
                                              fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                50.verticalSpace,
                                Text(
                                  'COUNTING 20+ STORES',
                                  style: TextStyle(
                                    color: Color(0xFF1E4489),
                                    fontSize: 36.rt,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                30.verticalSpace,
                                location.isEmpty
                                ? SizedBox.shrink()
                                : Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.rw),
                                  child: SizedBox(
                                    height: 430.rh,
                                    child: ListView.builder(
                                      // padding: EdgeInsets.symmetric(horizontal: 15.rw),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: location.length,
                                      itemBuilder: (context, index) {
                                        return _buildLocation(
                                          location[index],
                                          context,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        50.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.rs),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              transform: GradientRotation(252 * 3.1415926535 / 180),
                              colors: [
                                Color(0xFF88DDFF),
                                Color(0xFFCEEFFF),
                              ],
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.06),
                                blurRadius: 20,
                                spreadRadius: 2,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 65.rw, top: 50.rh, bottom: 50.rh),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'CONTACT US FOR',
                                      style: TextStyle(
                                        color: Color(0xFF1E4489),
                                        fontSize: 60.rt,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    10.verticalSpace,
                                    Text(
                                      'ALL ENQUIRIES',
                                      style: TextStyle(
                                        color: Color(0xFF1E4489),
                                        fontSize: 60.rt,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    20.verticalSpace,
                                    Text(
                                      'Our friendly team will be\n delighted to help you.',
                                      style: TextStyle(
                                        color: Color(0xFF1E4489),
                                        fontSize: 40.rt,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    50.verticalSpace,
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ContactusScreen(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20.rs),
                                          color: Color(0xFFFFFFFF),
                                        ),
                                        padding: EdgeInsets.symmetric(horizontal: 40.rw, vertical: 30.rh),
                                        child: Text(
                                          'KNOW MORE',
                                          style: TextStyle(
                                            color: Color(0xFFDC2328),
                                            fontSize: 34.rt,
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        Container(
                                          width: 388.rw,
                                          height: 287.rh,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFFE0F7FF),
                                          ),
                                        ),
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(20.rs),
                                          child: Image.asset(
                                            'assets/images/category.png',
                                            width: 371.rw,
                                            height: 280.rh,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildItem(Map<String, dynamic> bestSeller, ShortProvider provider, BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.rw,),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.rs),
        color: Color(0xFFFFFFFF),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: GestureDetector(
        onTap: () async {
          final int? id = bestSeller['id'];
          print(id);
          if(id != null){
            provider.fetchCakeSizes(id);
             provider.fetchSponges(id);
            provider.fetchFilling(id);
            provider.fetchDescription(id);
            provider.selectedProduct(bestSeller);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.rs),
              child: Center(
                child: Image.network(
                  bestSeller['image'],
                  width: 400.rw,
                  height: 400.rh,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            10.verticalSpace,
            Text(
              bestSeller['title'],
              style: TextStyle(
                color: Color(0xFF1E4489),
                fontSize: 35.rt,
                fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.start,
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '£${bestSeller['final_price']}',
                  style: TextStyle(
                    color: Color(0xFFEE2938),
                    fontSize: 36.rt,
                    fontWeight: FontWeight.w500
                  ),
                ),
                200.horizontalSpace,
                Container(
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
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget _buildLocation(Map<String, dynamic> location, BuildContext context){
  return Container(
    width: 375.rw,
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(30.rs),
      border: Border.all(
        color: Color(0xFFDDDDDD),
        width: 1,
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 20.rh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.rs),
            child: Image.asset(
              'assets/images/image.jpg',
              width: 300.rw,
              height: 228.495.rh,
              fit: BoxFit.cover,
            ),
          ),
          10.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  location['title'],
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 32.rt,
                    fontWeight: FontWeight.w500
                  ),
                )
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: (){},
                  child: SvgPicture.asset(
                    'assets/images/Vector.svg',
                    width: 50.rw,
                    height: 50.rh,
                  ),
                )
              ),
            ],
          )
        ],
      ),
    ),
  );
}