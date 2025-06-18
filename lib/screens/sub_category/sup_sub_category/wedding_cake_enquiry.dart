import 'dart:convert';

import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/sub_category/sup_sub_category/products/pop_screens/description_popup.dart';
import '../../account_screen.dart';
import '../../search_screen.dart';

class WeddingCakeEnquiry extends StatefulWidget {
  final Map<String, dynamic> cake;
  const WeddingCakeEnquiry({super.key, required this.cake });

  @override
  State<WeddingCakeEnquiry> createState() => _WeddingCakeEnquiryState();
}

class _WeddingCakeEnquiryState extends State<WeddingCakeEnquiry> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _postController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  String? nameError;
  String? emailError;
  String? mobileError;
  String? postError;
  String? messageError;

  Future<void> sendEnquiry(ShortProvider provider, BuildContext context) async{
    setState(() {
      nameError= null;
      emailError= null;
      mobileError= null;
      messageError= null;
      if (_nameController.text.isEmpty) {
        nameError = 'Please enter the name';
      } else if (_nameController.text.length < 3) {
        nameError = 'Please enter a valid name';
      }
      if(_mobileController.text.isEmpty){
        mobileError = 'Please enter the mobile number';
      } else if (!numberValidate(_mobileController.text)) {
        mobileError = 'Please enter a valid mobile number';
      }
      if(_emailController.text.isEmpty){
        emailError = 'Please enter the email Id';
      } else if (!isEmailValid(_emailController.text)) {
        emailError = 'Please enter a valid email Id';
      }
      if(_postController.text.isEmpty){
        postError = 'Please enter a postcode';
      }
      if(_messageController.text.isEmpty){
        messageError = 'Please enter a message';
      }
    });
    if(nameError == null &&
        emailError == null &&
        mobileError == null &&
        messageError == null
    ){
      final payload = {
        "name": _nameController.text,
        "contact_number": _mobileController.text,
        "email": _emailController.text,
        "postcode": _postController.text,
        "message": _messageController.text,
        "product_id": widget.cake['product_main_id']
      };
      print(payload);
      try{
        final response = await http.post(
          Uri.parse('https://www.staging.cakesandbakes.net/api/wedding-enquiry'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(payload),
        );
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Enquiry sent successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          final jsonResponse = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                jsonResponse['message'] ?? 'Failed to send enquiry. Please try again.',
              ),
              backgroundColor: const Color(0xFFD41F36),
            ),
          );
        }
      }catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error occurred: ${e.toString()}'),
            backgroundColor: const Color(0xFFD41F36),
          ),
        );
      }
    }
  }

  bool isEmailValid(String email){
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool numberValidate(String mobile){
    final mobileRegex = RegExp(r'^[0-9]{11}$');
    return mobileRegex.hasMatch(mobile);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider,_){
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
                                  onPressed: (){
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
                                  onPressed: (){
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
                      padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 30.rh),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(30.rs),
                          border: Border.all(
                            color: Color(0xFFFF2676),
                            width: 0.25,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.rs),
                                topRight: Radius.circular(20.rs),
                              ),
                              child: Center(
                                child: Image.network(
                                  widget.cake['image'],
                                  width: 906.rw,
                                  height: 906.rh,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            30.verticalSpace,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.rw),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      widget.cake['title'],
                                      style: TextStyle(
                                        color: Color(0xFF283577),
                                        fontSize: 46.rt,
                                        fontWeight: FontWeight.w700
                                      ),
                                    )
                                  ),
                                  20.horizontalSpace,
                                  GestureDetector(
                                    onTap: (){},
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/share.svg',
                                          width: 60.rw,
                                          height: 60.rh,
                                          fit: BoxFit.cover,
                                        )
                                      ],
                                    ),
                                  ),
                                  20.horizontalSpace,
                                  Text(
                                    'SHARE',
                                    style: TextStyle(
                                      color: Color(0xFF283577),
                                      fontSize: 26.rt,
                                      fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              ),
                            ),
                            50.verticalSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // GestureDetector(
                                //   onTap: (){
                                //     double screenWidth = MediaQuery.of(context).size.width;
                                //     int tabIndex = 0;
                                //     if (screenWidth > 800) {
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) => DescriptionPopup(selectedTab: tabIndex),
                                //         ),
                                //       );
                                //     } else {
                                //       _showBottomSheet(context, tabIndex);
                                //     }
                                //   },
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius: BorderRadius.circular(10.rs),
                                //       boxShadow: [
                                //         BoxShadow(
                                //           color: Colors.black.withOpacity(0.08),
                                //           offset: Offset(4, 4),
                                //           blurRadius: 4,
                                //         ),
                                //       ],
                                //     ),
                                //     padding: EdgeInsets.symmetric(horizontal: 40.rw, vertical: 30.rh),
                                //     child: Text(
                                //       'Description',
                                //       style: TextStyle(
                                //           color: Color(0xFF2D46C1),
                                //           fontSize: 34.rt,
                                //           fontWeight: FontWeight.w400
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // 10.horizontalSpace,
                                // GestureDetector(
                                //   onTap: (){
                                //     double screenWidth = MediaQuery.of(context).size.width;
                                //     int tabIndex = 1;
                                //     if (screenWidth > 800) {
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //           builder: (context) => DescriptionPopup(selectedTab: tabIndex),
                                //         ),
                                //       );
                                //     } else {
                                //       _showBottomSheet(context, tabIndex);
                                //     }
                                //   },
                                //   child: Container(
                                //     decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius: BorderRadius.circular(10.rs),
                                //       boxShadow: [
                                //         BoxShadow(
                                //           color: Colors.black.withOpacity(0.08),
                                //           offset: Offset(4, 4),
                                //           blurRadius: 4,
                                //         ),
                                //       ],
                                //     ),
                                //     padding: EdgeInsets.symmetric(horizontal: 40.rw, vertical: 30.rh),
                                //     child: Text(
                                //       'Ingredients',
                                //       style: TextStyle(
                                //           color: Color(0xFF2D46C1),
                                //           fontSize: 34.rt,
                                //           fontWeight: FontWeight.w400
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // 10.horizontalSpace,
                                GestureDetector(
                                  onTap: (){
                                    double screenWidth = MediaQuery.of(context).size.width;
                                    int tabIndex = 2;
                                    if (screenWidth > 800) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DescriptionPopup(selectedTab: tabIndex),
                                        ),
                                      );
                                    } else {
                                      _showBottomSheet(context, tabIndex);
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.rs),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          offset: Offset(4, 4),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 40.rw, vertical: 30.rh),
                                    child: Text(
                                      'Disclaimer',
                                      style: TextStyle(
                                        color: Color(0xFF2D46C1),
                                        fontSize: 34.rt,
                                        fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            80.verticalSpace,
                            Container(
                              width: 512.rw,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF283577),
                                  width: 1,
                                ),
                              ),
                            ),
                            30.verticalSpace,
                            Center(
                              child: Text(
                                'MAKE YOUR ENQUIRY',
                                style: TextStyle(
                                  color: Color(0xFF283577),
                                  fontSize: 30.rt,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                            30.verticalSpace,
                            Container(
                              width: 512.rw,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFEE2938),
                                  width: 1,
                                ),
                              ),
                            ),
                            50.verticalSpace,
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(20.rs),
                                border: Border.all(color: Color(0xFFEDEDED), width: 1),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 5.rw, vertical: 5.rh),
                              child: TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'NAME',
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 26.rt,
                                    color: Color(0xFF8B8B8B),
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24.rt,
                                    color: Color(0xFF007AFF),
                                  ),
                                  errorText: nameError,
                                  errorStyle: TextStyle(
                                    color: Color(0xFFD41F36),
                                    fontSize: 30.rt,
                                    fontWeight: FontWeight.w500
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 10.rh),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.rs),
                                    borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.rs),
                                    borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                                  ),
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 40.rt,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                            30.verticalSpace,
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(20.rs),
                                border: Border.all(color: Color(0xFFEDEDED), width: 1),
                              ),
                              child: TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'EMAIL ADDRESS',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 26.rt,
                                    color: Color(0xFF8B8B8B),
                                  ),
                                  errorText: emailError,
                                  errorStyle: TextStyle(
                                    color: Color(0xFFD41F36),
                                    fontSize: 30.rt,
                                    fontWeight: FontWeight.w500
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 10.rh),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.rs),
                                    borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.rs),
                                    borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                                  ),
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 40.rt,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                            30.verticalSpace,
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(20.rs),
                                border: Border.all(color: Color(0xFFEDEDED), width: 1),
                              ),
                              child: TextField(
                                controller: _mobileController,
                                decoration: InputDecoration(
                                  hintText: 'Mobile Number',
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 26.rt,
                                    color: Color(0xFF8B8B8B),
                                  ),
                                  prefix: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF5F5F5),
                                      borderRadius: BorderRadius.circular(10.rs),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 10.rh),
                                    child: Column(
                                      children: [
                                        Text(
                                          'UK(+44)',
                                          style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 30.rt,
                                            fontWeight: FontWeight.w500
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  errorText: mobileError,
                                  errorStyle: TextStyle(
                                    color: Color(0xFFD41F36),
                                    fontSize: 30.rt,
                                    fontWeight: FontWeight.w500
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 10.rh),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.rs),
                                    borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.rs),
                                    borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                                  ),
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 40.rt,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                            30.verticalSpace,
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(20.rs),
                                border: Border.all(color: Color(0xFFEDEDED), width: 1),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 5.rw, vertical: 5.rh),
                              child: TextField(
                                controller: _postController,
                                decoration: InputDecoration(
                                  labelText: 'POSTCODE',
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 26.rt,
                                    color: Color(0xFF8B8B8B),
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24.rt,
                                    color: Color(0xFF007AFF),
                                  ),
                                  errorText: postError,
                                  errorStyle: TextStyle(
                                    color: Color(0xFFD41F36),
                                    fontSize: 30.rt,
                                    fontWeight: FontWeight.w500
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 10.rh),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.rs),
                                    borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.rs),
                                    borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                                  ),
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 40.rt,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                            30.verticalSpace,
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(20.rs),
                                border: Border.all(color: Color(0xFFEDEDED), width: 1),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 5.rw, vertical: 5.rh),
                              child: TextField(
                                controller: _messageController,
                                decoration: InputDecoration(
                                  labelText: 'MESSAGE',
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  labelStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 26.rt,
                                    color: Color(0xFF8B8B8B),
                                  ),
                                  floatingLabelStyle: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24.rt,
                                    color: Color(0xFF007AFF),
                                  ),
                                  errorText: messageError,
                                  errorStyle: TextStyle(
                                    color: Color(0xFFD41F36),
                                    fontSize: 30.rt,
                                    fontWeight: FontWeight.w500
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 10.rh),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.rs),
                                    borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.rs),
                                    borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                                  ),
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 40.rt,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                            100.verticalSpace,
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFDC2328),
                                borderRadius: BorderRadius.circular(30.rs),
                                border: Border.all(
                                  color: const Color(0xFFDC2328),
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
                              child: GestureDetector(
                                onTap: (){
                                  sendEnquiry(provider, context);
                                },
                                child: Center(
                                  child: Text(
                                    'SEND DETAILS',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 40.rt,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            100.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      );
    });
  }
}

void _showBottomSheet(BuildContext context, int tabIndex) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Color(0xFFFACFCF),
    builder: (BuildContext context) {
      return DescriptionPopup(selectedTab: tabIndex);
    },
  );
}