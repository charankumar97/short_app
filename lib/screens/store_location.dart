import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/home_screen.dart';
import 'package:short_app/screens/search_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cart_screen.dart';
import 'category_screen.dart';

class StoreLocation extends StatefulWidget {
  const StoreLocation({super.key});

  @override
  State<StoreLocation> createState() => _StoreLocationState();
}

class _StoreLocationState extends State<StoreLocation> {
  int _currentIndex = 2;
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
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
                      padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rh),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Our Stores',
                            style: TextStyle(
                              color: Color(0xFF283577),
                              fontSize: 50.rt,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Image.asset(
                            'assets/images/franchises.png',
                            width: 350.rw,
                            height: 350.rh,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                    _buildTabSelector(),
                    Divider(
                      color: Color(0xFFE6E6E6),
                      thickness: 1,
                      height: 20.rh,
                    ),
                    _buildTabContent(provider, selectedTab, context),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0, -15),
                    blurRadius: 40,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                backgroundColor: Color(0xFFFFFFFF),
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Color.fromRGBO(238, 41, 56, 0.8),
                unselectedItemColor: Color.fromRGBO(0, 0, 0, 0.5),
                selectedLabelStyle: TextStyle(
                  fontSize: 25.rt,
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(238, 41, 56, 0.8),
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 25.rt,
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }
                  if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryScreen(),
                      ),
                    );
                  }
                  if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoreLocation(),
                      ),
                    );
                  }
                  if (index == 3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ),
                    );
                  }
                  if (index == 4) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ),
                    );
                  }
                },
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/images/home.svg',
                      width: 70.rw,
                      height: 70.rh,
                      colorFilter: ColorFilter.mode(_currentIndex == 0 ? Color.fromRGBO(238, 41, 56, 0.8):Color.fromRGBO(0, 0, 0, 0.5),BlendMode.srcIn),
                    ),
                    label: 'HOME',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/images/cake.svg',
                      width: 70.rw,
                      height: 70.rh,
                      colorFilter: ColorFilter.mode(_currentIndex == 1 ? Color.fromRGBO(238, 41, 56, 0.8):Color.fromRGBO(0, 0, 0, 0.5),BlendMode.srcIn),
                    ),
                    label: 'CAKES',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/images/store.svg',
                      width: 70.rw,
                      height: 70.rh,
                      colorFilter: ColorFilter.mode(_currentIndex == 2 ? Color.fromRGBO(238, 41, 56, 0.8):Color.fromRGBO(0, 0, 0, 0.5),BlendMode.srcIn),
                    ),
                    label: 'STORES',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/images/basket.svg',
                      width: 70.rw,
                      height: 70.rh,
                      colorFilter: ColorFilter.mode(_currentIndex == 3 ? Color.fromRGBO(238, 41, 56, 0.8):Color.fromRGBO(0, 0, 0, 0.5),BlendMode.srcIn),
                    ),
                    label: 'BASKET',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/images/magnifier.svg',
                      width: 70.rw,
                      height: 70.rh,
                      colorFilter: ColorFilter.mode(_currentIndex == 4 ? Color.fromRGBO(238, 41, 56, 0.8):Color.fromRGBO(0, 0, 0, 0.5),BlendMode.srcIn),
                    ),
                    label: 'SEARCH',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
  Widget _buildTabSelector(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.rw, vertical: 20.rh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => setState(() => selectedTab = 0),
            child: Container(
              decoration: BoxDecoration(
                color: selectedTab == 0 ? Color(0xFFEE2938): Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20.rs),
                border: Border.all(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
              child: Center(
                child: Text(
                  'Open',
                  style: TextStyle(
                    color: selectedTab == 0 ? Color(0xFFFFFFFF) : Color(0xFF2D46C1),
                    fontSize: selectedTab == 0 ? 38.rt: 34.rt,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          30.horizontalSpace,
          GestureDetector(
            onTap: () => setState(() => selectedTab = 1),
            child: Container(
              decoration: BoxDecoration(
                color: selectedTab == 1 ? Color(0xFFEE2938): Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20.rs),
                border: Border.all(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
              child: Center(
                child: Text(
                  'Launching Soon',
                  style: TextStyle(
                    color: selectedTab == 1 ? Color(0xFFFFFFFF) : Color(0xFF2D46C1),
                    fontSize: selectedTab == 1 ? 38.rt: 34.rt,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          30.horizontalSpace,
          GestureDetector(
            onTap: () => setState(() => selectedTab = 2),
            child: Container(
              decoration: BoxDecoration(
                color: selectedTab == 2 ? Color(0xFFEE2938): Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20.rs),
                border: Border.all(
                  color: Colors.black12,
                  width: 1,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
              child: Center(
                child: Text(
                  'Check Postcode',
                  style: TextStyle(
                    color: selectedTab == 2 ? Color(0xFFFFFFFF) : Color(0xFF2D46C1),
                    fontSize: selectedTab == 2 ? 38.rt: 34.rt,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildTabContent(ShortProvider provider, int selectedTab, BuildContext context) {
  List<Map<String, dynamic>> location = provider.stores.toList();
  final TextEditingController searchController = TextEditingController();
  switch(selectedTab){
    case 0: return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 150.rw, vertical: 30.rh),
          child: Center(
            child: Text(
              '(${provider.stores.length}) STORES ACROSS UK',
              style: TextStyle(
                color: Color(0xFFBABABA),
                fontSize: 30.rt,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        ),
        location.isEmpty
            ? SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Oops!',
                style: TextStyle(
                  fontSize: 80.rt,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF000000)
                ),
              ),
              20.verticalSpace,
              Text(
                'No Stores found',
                style: TextStyle(
                  fontSize: 48.rt,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF000000)
                ),
              )
            ],
          ),
        )
            : Padding(
          padding: EdgeInsets.only(left: 100.rw, right: 100.rw, bottom: 40.rh),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: location.length,
            itemBuilder: (context, index) {
              return _buildStoreLocation(
                location[index],
                context,
              );
            },
          ),
        ),
        10.verticalSpace,
      ],
    );
    case 1: return Column(
      children: [

      ],
    );
    case 2: return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 80.rh),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.rh),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.rs),
              border: Border.all(
                color: Color(0xFFB8B8B8),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontSize: 40.rt,
                      fontWeight: FontWeight.w500,
                    ),
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter postcode',
                      hintStyle: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 40.rt,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final text = searchController.text.toUpperCase();
                    final isValid = RegExp(
                      r"^[A-Z]{1,2}[0-9][0-9A-Z]?\s?[0-9][A-Z]{2}$",
                      caseSensitive: false,
                    ).hasMatch(text);
                    if(isValid){

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
        ),
      ],
    );
    default: return SizedBox.shrink();
  }
}

Widget _buildStoreLocation(Map<String, dynamic> location, BuildContext context){
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
        borderRadius: BorderRadius.circular(20.rs),
        border: Border.all(
          color: Color(0xFFE7E7E7),
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 40.rh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            location['title'],
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 46.rt,
              fontWeight: FontWeight.w700
            ),
          ),
          25.verticalSpace,
          Text(
            ('${location['address_line1']}, ${location['city']}, ${location['state']}, ${location['postcode']}'),
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 38.rt,
              fontWeight: FontWeight.w500
            ),
          ),
          35.verticalSpace,
          if (location['time'] != null && location['time'].isNotEmpty)
            ...List.generate(
              location['time'].length > 3 ? 3 : location['time'].length,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 15.rh),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${location['time'][index]['title'] ?? ''} :',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 38.rt,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    10.horizontalSpace,
                    Text(
                      '${location['time'][index]['timings'] ?? ''}',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 36.rt,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            ),
          35.verticalSpace,
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.rs),
              border: Border.all(
                color: Color(0xFFBFBFBF),
                width: 1,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 100.rw, vertical: 20.rh),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    makePhoneCall(location['contact_number']);
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
                50.horizontalSpace,
                VerticalDivider(color: Color(0xFF000000), width: 1, thickness: 1),
                50.horizontalSpace,
                GestureDetector(
                  onTap: (){
                    sendEmail(location['email']);
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
                // 50.horizontalSpace,
                // VerticalDivider(color: Color(0xFFE6E6E6), width: 1, thickness: 1,),
                // 50.horizontalSpace,
                // GestureDetector(
                //   onTap: (){},
                //   child: Row(
                //     children: [
                //       SvgPicture.asset(
                //         'assets/images/store1.svg',
                //         width: 50.rw,
                //         height: 50.rh,
                //       ),
                //       15.horizontalSpace,
                //       Text(
                //         'Info',
                //         style: TextStyle(
                //           color: Color(0xFF000000),
                //           fontSize: 36.rt,
                //           fontWeight: FontWeight.w500
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}