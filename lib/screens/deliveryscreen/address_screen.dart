import 'dart:convert';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';

class AddressScreen extends StatefulWidget {
  final Map<String, dynamic>? address;
  const AddressScreen({super.key,  this.address,});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _flatController = TextEditingController();
  final TextEditingController _cityController= TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postcodeController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();


  String? firstNameError;
  String? lastNameError;
  String? emailError;
  String? mobileError;
  String? flatError;
  String? cityError;
  String? stateError;
  String? postCodeError;
  String? countryError;

  Future<void> addAddress(ShortProvider provider,BuildContext context) async {
    final payload = {
      "first_name": capitalizeFirstLetter(_firstController.text),
      "last_name": capitalizeFirstLetter(_lastController.text),
      "contact_number": _mobileController.text,
      "email": _emailController.text,
      "address_line1": _flatController.text,
      "city": _cityController.text,
      "state": _stateController.text,
      "postcode": _postcodeController.text,
      "country": _countryController.text
    };

    final int userId = int.parse(provider.users[0].id);
    final response = await http.post(
      Uri.parse('https://www.staging.cakesandbakes.net/api/add-address/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final addressData = responseData['address'];
      print(addressData);
      provider.fetchShowAddress(userId);
      provider.fetchOrders(userId);
      print(provider.showAddress);
      print('Address added successfully');
    } else {
      print('Failed to add address: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }

  Future<void> updateAddress(ShortProvider provider, BuildContext context) async {
    final payload = {
      "first_name": capitalizeFirstLetter(_firstController.text),
      "last_name": capitalizeFirstLetter(_lastController.text),
      "contact_number": _mobileController.text,
      "email": _emailController.text,
      "address_line1": _flatController.text,
      "city": _cityController.text,
      "state": _stateController.text,
      "postcode": _postcodeController.text,
      "country": _countryController.text,
    };

    final int userId = int.parse(provider.users[0].id);
    final int addressId = widget.address?['id'];

    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/update-address/$userId/$addressId');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final addressData = responseData['address'];
      print(addressData);
      provider.fetchShowAddress(userId);
      print('Address updated successfully');
    } else {
      print('Failed to update address: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      final address = widget.address;

      setState(() {
        _firstController.text = address?["first_name"] ?? '';
        _lastController.text = address?["last_name"] ?? '';
        _emailController.text = address?["email"] ?? '';
        _mobileController.text = address?["contact_number"] ?? '';
        _flatController.text = address?["address_line1"] ?? '';
        _cityController.text = address?["city"] ?? '';
        _stateController.text = address?["state"] ?? '';
        _postcodeController.text = address?["postcode"] ?? '';
        _countryController.text = address?["country"] ?? '';
      });

    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider,_){
      return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
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
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF6F6F6),
                                  borderRadius: BorderRadius.circular(20.rs),
                                  border: Border.all(color: Color(0xFFEDEDED), width: 1),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 5.rw, vertical: 5.rh),
                                child: TextField(
                                  controller: _firstController,
                                  decoration: InputDecoration(
                                    hintText: 'FIRST NAME',
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
                              )
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFF6F6F6),
                                  borderRadius: BorderRadius.circular(20.rs),
                                  border: Border.all(color: Color(0xFFEDEDED), width: 1),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 5.rw, vertical: 5.rh),
                                child: TextField(
                                  controller: _lastController,
                                    decoration: InputDecoration(
                                    hintText: 'LAST NAME',
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
                              )
                            )
                          ],
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
                  padding: EdgeInsets.only(left: 80.rw, right: 80.rw, top: 30.rh, bottom: 30.rh),
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
                          'ADDRESS',
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
                          child: TextField(
                            controller: _flatController,
                            decoration: InputDecoration(
                              hintText: 'FLAT/APARTMENT/HOUSE NO',
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
                            controller: _cityController,
                            decoration: InputDecoration(
                              hintText: 'CITY/TOWN',
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
                            controller: _stateController,
                            decoration: InputDecoration(
                              hintText: 'STATE/COUNTY',
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
                            controller: _postcodeController,
                            decoration: InputDecoration(
                              hintText: 'POSTCODE',
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
                            controller: _countryController,
                            decoration: InputDecoration(
                              hintText: 'COUNTRY',
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
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 80.rw, right: 80.rw, top: 30.rh, bottom: 100.rh),
                  child: GestureDetector(
                    onTap: (){
                      if (provider.address.isEmpty || (provider.address[0]['address_line1'] ?? '').isEmpty) {
                        addAddress(provider, context);
                      } else {
                        updateAddress(provider, context);
                      }
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
                        'SAVE',
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

