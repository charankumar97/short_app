import 'dart:convert';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/home_screen.dart';

import '../models/person_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isChecked = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String? nameError;
  String? lastError;
  String? emailError;
  String? passwordError;
  String? confirmError;
  String? mobileError;
  String? dateError;
  String? error;

  Future<void> register(ShortProvider provider, BuildContext context) async{
    final originalDate = DateTime.tryParse(_dateController.text);
    final formattedDob = originalDate != null
        ? '${originalDate.day}/${originalDate.month}/${originalDate.year}'
        : '';
      final payload = {
        "first_name": _nameController.text,
        "last_name": _lastController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "confirm_password": _confirmController.text,
        "contact_number": _mobileController.text,
        "dob":  formattedDob,
      };
      print(payload);
      final response = await http.post(
        Uri.parse('https://www.staging.cakesandbakes.net/api/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if(response.statusCode == 200){
        final user = jsonResponse['user'];
        Person details = Person(
          id: user['id'].toString(),
          firstName: user['first_name'],
          lastName: user['last_name'],
          email: user['email'],
          mobile: "0${user['contact_number'].substring(3)}",
        );
        provider.registerUser(details, context);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen())
        );
      }else{
        setState(() {
          nameError = jsonResponse['error']['first_name']==null?'':jsonResponse['error']['first_name'][0];
          lastError = jsonResponse['error']['last_name']==null?'':jsonResponse['error']['last_name'][0];
          emailError = jsonResponse['error']['email']==null?'':jsonResponse['error']['email'][0];
          passwordError = jsonResponse['error']['password']==null?'':jsonResponse['error']['password'][0];
          confirmError = jsonResponse['error']['confirm_password']==null?'':jsonResponse['error']['confirm_password'][0];
          mobileError = jsonResponse['error']['contact_number']==null?'':jsonResponse['error']['contact_number'][0];
        });
      }

  }
  bool isValidMobileNumber(String mobile) {
    String mobilePattern = r'^[0-9]{11}$';
    RegExp regex = RegExp(mobilePattern);
    return regex.hasMatch(mobile);
  }
  bool isValidEmail(String email) {
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider,_){
      return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 10.rh),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: (){Navigator.pop(context);},
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 10.rh),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/Group 684(1).svg',
                                  width: 49.185.rw,
                                  height: 34.365.rh,
                                ),
                                15.horizontalSpace,
                                Text(
                                  'BACK',
                                  style: TextStyle(
                                    color: Color(0xFF951E48),
                                    fontSize: 30.rt,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.rw, vertical: 30.rh),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'CREATE ACCOUNT',
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 63.rt,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.rw,vertical: 15.rh),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: TextField(
                                            controller: _nameController,
                                            style: TextStyle(
                                              fontSize: 40.rt,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF000000),
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'First Name',
                                              hintStyle: TextStyle(
                                                fontSize: 40.rt,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            onChanged: (value){
                                              setState(() {
                                                _nameController.text = value;
                                              });
                                            },
                                          ),
                                        ),
                                        30.horizontalSpace,
                                        Expanded(
                                          flex: 1,
                                          child: TextField(
                                            controller: _lastController,
                                            style: TextStyle(
                                              fontSize: 40.rt,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF000000),
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Last Name',
                                              hintStyle: TextStyle(
                                                fontSize: 40.rt,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            onChanged: (value){
                                              setState(() {
                                                _lastController.text = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    15.verticalSpace,
                                    TextField(
                                      controller: _emailController,
                                      style: TextStyle(
                                        fontSize: 40.rt,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF000000),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Email Address',
                                        hintStyle: TextStyle(
                                          fontSize: 40.rt,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      onChanged: (value){
                                        setState(() {
                                          _emailController.text = value;
                                        });
                                      },
                                    ),
                                    15.verticalSpace,
                                    TextField(
                                      controller: _passwordController,
                                      style: TextStyle(
                                        fontSize: 40.rt,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF000000),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                          fontSize: 40.rt,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      onChanged: (value){
                                        setState(() {
                                          _passwordController.text = value;
                                        });
                                      },
                                    ),
                                    15.verticalSpace,
                                    TextField(
                                      controller: _confirmController,
                                      style: TextStyle(
                                        fontSize: 40.rt,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF000000),
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Re-Enter password',
                                        hintStyle: TextStyle(
                                          fontSize: 40.rt,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      onChanged: (value){
                                        setState(() {
                                          _confirmController.text = value;
                                        });
                                      },
                                    ),
                                    15.verticalSpace,
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: _mobileController,
                                            style: TextStyle(
                                              fontSize: 40.rt,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF000000),
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Contact number',
                                              hintStyle: TextStyle(
                                                fontSize: 40.rt,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            onChanged: (value){
                                              setState(() {
                                                _mobileController.text = value;
                                              });
                                            },
                                          ),
                                        ),
                                        20.horizontalSpace,
                                        Expanded(
                                          child: TextField(
                                            controller: _dateController,
                                            style: TextStyle(
                                              fontSize: 40.rt,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF000000),
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Date of Birth',
                                              hintStyle: TextStyle(
                                                fontSize: 40.rt,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                              ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            onTap: () async {
                                              DateTime? selectedDate =
                                              await showDatePicker(
                                                context: context,
                                                firstDate: DateTime(
                                                  DateTime.now().year - 100,
                                                ),
                                                initialDate: DateTime.now(),
                                                lastDate: DateTime(
                                                  DateTime.now().year + 100,
                                                ),
                                              );
                                              if (selectedDate != null) {
                                                _dateController.text =
                                                "${selectedDate.toLocal()}"
                                                    .split(' ')[0];
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              80.verticalSpace,
                              Row(
                                children: [
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (value){
                                      setState(() {
                                        isChecked = value ?? false;
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.rs)
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  GestureDetector(
                                    onTap: (){},
                                    child: Text(
                                      'I Accept the Terms & Conditions',
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 36.rt,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              30.verticalSpace,
                              Column(
                                children: [
                                  Text(
                                    'By creating an account, you are agreeing to \n our Terms of Service and Privacy Policy',
                                    style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontSize: 46.rt,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              50.verticalSpace,
                            ],
                          ),
                        ),
                        Divider(
                          color: Color(0xFF000000),
                          thickness: 1,
                          height: 20.rh,
                        ),
                        50.verticalSpace,
                        GestureDetector(
                          onTap: (){
                            register(provider, context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30.rs),
                              border: Border.all(
                                color: Color(0xFF565656),
                                width: 3,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Create Account',
                                  style: TextStyle(
                                      fontSize: 48.rt,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFFFFFFF)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
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
