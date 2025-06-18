import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/sub_category/sup_sub_category/products/product_screen.dart';

class EmptyCartScreen extends StatefulWidget {
  const EmptyCartScreen({super.key});

  @override
  State<EmptyCartScreen> createState() => _EmptyCartScreenState();
}

class _EmptyCartScreenState extends State<EmptyCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context,provider,_){
      List<Map<String, dynamic>> bestSeller = provider.bestSellers.toList();
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF283277),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 40.rh),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: Text(
                          'CART',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 150.rh),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/Group 762.svg',
                        width: 263.rw,
                        height: 273.915.rh,
                        fit: BoxFit.cover,
                      ),
                      50.verticalSpace,
                      Text(
                        'CART IS EMPTY',
                        style: TextStyle(
                          color: Color(0xFFEF4343),
                          fontSize: 60.rt,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 50.rh),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFDBE5FF),
                      borderRadius: BorderRadius.circular(20.rs),
                      border: Border.all(
                        color: Color(0xFFEEDEBC),
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 50.rh),
                    child: Column(
                      children: [
                        Text(
                          'TRY OUR BEST SELLING IRRESISTIBLE CAKES',
                          style: TextStyle(
                            color: Color(0xFF1E4489),
                            fontSize: 60.rt,
                            fontWeight: FontWeight.w700
                          ),
                          textAlign: TextAlign.center,
                        ),
                        30.verticalSpace,
                        SvgPicture.asset(
                          'assets/images/34.svg',
                          width: 127.rw,
                          height: 119.rh,
                          fit: BoxFit.contain,
                        ),
                        30.verticalSpace,
                        SizedBox(
                          // height: 650.rh,
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
                )
              ],
            ),
          ),
        )
      );
    });
  }
}

Widget _buildItem(Map<String, dynamic> bestSeller, ShortProvider provider, BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 20.rh),
    child: Container(
      width: 490.rw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.rs),
        color: Color(0xFFFFFFFF),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 25.rw, vertical: 25.rh),
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
                  width: 440.rw,
                  height: 440.rh,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            20.verticalSpace,
            Text(
              bestSeller['title'],
              style: TextStyle(
                color: Color(0xFF1E4489),
                fontSize: 34.rt,
                fontWeight: FontWeight.w600
              ),
              textAlign: TextAlign.start,
            ),
            10.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '£${bestSeller['final_price']}',
                  style: TextStyle(
                    color: Color(0xFFEE2938),
                    fontSize: 30.rt,
                    fontWeight: FontWeight.w600
                  ),
                ),
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