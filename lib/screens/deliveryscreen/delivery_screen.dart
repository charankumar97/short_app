import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/check_out_screen.dart';
import 'package:short_app/screens/deliveryscreen/address_screen.dart';
import 'package:short_app/screens/deliveryscreen/delivery_address.dart';

class Delivery1Screen extends StatefulWidget {
  final String postCode;


  const Delivery1Screen({super.key, required this.postCode,});

  @override
  State<Delivery1Screen> createState() => _Delivery1ScreenState();
}

class _Delivery1ScreenState extends State<Delivery1Screen> {
  final TextEditingController _dateController = TextEditingController();
  String? selectedItem;
  bool isSelected = false;
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider,_){
      List<Map<String, dynamic>> day = provider.delivery.toList();
      List<Map<String, dynamic>> address = provider.showAddress.toList();
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
                          'DELIVERY',
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
                Padding(
                  padding: EdgeInsets.only(left: 50.rw, right: 50.rw, top: 80.rh, bottom: 10.rh),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.rs),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/postal-code.svg',
                          width: 60.rw,
                          height: 60.rh,
                          fit: BoxFit.contain,
                        ),
                        20.horizontalSpace,
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 40.rt,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000),
                              ),
                              children: [
                                TextSpan(text: 'Delivery to '),
                                TextSpan(
                                  text: '"${widget.postCode}"',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Change',
                            style: TextStyle(
                              color: Color(0xFF2D46C1),
                              fontSize: 40.rt,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 30.rh),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.rs),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 50.rh),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deliver Date & Time',
                          style: TextStyle(
                            fontSize: 36.rt,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000)
                          ),
                        ),
                        30.verticalSpace,
                        Container(
                          height: 120.rh,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.rs),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 6.rh),
                          child: TextField(
                            controller: _dateController,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 38.rt,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Date',
                              suffixIcon: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: SvgPicture.asset(
                                  'assets/images/date.svg',
                                  width: 60.rw,
                                  height: 60.rh,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              hintStyle: TextStyle(
                                fontSize: 38.rt,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            onTap: () async {
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.tryParse(_dateController.text) ?? DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 100),
                                lastDate: DateTime(DateTime.now().year + 100),
                              );
                              if (selectedDate != null) {
                                final formatted = DateFormat('dd MMM yyyy').format(selectedDate);
                                _dateController.text = formatted;
                                final String date = formatted;
                                provider.selectedDate(date);
                              }
                            },
                          ),
                        ),
                        30.verticalSpace,
                        Container(
                          height: 120.rh,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.rs),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 6.rh),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: Text(
                              'Choose Time',
                              style: TextStyle(
                                fontSize: 38.rt,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF000000),
                                decoration: TextDecoration.none,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 38.rt,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF000000),
                              decoration: TextDecoration.none,
                            ),
                            icon: Icon(Icons.keyboard_arrow_down_outlined, color: Color(0xFF000000), size: 50.rw),
                            value: selectedItem,
                            items: day.map((slot) {
                              final String title = slot['title'];
                              return DropdownMenuItem<String>(
                                value: title,
                                child: Text(
                                  title,
                                  style: TextStyle(decoration: TextDecoration.none),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedItem = newValue;
                                });
                                provider.selectDeliveryTime(newValue);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 30.rh),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.rs),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rh),
                    child: address.isNotEmpty
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery to',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 36.rt,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        20.verticalSpace,
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.rs),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 6.rh),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: isSelected,
                                onChanged: (val) {
                                  setState(() {
                                    isSelected = val ?? false;
                                  });

                                  if (isSelected) {
                                    if (address.isNotEmpty) {
                                      provider.selectedAddress(address[0]);
                                    }
                                    // provider.selectedAddress(address);
                                  }
                                },
                              ),
                              20.horizontalSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${address[0]["address_line1"]},',
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 38.rt,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    10.verticalSpace,
                                    Text(
                                      '${address[0]['city']},${address[0]['state']},${address[0]['country']},${address[0]['postcode']}',
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 38.rt,
                                        fontWeight: FontWeight.w500
                                      ),
                                    )
                                  ],
                                )
                              ),
                              20.horizontalSpace,
                              GestureDetector(
                                onTap: (){
                                  // final int addressId = provider.address[0]['id'];
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AddressScreen(address: address[0],),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Edit',
                                  style: TextStyle(
                                    color: Color(0xFF2D46C1),
                                    fontSize: 36.rt,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        20.verticalSpace,
                        Center(
                          child: GestureDetector(
                            onTap: (){
                              double screenWidth = MediaQuery.of(context).size.width;
                              if (screenWidth > 800) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DeliveryAddress(),
                                  ),
                                );
                              } else {
                                _showBottomSheet(context);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.rs),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
                              child: Text(
                                '+ Change Delivry Address'
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                        : GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddressScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rh),
                        child: Center(
                          child: Text(
                            '+ Add Address',
                            style: TextStyle(
                              color: Color(0xFF2D46C1),
                              fontSize: 36.rt,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20),
                  child: Row(
                    children: [
                      Checkbox(
                        value: selected,
                        checkColor: Color(0xFFEF3645),
                        onChanged: (val) {
                          setState(() {
                            selected = val ?? false;
                          });
                        },
                      ),
                      30.horizontalSpace,
                      Text(
                        'Billing Address is same as Delivery Address',
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 38.rt,
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  ),
                ),
                200.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 30.rh),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20.rs),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 10.rh),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CheckOutScreen(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 30.rh),
                            child: Text(
                              'PROCEED TO CHECKOUT',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
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
              ],
            )
          ),
        )
      );
    });
  }
}

void _showBottomSheet(BuildContext context,) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Color(0xFFFACFCF),
    builder: (BuildContext context) {
      return DeliveryAddress();
    },
  );
}