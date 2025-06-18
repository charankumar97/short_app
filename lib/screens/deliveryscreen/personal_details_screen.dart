import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/check_out_screen.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  String? firstNameError;
  String? lastNameError;
  String? emailError;
  String? mobileError;

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
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
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
                          'ADD ADDRESS',
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
                  padding: EdgeInsets.only(left: 80.rw, right: 80.rw, top: 50.rh, bottom: 10.rh),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(30.rs),
                      border: Border.all(
                        color: Color(0xFFEDEDED),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 50.rh),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PERSONAL DETAILS',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 46.rt,
                            fontWeight: FontWeight.w700
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
                            controller: _firstController,
                            decoration: InputDecoration(
                              labelText: 'FIRST NAME',
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
                            controller: _lastController,
                            decoration: InputDecoration(
                              labelText: 'LAST NAME',
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
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 80.rw, right: 80.rw, top: 30.rh, bottom: 100.rh),
                  child: GestureDetector(
                    onTap: (){
                      final String firstName = _firstController.text;
                      final String lastName = _lastController.text;
                      final String email = _emailController.text;
                      final String mobile = _mobileController.text;
                      provider.prerson(firstName, lastName, email, mobile);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CheckOutScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xFF000000),
                        borderRadius: BorderRadius.circular(30.rs),
                        border: Border.all(
                          color: Color(0xFF000000),
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                      child: Text(
                        'PROCEED TO CHECKOUT',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 38.rt,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
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
