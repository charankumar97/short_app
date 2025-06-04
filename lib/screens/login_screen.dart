import 'dart:convert';

import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/register_screen.dart';
import '../models/person_model.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String error = '';
  String emailError = '';
  String passwordError = '';
  bool isLoading = false;
  bool show = false;

  Future<void> login(ShortProvider provider, BuildContext context) async {
    setState(() => isLoading = true);

    final payload = {
      "email": _emailController.text,
      "password": _passwordController.text,
    };
    print(payload);
    final response = await http.post(
      Uri.parse('https://www.staging.cakesandbakes.net/api/login'),
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
        mobile: "0${user['contact_number'].substring(3)}",
      );
      provider.updateUser(details, context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen())
      );
    } else {
      setState(() {
        error = jsonResponse['message'] ?? '';
        emailError = jsonResponse['error']?['email']?[0] ?? '';
        passwordError = jsonResponse['error']?['password']?[0] ?? '';
      });
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _){
      return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.rw,vertical: 30.rh),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.rh),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login with',
                          style: TextStyle(
                              fontSize: 90.rt,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF000000)
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 90.rt,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF000000)
                              ),
                            ),
                            5.horizontalSpace,
                            SvgPicture.asset(
                              'assets/images/Group 655.svg',
                              width: 150.rw,
                              height: 100.rh,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Text(
                    'Hello! Welcome back.',
                    style: TextStyle(
                        fontSize: 36.rt,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF000000)
                    ),
                  ),
                  50.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _emailController,
                          onChanged: (value) {
                            final cursorPosition = _emailController.selection;
                            _emailController.value = _emailController.value
                                .copyWith(
                              text: value,
                              selection: cursorPosition,
                              composing: TextRange.empty,
                            );
                          },
                          style: TextStyle(
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF000000),
                          ),
                          cursorColor: Color(0xFF000000),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email ID',
                            hintStyle: TextStyle(
                              fontSize: 40.rt,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFC3C3C3),
                            ),
                            prefixIcon: Image.asset(
                              'assets/images/Gmail Logo.png',
                              width: 30.rw,
                              height: 30.rh,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFC3C3C3),
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFC3C3C3),
                                width: 2,
                              ),
                            ),
                            errorText: emailError.isNotEmpty ? emailError : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextField(
                          controller: _passwordController,
                          onChanged: (value) {
                            final cursorPosition =
                                _passwordController.selection;
                            _passwordController.value = _passwordController
                                .value
                                .copyWith(
                              text: value,
                              selection: cursorPosition,
                              composing: TextRange.empty,
                            );
                          },
                          style: TextStyle(
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          cursorColor: Colors.black,
                          obscureText: show ? false : true,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 40.rt,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFC3C3C3),
                            ),
                            prefixIcon: Image.asset(
                              'assets/images/Password.png',
                              width: 30.rw,
                              height: 30.rh,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  show = !show;
                                });
                              },
                              child:
                              show
                                  ? Image.asset(
                                'assets/images/show.png',
                                width: 10.rw,
                                height: 10.rh,
                              )
                                  : Image.asset(
                                'assets/images/invisible.png',
                                width: 10.rw,
                                height: 10.rh,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFC3C3C3),
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFC3C3C3),
                                width: 2,
                              ),
                            ),
                            errorText: passwordError.isNotEmpty ? passwordError : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Lost password?',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 36.rt,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Reset Password',
                          style: TextStyle(
                            fontSize: 36.rt,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF000000),
                          ),
                        ),
                      ),
                    ],
                  ),
                  80.verticalSpace,
                  GestureDetector(
                    onTap: (){
                      login(provider,context);
                    },
                    child: Container(
                      width: 850.rw,
                      height: 160.rh,
                      padding: EdgeInsets.symmetric(horizontal: 150.rw, vertical: 50.rh),
                      decoration: BoxDecoration(
                        color: Color(0xFF000000),
                        borderRadius: BorderRadius.circular(30.rs),
                        border: Border.all(
                          color: Color(0xFF565656),
                          width: 6.rw,
                        ),
                      ),
                      child: Text(
                        'PROCEED TO LOGIN',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 48.rt,
                            color: Color(0xFFFFFFFF)
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  80.verticalSpace,
                  Center(
                    child: Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 40.rt,
                        fontWeight: FontWeight.w500,
                        color: Colors.black12,
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 866.rw,
                      height: 140.rh,
                      padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(90.rs),
                        border: Border.all(color: Color(0xFFC6C6C6)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                            color: Color(0xFFFC13BA),
                            fontSize: 54.rt,
                            fontWeight: FontWeight.w500
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: 866.rw,
                      height: 140.rh,
                      padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(90.rs),
                        border: Border.all(color: Color(0xFFC6C6C6)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'CONNECT WITH',
                            style: TextStyle(
                                color: Color(0xFF989898),
                                fontSize: 34.rt,
                                fontWeight: FontWeight.w500
                            ),
                            textAlign: TextAlign.center,
                          ),
                          10.horizontalSpace,
                          IconButton(
                            onPressed: (){},
                            icon: SvgPicture.asset(
                              'assets/images/Group 615.svg',
                              width: 70.rw,
                              height: 70.rh,
                            ),
                          ),
                          10.horizontalSpace,
                          IconButton(
                            onPressed: (){},
                            icon: SvgPicture.asset(
                              'assets/images/Group 665.svg',
                              width: 70.rw,
                              height: 70.rh,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      );
    });
  }
}
