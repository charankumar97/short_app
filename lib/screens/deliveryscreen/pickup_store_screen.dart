import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/deliveryscreen/date_time_screen.dart';
import 'package:short_app/screens/deliveryscreen/delivery_screen.dart' show Delivery1Screen;
import 'package:url_launcher/url_launcher.dart';

class PickupStoreScreen extends StatefulWidget {
  final int selectedTab;
  const PickupStoreScreen({super.key, required this.selectedTab});

  @override
  State<PickupStoreScreen> createState() => _PickupStoreScreenState();
}

class _PickupStoreScreenState extends State<PickupStoreScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool hasChecked = false;
  late int selectedTab;


  @override
  void initState() {
    super.initState();
    selectedTab = widget.selectedTab;
    _searchController.addListener(() {
      final text = _searchController.text.toUpperCase();
      if (_searchController.text != text) {
        _searchController.value = _searchController.value.copyWith(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _){
      return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.rs)),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFFDBE5FF),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  _buildTabContent(provider),
                ],
              ),
            ),
          )
        ),
      );
    });
  }
  Widget _buildTabContent(ShortProvider provider) {
    List<Map<String, dynamic>> store = provider.collection.toList();
    final String message = provider.text;
    switch(widget.selectedTab){
      case 0: return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 50.rh),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'PICKUP STORE',
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 46.rt,
                      fontWeight: FontWeight.w700
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                10.verticalSpace,
                Center(
                  child: Text(
                    'Please enter your postcode to show nearest stores',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                      fontSize: 30.rt,
                      fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                30.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.rh),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.rs),
                    border: Border.all(
                      color: Color(0xFFB8B8B8),
                      width: 0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w500,
                          ),
                          controller: _searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter postcode',
                            hintStyle: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 40.rt,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          final text = _searchController.text.trim();
                          final isValid = RegExp(
                            r"^[A-Z]{1,2}[0-9][0-9A-Z]?\s?[0-9][A-Z]{2}$",
                            caseSensitive: false,
                          ).hasMatch(text);
                          if (isValid) {
                            setState(() {
                              hasChecked = true;
                            });
                            provider.fetchSearchSuggestions(text, context);
                          } else {
                            setState(() {
                              hasChecked = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Enter a valid postcode'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Check',
                          style: TextStyle(
                            color: Color(0xFF2D46C1),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                50.verticalSpace,
                hasChecked &&  _searchController.text.isNotEmpty?
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(100.rs),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 30.rt,
                      fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.center,
                  ),
                ): SizedBox.shrink(),
                50.verticalSpace,
                hasChecked && _searchController.text.isNotEmpty
                    ? Padding(
                  padding: EdgeInsets.only(bottom: 40.rh),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: store.length,
                    itemBuilder: (context, index) {
                      return _buildStoreLocation(
                        store[index],
                        context,
                      );
                    },
                  ),
                )
                    : SizedBox.shrink(),
              ],
            ),
          )
        ],
      );
      case 1: return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 100.rw, vertical: 50.rh),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'CHECK DELIVERY POSTCODE',
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 46.rt,
                        fontWeight: FontWeight.w700
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                10.verticalSpace,
                Center(
                  child: Text(
                    'Please enter your postcode to deliver your order',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                        fontSize: 30.rt,
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                30.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.rh),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.rs),
                    border: Border.all(
                      color: Color(0xFFB8B8B8),
                      width: 0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w500
                          ),
                          controller: _searchController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter postcode',
                            hintStyle: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 40.rt,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          final text = _searchController.text.trim();
                          final isValid = RegExp(
                            r"^[A-Z]{1,2}[0-9][0-9A-Z]?\s?[0-9][A-Z]{2}$",
                            caseSensitive: false,
                          ).hasMatch(text);
                          if (isValid) {
                            setState(() {
                              hasChecked = true;
                            });
                            provider.fetchSearchSuggestions(text, context);
                          } else {
                            setState(() {
                              hasChecked = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Enter a valid postcode'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Check',
                          style: TextStyle(
                            color: Color(0xFF2D46C1),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                80.verticalSpace,
                hasChecked && _searchController.text.isNotEmpty?
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(100.rs),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
                  child: Text(
                    message,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 30.rt,
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.center,
                  ),
                ): SizedBox.shrink(),
                150.verticalSpace,
                hasChecked && _searchController.text.isNotEmpty?
                GestureDetector(
                  onTap: (){
                    final input = _searchController.text.trim();

                    if (input.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Delivery1Screen(postCode: input),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter a valid postcode'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 100.rh,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFF000000),
                      borderRadius: BorderRadius.circular(100.rs),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
                    child: Text(
                      'CHOOSE DELIVERY TIME',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.rt,
                          fontWeight: FontWeight.w400
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ): SizedBox.shrink(),
              ],
            ),
          )
        ],
      );
      default: return SizedBox.shrink();
    }
  }
}

Widget _buildStoreLocation(Map<String, dynamic> store, BuildContext context,){
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber.replaceAll(' ', ''));
    if (!await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      final fallbackUrl = Uri(scheme: 'tel', path: phoneNumber.replaceAll(' ', ''));
      if (await canLaunchUrl(fallbackUrl)) {
        await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
      } else {
        print('Could not launch $phoneNumber');
      }
    }
  }
  Future<void> sendEmail(String email) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email.trim(),
    );

    if (!await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      final Uri uri = Uri(
        scheme: 'mailto',
        path: email.trim(),
      );
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }else {
        print('Could not launch email client for $email');
      }
    }
  }
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.rh),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(30.rs),
        border: Border.all(
          color: Color(0xFFE7E7E7),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            offset: Offset(6, 8),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 40.rh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            store['title'],
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 46.rt,
              fontWeight: FontWeight.w700
            ),
          ),
          25.verticalSpace,
          Text(
            store['address'],
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 38.rt,
              fontWeight: FontWeight.w500
            ),
          ),
          15.verticalSpace,
          Text(
            store['description'],
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 38.rt,
              fontWeight: FontWeight.w600
            ),
          ),
          20.verticalSpace,
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.rs),
              border: Border.all(
                color: Color(0xFFBFBFBF),
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 150.rw, vertical: 15.rh),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    makePhoneCall(store['contact_number']);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/call.svg',
                        width: 50.rw,
                        height: 50.rh,
                      ),
                      15.horizontalSpace,
                      Text(
                        'Call',
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 36.rt,
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  ),
                ),
                VerticalDivider(
                  color: Color(0xFF000000),
                  width: 20,
                  thickness: 10,
                ),
                GestureDetector(
                  onTap: (){
                    sendEmail(store['email']);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/mail.svg',
                        width: 50.rw,
                        height: 50.rh,
                      ),
                      15.horizontalSpace,
                      Text(
                        'Mail',
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 36.rt,
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          30.verticalSpace,
          GestureDetector(
            onTap: (){
              double screenWidth =
                  MediaQuery.of(context).size.width;
              if (screenWidth > 800) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DateTimeScreen(),
                  ),
                );
              } else {
                _showBottomSheet(context);
              }
            },
            child: Container(
              width: 870.rw,
              height: 100.rh,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20.rs),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
              child: Text(
                'PICKUP HERE',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 36.rt,
                  fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.center,
              )
            )
          )
        ],
      ),
    ),
  );
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return const DateTimeScreen();
    },
  );
}