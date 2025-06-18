import 'dart:convert';

import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../provider/short_provider.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({super.key});

  @override
  State<CouponsScreen> createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {


  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _){
      List<Map<String, dynamic>> coupon = provider.allCoupons.toList();
      // print(coupon);
      return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(100.rs),
                            border: Border.all(color: Colors.transparent, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(250, 18, 40, 0.15),
                                offset: Offset(0, 4),
                                blurRadius: 50,
                              ),
                            ],
                          ),
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: SvgPicture.asset(
                              'assets/images/Vector(1).svg',
                              width: 59.rw,
                              height: 59.rh,
                            ),
                            label: Text(
                              'Back',
                              style: TextStyle(
                                color: Color(0xFF0B1156),
                                fontSize: 40.rt,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'COUPONS',
                          style: TextStyle(
                            color: Color(0xFF0B1156),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1,thickness: 1, color: Color(0xFFBBBBBB)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rh),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: coupon.length,
                    itemBuilder: (context, index){
                      return _buildCoupons(coupon[index],provider, context);
                    },
                  ),
                ),
                Divider(height: 1,thickness: 1, color: Color(0xFFBBBBBB)),
              ],
            ),
          ),
        )
      );
    });
  }
}

Widget _buildCoupons(Map<String, dynamic> coupon, ShortProvider provider, BuildContext context, ){
  Future<void> applyCoupon() async{
    final payload = {
      "user_id":provider.users[0].id,
      "coupon_code": '${coupon['coupon']}',
      "total_amount": provider.totalAmount.toStringAsFixed(2),
    };
    print(payload);
    final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
    try {
      final response = await http.post(
        Uri.parse('https://www.staging.cakesandbakes.net/api/apply-coupon'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (!context.mounted) return;

      final jsonResponse = json.decode(response.body);

      final message = jsonResponse['message'] ?? 'Something happened';

      if (response.statusCode == 200 && jsonResponse['success'] == true) {
        scaffoldMessenger?.showSnackBar(SnackBar(content: Text(message)));
      } else {
        scaffoldMessenger?.showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (e) {
      if (!context.mounted) return;
      scaffoldMessenger?.showSnackBar(
        SnackBar(content: Text('Something went wrong: $e')),
      );
    }
  }
  
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 50.rh),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flat £${coupon['discount']} OFF',
            style: TextStyle(
              color: Color(0xFF283577),
              fontSize: 50.rt,
              fontWeight: FontWeight.w500
            ),
          ),
          20.verticalSpace,
          Text(
            'On all orders above £${coupon['min_amount']}',
            style: TextStyle(
              color: Color(0xFF595959),
              fontSize: 36.rt,
              fontWeight: FontWeight.w600
            ),
          ),
          20.verticalSpace,
          Container(
            height: 130.rh,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFFEE2938),
                  Color(0xFF283277),
                ],
                stops: [0.0213, 0.3916],
              ),
              borderRadius: BorderRadius.circular(20.rs),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rh),
            child: GestureDetector(
              onTap: () async {
                await applyCoupon();
                if (context.mounted) {
                  provider.selectCoupon(coupon);
                  Navigator.pop(context);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    coupon['coupon'],
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 46.rt,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  Text(
                    'Apply',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 40.rt,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
            )
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Expires on ${coupon['end_date']}',
                style: TextStyle(
                  color: Color(0xFF595959),
                  fontSize: 36.rt,
                  fontWeight: FontWeight.w500
                ),
              ),
              Row(
                children: [
                  Text(
                    'More',
                    style: TextStyle(
                      color: Color(0xFF595959),
                      fontSize: 36.rt,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down, size: 60.rw, color: Color(0xFF595959),)
                ],
              ),
            ],
          ),
          30.verticalSpace,
        ],
      ),
    ),
  );
}