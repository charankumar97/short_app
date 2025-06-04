import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/models/product_model.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/deliveryscreen/address_screen.dart';
import 'package:short_app/screens/deliveryscreen/delivery_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool _isExpanded = true;
  bool _isExpands = true;
  bool _isExpand = true;
  bool _isExpan = true;
  int _selectedMethod = 0;

  final List<String> paymentOptions = ['PayPal Payment','Credit/Debit Card', 'Klarna Pay in 30 days'];
  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider,_){
      final List<Product> cartProduct = provider.cartProducts.toList();
      return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFDBE5FF),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF0C1788),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
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
                              'assets/images/Vector(2).svg',
                              width: 59.rw,
                              height: 59.rh,
                            ),
                            label: Text(
                              'Back',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 40.rt,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'CHECKOUT',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80.rw, vertical: 50.rh),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ORDER DETAILS',
                              style: TextStyle(
                                color: Color(0xFF0B1156),
                                fontSize: 40.rt,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              _isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                              size: 60.rw,
                              color: Color(0xFF000000),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_isExpanded)...[
                      Padding(
                        padding: EdgeInsets.only(left: 60.rw, right: 60.rw, top: 10.rh, bottom: 30.rh),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.rs),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 50.rh),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Pickup Store',
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 30.rt,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                        10.verticalSpace,
                                        Text(
                                          '',
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 32.rt,
                                            fontWeight: FontWeight.w400
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  IconButton(
                                    onPressed: (){},
                                    icon: Icon(
                                      Icons.edit,
                                      size: 42.rw,
                                      color: Color(0xFF000000),
                                    )
                                  )
                                ],
                              ),
                              10.verticalSpace,
                              Divider(height: 1, thickness: 1, color: Color(0xFFB8B8B8),),
                              10.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'DELIVERY ON',
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 30.rt,
                                            fontWeight: FontWeight.w400
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          provider.date,
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 40.rt,
                                            fontWeight: FontWeight.w700
                                          ),
                                        ),
                                        10.verticalSpace,
                                        Text(
                                          provider.time,
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 40.rt,
                                            fontWeight: FontWeight.w700
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Delivery1Screen(postCode: '',),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      size: 42.rw,
                                      color: Color(0xFF000000),
                                    )
                                  )
                                ],
                              ),
                              10.verticalSpace,
                              Divider(height: 1, thickness: 1, color: Color(0xFFB8B8B8),),
                              10.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ORDER BY',
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 30.rt,
                                            fontWeight: FontWeight.w400
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  Expanded(
                                    flex: 5,
                                      child: provider.address.isNotEmpty
                                          ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${provider.address[0]['first_name']} ${provider.address[0]['last_name']}',
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 36.rt,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          10.verticalSpace,
                                          Text(
                                            provider.address[0]['email'],
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 36.rt,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          10.verticalSpace,
                                          Text(
                                            provider.address[0]['contact_number'],
                                            style: TextStyle(
                                              color: Color(0xFF000000),
                                              fontSize: 36.rt,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )
                                          :Container()
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      // final int addressId = provider.address[0]['id'];
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AddressScreen(address: provider.address[0]),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      size: 42.rw,
                                      color: Color(0xFF000000),
                                    )
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 60.rw, right: 60.rw, top: 10.rh, bottom: 30.rh),
                        child: Container(
                          width: 986.rw,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.rs),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 50.rh),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Changed your plan?',
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 46.rt,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              10.verticalSpace,
                              Text(
                                'We can delivery to “${provider.address[0]['postcode']}” postcode.',
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 40.rt,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                              30.verticalSpace,
                              GestureDetector(
                                onTap: (){},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.rs),
                                    border: Border.all(
                                      color: Colors.black26,
                                      width: 1,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
                                  child: Text(
                                    'ADD DELIVERY ADDRESS',
                                    style: TextStyle(
                                      color: Color(0xFF2D46C1),
                                      fontSize: 36.rt,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
                30.verticalSpace,
                Divider(height: 1,thickness: 0,color: Color.fromRGBO(11, 17, 86, 0.4)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80.rw, vertical: 50.rh),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpands = !_isExpands;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'YOUR CART',
                                  style: TextStyle(
                                    color: Color(0xFF0B1156),
                                    fontSize: 40.rt,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                20.horizontalSpace,
                                Text(
                                  '(${provider.cartItemCount.toString()}) items',
                                  style: TextStyle(
                                    color: Color(0xFF0B1156),
                                    fontSize: 40.rt,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            _isExpands
                                ? Icon(
                              Icons.arrow_drop_down,
                              size: 60.rw,
                              color: Color(0xFF000000),
                            )
                                : Row(
                              children: [
                                Image.network(
                                  provider.cartProducts[0].image,
                                  width: 60.rw,
                                  height: 60.rh,
                                  fit: BoxFit.cover,
                                ),
                                10.horizontalSpace,
                                Icon(
                                  Icons.arrow_right,
                                  size: 60.rw,
                                  color: Color(0xFF000000),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_isExpands)...[
                      Padding(
                        padding: EdgeInsets.only(left: 60.rw, right: 60.rw, top: 10.rh, bottom: 30.rh),
                        child: Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cartProduct.length,
                            itemBuilder: (context, index){
                              return _buildItems(cartProduct[index], provider);
                            }
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
                30.verticalSpace,
                Divider(height: 1,thickness: 0,color: Color.fromRGBO(11, 17, 86, 0.4)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80.rw, vertical: 50.rh),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpand = !_isExpand;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ORDER SUMMARY',
                              style: TextStyle(
                                color: Color(0xFF0B1156),
                                fontSize: 40.rt,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              _isExpand ? Icons.arrow_drop_down : Icons.arrow_right,
                              size: 60.rw,
                              color: Color(0xFF000000),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_isExpand)...[
                      Padding(
                        padding: EdgeInsets.only(left: 60.rw, right: 60.rw, top: 10.rh, bottom: 30.rh),
                        child: Container(
                          height: 100.rh,
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                                  'Apply promo code',
                                  style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 36.rt,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  size: 60.rw,
                                  color: Color(0xFFA2A2A2),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 60.rw, right: 60.rw, top: 10.rh, bottom: 30.rh),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Cart Total',
                                    style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 36.rt,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  Text(
                                    '£${provider.totalAmount.toString()}',
                                    style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 36.rt,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                              30.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Packaging fee',
                                    style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 36.rt,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  Text(
                                    '£${provider.packagingFee.toString()}',
                                    style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 36.rt,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                              30.verticalSpace,
                              Divider(height: 1,thickness: 1,color: Color(0xFFCDCDCD)),
                              30.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Grand Total',
                                    style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 36.rt,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  Text(
                                    '£${provider.grandTotal.toString()}',
                                    style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 36.rt,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                              20.verticalSpace,
                            ],
                          ),
                        ),
                      )
                    ]
                  ],
                ),
                30.verticalSpace,
                Divider(height: 1,thickness: 0,color: Color.fromRGBO(11, 17, 86, 0.4)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80.rw, vertical: 50.rh),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpan = !_isExpan;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'PAYMENT',
                              style: TextStyle(
                                color: Color(0xFF0B1156),
                                fontSize: 40.rt,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              _isExpan ? Icons.arrow_drop_down : Icons.arrow_right,
                              size: 60.rw,
                              color: Color(0xFF000000),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_isExpan)...[
                      Padding(
                        padding: EdgeInsets.only(left: 60.rw, right: 60.rw, top: 10.rh, bottom: 30.rh),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.rs),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black.withOpacity(0.08),
                            //     offset: Offset(0, 4),
                            //     blurRadius: 4,
                            //   ),
                            // ],
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rh),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: paymentOptions.length,
                            separatorBuilder: (context, index) => 10.verticalSpace,
                            itemBuilder: (context, index)=> Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.rs),
                              ),
                              child: RadioListTile<int>(
                                value: index,
                                groupValue: _selectedMethod,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedMethod = value!;
                                  });
                                },
                                title: Text(
                                  paymentOptions[index],
                                  style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 36.rt,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12.rw),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
                30.verticalSpace,
                Divider(height: 1,thickness: 0,color: Color.fromRGBO(11, 17, 86, 0.4)),
                Padding(
                  padding: EdgeInsets.only(left: 60.rw, right: 60.rw, top: 50.rh, bottom: 50.rh),
                  child: GestureDetector(
                    onTap: (){},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30.rs),
                        border: Border.all(
                          color: Color(0xFF565656),
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 30.rh),
                      child: Center(
                        child: Text(
                          'PROCEED TO PAYMENT',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w500
                          ),
                        ),
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

Widget _buildItems(Product cartProduct, ShortProvider provider){
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFDBE5FF),
          Color(0xFFDBE5FF),
        ],
        stops: [0.3396, 0.7651],
      ),
    ),
    padding: EdgeInsets.only(left: 45.rw, top: 5.rh, right: 45.rw, bottom: 10.rh),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.rs),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      cartProduct.image,
                      width: 100.rw,
                      height: 100.rh,
                      fit: BoxFit.contain,
                    ),
                  ),
                  30.horizontalSpace,
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartProduct.title,
                          style: TextStyle(
                            color: Color(0xFF1E4489),
                            fontWeight: FontWeight.w600,
                            fontSize: 40.rt,
                          ),
                        ),
                        13.verticalSpace,
                        Row(
                          children: [
                            Text(
                              '${cartProduct.qty} x £${cartProduct.finalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Color(0xFF7F7F7F),
                                fontWeight: FontWeight.w500,
                                fontSize: 32.rt,
                              ),
                            ),
                            8.horizontalSpace,
                            Text(
                              '|',
                              style: TextStyle(
                                color: Color(0xFF7F7F7F),
                                fontWeight: FontWeight.w500,
                                fontSize: 32.rt,
                              ),
                            ),
                            8.horizontalSpace,
                            Text(
                              'SKU: ${cartProduct.sku}',
                              style: TextStyle(
                                color: Color(0xFF7F7F7F),
                                fontWeight: FontWeight.w500,
                                fontSize: 32.rt,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  30.horizontalSpace,
                  Expanded(
                    flex: 2,
                    child: Text(
                      '£${cartProduct.total}',
                      style: TextStyle(
                        color: Color(0xFFEE2938),
                        fontWeight: FontWeight.w700,
                        fontSize: 40.rt,
                      ),
                    ),
                  )
                ],
              ),
              10.verticalSpace,
              provider.isCakeProduct(cartProduct)
                  ?Container(
                width: 930.rw,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.rs),
                  border: Border.all(
                    color: Color(0xFFB6B6B6),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 20.rh),
                      child: Text(
                        '${provider.sizeTitle} . ${provider.spongTitle} . ${provider.fillTitle} .',
                        style: TextStyle(
                          color: Color(0xFF283577),
                          fontSize: 32.rt,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    10.verticalSpace,
                    Divider(
                      height : 1,
                      thickness: 0,
                      color: Color(0xFFB6B6B6),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 20.rh),
                      child: Text(
                        provider.message,
                        style: TextStyle(
                          color: Color(0xFF283577),
                          fontSize: 30.rt,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ): const SizedBox.shrink(),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      provider.deleteCartProduct(cartProduct.sku);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.rs),
                        border: Border.all(
                          color: Color(0xFFCDCDCD),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 30.rh),
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              size: 60.rw,
                              color: Color(0xFFD41F36),
                            ),
                            30.horizontalSpace,
                            Text(
                              'DELETE',
                              style: TextStyle(
                                color: Color(0xFFD41F36),
                                fontWeight: FontWeight.w500,
                                fontSize: 30.rt
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.rs),
                      border: Border.all(
                        color: Color(0xFFCDCDCD),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.rw),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              provider.decrementProduct(cartProduct);
                            },
                            icon: Icon(
                              Icons.remove,
                              size: 50.rt,
                              color: Color(0xFFEE2938),
                            ),
                          ),
                          30.horizontalSpace,
                          Text(
                            cartProduct.qty.toString(),
                            style: const TextStyle(color: Colors.black),
                          ),
                          30.horizontalSpace,
                          IconButton(
                            onPressed: () {
                              provider.incrementProduct(cartProduct);
                            },
                            icon: Icon(
                              Icons.add,
                              size: 50.rw,
                              color: Color(0xFFEE2938),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}