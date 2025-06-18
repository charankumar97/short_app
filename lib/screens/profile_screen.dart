import 'dart:convert';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';

import '../models/person_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();

  String? firstError;
  String? lastError;
  String? emailError;
  String? passwordError;
  String? oldPasswordError;
  String? confirmPasswordError;
  String? mobileError;
  bool show = false;
  bool show1 = false;
  bool show2 = false;


  Future<void> updateDetails(ShortProvider provider, BuildContext context) async {
    setState(() {
      firstError = null;
      lastError = null;
      emailError = null;
      mobileError = null;

      if (_firstController.text.isEmpty) {
        firstError = 'Please enter the first name';
      } else if (_firstController.text.length < 3) {
        firstError = 'Please enter a valid name';
      }
      if (_lastController.text.isEmpty) {
        lastError = 'Please enter the last name';
      }
      if (_mobileController.text.isEmpty) {
        mobileError = 'Please enter the mobile number';
      } else if (!numberValidate(_mobileController.text)) {
        mobileError = 'Enter a valid mobile number';
      }
    });
    if (firstError == null &&
        lastError == null &&
        emailError == null &&
        mobileError == null) {
      final int userId = int.parse(provider.users[0].id);
      final payload = {
        'first_name': _firstController.text,
        'last_name': _lastController.text,
        'contact_number': _mobileController.text,
      };
      print(payload);
      try {
        final response = await http.post(
          Uri.parse('https://www.staging.cakesandbakes.net/api/update-account-details/$userId'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(payload),
        );
        final jsonResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          final user = jsonResponse['user'];
          Person details = Person(
            id: user['id'].toString(),
            firstName: user['first_name'],
            lastName: user['last_name'],
            email: user['email'],
            mobile: "${user['contact_number']}",
          );
          provider.updateUserDetails(details, context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Details updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          setState(() {
            firstError = jsonResponse['error']['first_name'] == null?'': jsonResponse['error']['first_name'][0];
            lastError = jsonResponse['error']['last_name'] == null?'': jsonResponse['error']['last_name'][0];
            emailError = jsonResponse['error']['email'] == null?'': jsonResponse['error']['email'][0];
            mobileError = jsonResponse['error']['contact_number'] == null?'': jsonResponse['error']['contact_number'][0];
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error occurred: ${e.toString()}'),
            backgroundColor: const Color(0xFFD41F36),
          ),
        );
      }
    }
  }

  Future<void> updatePassword(ShortProvider provider, BuildContext context) async {
    setState(() {
      passwordError = null;
      confirmPasswordError = null;

      if (_passwordController.text.isEmpty) {
        passwordError = 'Please enter a password';
      } else if (_passwordController.text.length < 6) {
        passwordError = 'Password must be at least 6 characters';
      }

      if (_confirmPasswordController.text.isEmpty) {
        confirmPasswordError = 'Please confirm your password';
      } else if (_confirmPasswordController.text != _passwordController.text) {
        confirmPasswordError = 'Passwords do not match';
      }
    });

    if (passwordError == null && confirmPasswordError == null) {
      final int userId = int.parse(provider.users[0].id);
      final payload = {
        'password': _passwordController.text,
        'confirm_password': _confirmPasswordController.text,
      };

      try {
        final response = await http.post(
          Uri.parse('https://www.staging.cakesandbakes.net/api/change-password/$userId'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(payload),
        );

        final jsonResponse = json.decode(response.body);
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          _passwordController.clear();
          _confirmPasswordController.clear();
        } else {
          setState(() {
            passwordError = jsonResponse['error']['password'] == null ? '' : jsonResponse['error']['password'][0];
            confirmPasswordError = jsonResponse['error']['confirm_password'] == null ? '' : jsonResponse['error']['confirm_password'][0];
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error occurred: ${e.toString()}'),
            backgroundColor: const Color(0xFFD41F36),
          ),
        );
      }
    }
  }

  bool numberValidate(String mobile){
    final mobileRegex = RegExp(r'^[0-9]{10}$');
    return mobileRegex.hasMatch(mobile);
  }

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      final user = Provider.of<ShortProvider>(context,listen: false).users;
      setState(() {
        _firstController.text = user[0].firstName;
        _lastController.text = user[0].lastName;
        _emailController.text = user[0].email;
        _mobileController.text = user[0].mobile;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _){
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
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
                              'assets/images/Vector(1).svg',
                              width: 59.rw,
                              height: 59.rh,
                            ),
                            label: Text(
                              'Back',
                              style: TextStyle(
                                color: Color(0xFF1E4489),
                                fontSize: 40.rt,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'EDIT PROFILE',
                          style: TextStyle(
                            color: Color(0xFF1E4489),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 10.rh),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(30.rs),
                      border: Border.all(
                        color: Color(0xFFEDEDED),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 50.rh),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('YOUR DETAILS', style: TextStyle(color: Color(0xFF000000),fontSize: 46.rt,fontWeight: FontWeight.w700)),
                            const Spacer(),
                            GestureDetector(
                              onTap: (){
                                updateDetails(provider, context);
                              },
                              child: Text('SAVE',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36.rt, color: Color(0xFF2F80ED))),
                            ),
                          ],
                        ),
                        50.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.rw, vertical: 5.rh),
                                child: TextField(
                                  controller: _firstController,
                                  style: TextStyle(
                                    fontSize: 38.rt,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF000000),
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'First NAME',
                                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 35.rt,
                                      color: Color(0xFF8B8B8B),
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 35.rt,
                                      color: Color(0xFF8D8D8D),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12.rw),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.rs),
                                      borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.rs),
                                      borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                                    ),
                                  ),
                                  onChanged: (value){
                                    final value = _firstController.text;
                                    setState(() {
                                      value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            30.verticalSpace,
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.rw,
                                ),
                                child: TextField(
                                  controller: _lastController,
                                  style: TextStyle(
                                    fontSize: 38.rt,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Last NAME',
                                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 35.rt,
                                      color: Color(0xFF8B8B8B),
                                    ),
                                    floatingLabelStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 35.rt,
                                      color: Color(0xFF8D8D8D),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12.rw,),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.rs),
                                      borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.rs),
                                      borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                                    ),
                                  ),
                                  onChanged: (value){
                                    final value = _lastController.text;
                                    setState(() {
                                      value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        25.verticalSpace,
                        TextField(
                          readOnly: true,
                          cursorColor: Colors.black,
                          controller: _emailController,
                          style: TextStyle(
                            fontSize: 38.rt,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF8D8D8D),
                          ),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 35.rt,
                              color: Color(0xFF8B8B8B),
                            ),
                            floatingLabelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 35.rt,
                              color: Color(0xFF8D8D8D),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12.rw,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.rs),
                              borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.rs),
                              borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                            ),
                          ),
                        ),
                        25.verticalSpace,
                        TextField(
                          cursorColor: Colors.black,
                          controller: _mobileController,
                          style: TextStyle(
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: 'mobile number',
                            hintStyle: TextStyle(
                              fontSize: 35.rt,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.rs),
                              borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.rs),
                              borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                            ),
                          ),
                          onChanged: (value){
                            final value = _mobileController.text;
                            setState(() {
                              value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 30.rh),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(30.rs),
                      border: Border.all(
                        color: Color(0xFFEDEDED),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 50.rh),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('CHANGE PASSWORD', style: TextStyle(color: Color(0xFF000000),fontSize: 46.rt,fontWeight: FontWeight.w700,)),
                            const Spacer(),
                            GestureDetector(
                              onTap: (){
                                updatePassword(provider, context);
                              },
                              child: Text('UPDATE',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 36.rt, color: Color(0xFF2F80ED))),
                            ),
                          ],
                        ),
                        50.verticalSpace,
                        TextField(
                          cursorColor: Colors.black,
                          controller: _oldPasswordController,
                          style: TextStyle(
                            fontSize: 38.rt,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Old Password',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 35.rt,
                              color: Color(0xFF8B8B8B),
                            ),
                            floatingLabelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 35.rt,
                              color: Color(0xFF8D8D8D),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  show = !show;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 60.rw),
                                child: SizedBox(
                                  width: 24.rw,
                                  height: 24.rh,
                                  child: Image.asset(
                                    show
                                        ? 'assets/images/show.png'
                                        : 'assets/images/invisible.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12.rw,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.rs),
                              borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.rs),
                              borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                            ),
                          ),
                          onChanged: (value){
                            final value = _oldPasswordController.text;
                            setState(() {
                              value;
                            });
                          },
                        ),
                        30.verticalSpace,
                        TextField(
                          cursorColor: Colors.black,
                          controller: _passwordController,
                          style: TextStyle(
                            fontSize: 38.rt,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelText: 'New Password',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 35.rt,
                              color: Color(0xFF8B8B8B),
                            ),
                            floatingLabelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 35.rt,
                              color: Color(0xFF8D8D8D),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  show1 = !show1;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 60.rw),
                                child: SizedBox(
                                  width: 24.rw,
                                  height: 24.rh,
                                  child: Image.asset(
                                    show1
                                        ? 'assets/images/show.png'
                                        : 'assets/images/invisible.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12.rw,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.rs),
                              borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.rs),
                              borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                            ),
                          ),
                          onChanged: (value){
                            final value = _passwordController.text;
                            setState(() {
                              value;
                            });
                          },
                        ),
                        30.verticalSpace,
                        TextField(
                          cursorColor: Colors.black,
                          controller: _confirmPasswordController,
                          style: TextStyle(
                            fontSize: 38.rt,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Re-Enter New Password',
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 35.rt,
                              color: Color(0xFF8B8B8B),
                            ),
                            floatingLabelStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 35.rt,
                              color: Color(0xFF8D8D8D),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  show2 = !show2;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: 60.rw),
                                child: SizedBox(
                                  width: 24.rw,
                                  height: 24.rh,
                                  child: Image.asset(
                                    show2
                                        ? 'assets/images/show.png'
                                        : 'assets/images/invisible.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12.rw,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.rs),
                              borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.rs),
                              borderSide: BorderSide(color: Color(0xFFC0C0C0)),
                            ),
                          ),
                          onChanged: (value){
                            final value = _confirmPasswordController.text;
                            setState(() {
                              value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 50.rh),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 10.rh),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFD41F36),
                              borderRadius: BorderRadius.circular(30.rs),
                              border: Border.all(
                                color: Color(0xFFD41F36),
                                width: 1,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rh),
                            child: Text(
                              'DELETE ACCOUNT',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 38.rt,
                                fontWeight: FontWeight.w500
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        30.horizontalSpace,
                        GestureDetector(
                          onTap: (){
                            provider.logOut(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(30.rs),
                              border: Border.all(
                                color: Color(0xFF000000),
                                width: 1,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rh),
                            child: Text(
                              'LOG OUT',
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontSize: 38.rt,
                                fontWeight: FontWeight.w500
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
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
