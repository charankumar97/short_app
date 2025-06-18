import 'dart:convert';

import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';

class FranchiseEnquiry extends StatefulWidget {
  const FranchiseEnquiry({super.key});

  @override
  State<FranchiseEnquiry> createState() => _FranchiseEnquiryState();
}

class _FranchiseEnquiryState extends State<FranchiseEnquiry> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  String? nameError;
  String? emailError;
  String? phoneError;
  String? messageError;

  Future<void> sendEnquiry(ShortProvider provider, BuildContext context) async{
    setState(() {
      nameError= null;
      emailError= null;
      phoneError= null;
      messageError= null;
      if (nameController.text.isEmpty) {
        nameError = 'Please enter the name';
      } else if (nameController.text.length < 3) {
        nameError = 'Please enter a valid name';
      }
      if(phoneController.text.isEmpty){
        phoneError = 'Please enter the mobile number';
      } else if (!numberValidate(phoneController.text)) {
        phoneError = 'Please enter a valid mobile number';
      }
      if(emailController.text.isEmpty){
        emailError = 'Please enter the email Id';
      } else if (!isEmailValid(emailController.text)) {
        emailError = 'Please enter a valid email Id';
      }
      if(messageController.text.isEmpty){
        messageError = 'Please enter a message';
      }
    });
    if(nameError == null &&
      emailError == null &&
      phoneError == null &&
      messageError == null
    ){
      final payload = {
        "name": nameController.text,
        "email": emailController.text,
        "contact_number": phoneController.text,
      };
      print(payload);
      try{
        final response = await http.post(
          Uri.parse('https://www.staging.cakesandbakes.net/api/franchise-enquiry'),
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
          backgroundColor: Color(0xFFFFF0F0),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF181E53),
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
                          'FRANCHISE ENQUIRY',
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
                  decoration: BoxDecoration(
                    // color: Color(0xFFFFF0F0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.rs),
                      topRight: Radius.circular(30.rs)
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 80.rh),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Contact Us Today For Franchise Related Enquiries',
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 60.rt,
                          fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.center,
                      ),
                      80.verticalSpace,
                      Container(
                        height: 130.rh,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(30.rs),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 50.rw),
                        child: TextField(
                          controller: nameController,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w500
                          ),
                          decoration: InputDecoration(
                            hintText: 'Full Name',
                            hintStyle: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 40.rt,
                              fontWeight: FontWeight.w500
                            ),
                            errorText: nameError,
                            errorStyle: TextStyle(
                              color: Color(0xFFD41F36),
                              fontSize: 30.rt,
                              fontWeight: FontWeight.w500
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      30.verticalSpace,
                      Container(
                        height: 150.rh,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(30.rs),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30.rw),
                        child: TextField(
                          controller: phoneController,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w500
                          ),
                          decoration: InputDecoration(
                            hintText: 'Contact Number',
                            hintStyle: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 40.rt,
                              fontWeight: FontWeight.w500
                            ),
                            prefix: Container(
                              height: 80.rh,
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(10.rs),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 10.rh),
                              child: Column(
                                children: [
                                  Text(
                                    'UK(+44)',
                                    style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 35.rt,
                                      fontWeight: FontWeight.w500
                                    ),
                                  )
                                ],
                              ),
                            ),
                            errorText: phoneError,
                            errorStyle: TextStyle(
                              color: Color(0xFFD41F36),
                              fontSize: 30.rt,
                              fontWeight: FontWeight.w500
                            ),
                            border: InputBorder.none,
                          ),
                        ),

                      ),
                      30.verticalSpace,
                      Container(
                        height: 150.rh,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(30.rs),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 50.rw),
                        child: TextField(
                          controller: emailController,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w500
                          ),
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            hintStyle: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 40.rt,
                              fontWeight: FontWeight.w500
                            ),
                            errorText: emailError,
                            errorStyle: TextStyle(
                              color: Color(0xFFD41F36),
                              fontSize: 30.rt,
                              fontWeight: FontWeight.w500
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      30.verticalSpace,
                      Container(
                        height: 250.rh,
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(30.rs),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 50.rw),
                        child: TextField(
                          controller: messageController,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w500
                          ),
                          decoration: InputDecoration(
                            hintText: 'Your Message',
                            hintStyle: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 40.rt,
                              fontWeight: FontWeight.w500
                            ),
                            errorText: messageError,
                            errorStyle: TextStyle(
                              color: Color(0xFFD41F36),
                              fontSize: 30.rt,
                              fontWeight: FontWeight.w500
                            ),
                            border: InputBorder.none,
                          ),
                        ),

                      ),
                      80.verticalSpace,
                      GestureDetector(
                        onTap: (){
                          sendEnquiry(provider, context);
                        },
                        child: Container(
                          width: 860.rw,
                          height: 100.rh,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xFFD41F36),
                            borderRadius: BorderRadius.circular(10.rs),
                            border: Border.all(
                              color: Color(0xFFD41F36),
                              width: 1,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 38.rt,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      )
                    ],
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
