import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../models/person_model.dart';
import '../models/product_model.dart';
import '../provider/short_provider.dart';

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({super.key});

  @override
  State<OrderConfirmationScreen> createState() => _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider,_){
      List<Person> user = provider.users.toList();
      final List<Product> cartProduct = provider.cartProducts.toList();
      return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFEFFFEA),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 50.rh),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      'assets/images/Group 351.svg',
                      width: 115.rw,
                      height: 115.rh,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                50.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 280.193.rw,
                      height: 260.193.rh,
                      decoration: BoxDecoration(
                        color: Color(0xFF00CD6B),
                        borderRadius: BorderRadius.circular(260.193.rs),
                      ),
                      child: SvgPicture.asset(
                        'assets/images/check.svg',
                        width: 138.rw,
                        height: 138.rh,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                50.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100.rw),
                  child: Center(
                    child: Text(
                      'Order placed successfully \n by ${user[0].firstName}',
                      style: TextStyle(
                        color: Color(0xFF05904D),
                        fontSize: 50.rw,
                        fontWeight: FontWeight.w700
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                50.verticalSpace,
                Center(
                  child: Container(
                    width: 612.rw,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(20.rs),
                      border: Border.all(
                        color: Color(0xFF141414),
                        width: 3.rw,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30.rw),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ORDER ID',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 30.rt,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 100.rh,
                          color: Color(0xFF000000),
                          margin: EdgeInsets.symmetric(horizontal: 20.rw), // spacing on both sides
                        ),
                        Text(
                          '#12458563',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 49.rt,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                50.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100.rw),
                  child: Center(
                    child: Text(
                      'Collect at ${provider.selectedStoreTitle['title']} Store on ${provider.date} | ${provider.selectedTime}',
                      style: TextStyle(
                        color: Color(0xFF000000),
                          fontSize: 38.rw,
                          fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                50.verticalSpace,
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartProduct.length,
                    itemBuilder: (context, index){
                      final item = cartProduct[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.rw),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.rs),
                              child: Center(
                                child: Image.network(
                                  item.image,
                                  width: 100.rw,
                                  height: 100.rh,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                ),
                150.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rh),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(20.rs),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rh),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'ORDER ID',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 40.rt,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            5.horizontalSpace,
                            Text(
                              '#12458563',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 40.rt,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                        30.verticalSpace,
                        Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cartProduct.length,
                            itemBuilder: (context, index){
                              final item = cartProduct[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50.rw),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${item.qty} x ',
                                          style: TextStyle(
                                            color: Color(0xFF878787),
                                            fontSize: 36.rt,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        Text(
                                          item.title,
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 36.rt,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rh),
                  child: Container(
                    height: 130.rh,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(20.rs),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rh),
                    child: GestureDetector(
                      onTap: (){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Call to Store',
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 40.rt,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/images/call.svg',
                            width: 50.rw,
                            height: 50.rh,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rh),
                  child: Container(
                    height: 130.rh,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(20.rs),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rh),
                    child: GestureDetector(
                      onTap: (){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Store Location',
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 40.rt,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/images/Vector.svg',
                            width: 50.rw,
                            height: 50.rh,
                            fit: BoxFit.cover,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      );
    });
  }
}
