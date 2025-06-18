import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'deliveryscreen/date_time_screen.dart';

class StoreLocation extends StatefulWidget {
  const StoreLocation({super.key});

  @override
  State<StoreLocation> createState() => _StoreLocationState();
}

class _StoreLocationState extends State<StoreLocation> {
  int selectedTab = 0;
  bool hasChecked = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      final text = searchController.text.toUpperCase();
      if (searchController.text != text) {
        searchController.value = searchController.value.copyWith(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(
      builder: (context, provider, _) {
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 50.rw,
                          vertical: 20.rh,
                        ),
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
          ),
        );
      },
    );
  }

  Widget _buildTabSelector() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.rw, vertical: 20.rh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => setState(() => selectedTab = 0),
            child: Container(
              decoration: BoxDecoration(
                color: selectedTab == 0 ? Color(0xFFEE2938) : Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20.rs),
                border: Border.all(color: Colors.black12, width: 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
              child: Center(
                child: Text(
                  'Open',
                  style: TextStyle(
                    color:
                        selectedTab == 0
                            ? Color(0xFFFFFFFF)
                            : Color(0xFF2D46C1),
                    fontSize: selectedTab == 0 ? 38.rt : 34.rt,
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
                color: selectedTab == 1 ? Color(0xFFEE2938) : Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20.rs),
                border: Border.all(color: Colors.black12, width: 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
              child: Center(
                child: Text(
                  'Launching Soon',
                  style: TextStyle(
                    color:
                        selectedTab == 1
                            ? Color(0xFFFFFFFF)
                            : Color(0xFF2D46C1),
                    fontSize: selectedTab == 1 ? 38.rt : 34.rt,
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
                color: selectedTab == 2 ? Color(0xFFEE2938) : Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20.rs),
                border: Border.all(color: Colors.black12, width: 1),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
              child: Center(
                child: Text(
                  'Check Postcode',
                  style: TextStyle(
                    color:
                      selectedTab == 2
                        ? Color(0xFFFFFFFF)
                        : Color(0xFF2D46C1),
                    fontSize: selectedTab == 2 ? 38.rt : 34.rt,
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

  Widget _buildTabContent(
    ShortProvider provider,
    int selectedTab,
    BuildContext context,
  ) {
    List<Map<String, dynamic>> location = provider.stores.toList();
    List<Map<String, dynamic>> store = provider.collection.toList();
    final String message = provider.text;

    switch (selectedTab) {
      case 0:
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 150.rw,
                vertical: 30.rh,
              ),
              child: Center(
                child: Text(
                  '(${provider.stores.length}) STORES ACROSS UK',
                  style: TextStyle(
                    color: Color(0xFFBABABA),
                    fontSize: 30.rt,
                    fontWeight: FontWeight.w500,
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
                          color: Color(0xFF000000),
                        ),
                      ),
                      20.verticalSpace,
                      Text(
                        'No Stores found',
                        style: TextStyle(
                          fontSize: 48.rt,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                )
                : Padding(
                  padding: EdgeInsets.only(
                    left: 100.rw,
                    right: 100.rw,
                    bottom: 40.rh,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: location.length,
                    itemBuilder: (context, index) {
                      return _buildStoreLocation(location[index], context);
                    },
                  ),
                ),
            10.verticalSpace,
          ],
        );
      case 1:
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
              child: Container(
                width: 950.rw,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(20.rs),
                  border: Border.all(
                    color: const Color(0xFFE5D9D0),
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cakes & Bakes - Orpington',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 46.rt,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    30.verticalSpace,
                    Text(
                      '284 High Street, Kent - BR6 OND',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 38.rt,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    30.verticalSpace,
                    Row(
                      children: [
                        Text(
                          'Estimated Open: ',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 38.rt,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          'May 2025',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
              child: Container(
                width: 950.rw,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(20.rs),
                  border: Border.all(
                    color: const Color(0xFFE5D9D0),
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cakes & Bakes - Kingston',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 46.rt,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    30.verticalSpace,
                    Row(
                      children: [
                        Text(
                          'Estimated Open: ',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 38.rt,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          'May 2025',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
              child: Container(
                width: 950.rw,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(20.rs),
                  border: Border.all(
                    color: const Color(0xFFE5D9D0),
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cakes & Bakes - Southall',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 46.rt,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    30.verticalSpace,
                    Row(
                      children: [
                        Text(
                          'Estimated Open: ',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 38.rt,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          'June 2025',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
              child: Container(
                width: 950.rw,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(20.rs),
                  border: Border.all(
                    color: const Color(0xFFE5D9D0),
                    width: 1,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cakes & Bakes - Stanies',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 46.rt,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    30.verticalSpace,
                    Row(
                      children: [
                        Text(
                          'Estimated Open: ',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 38.rt,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          'Coming Soon',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]
        );
      case 2:
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 80.rh),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40.rh),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.rs),
                  border: Border.all(color: Color(0xFFB8B8B8), width: 1),
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
                        final text = searchController.text;
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
            ),
            50.verticalSpace,
            hasChecked && searchController.text.isNotEmpty
                ? Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(100.rs),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 30.rw,
                    vertical: 20.rh,
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 30.rt,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
                : SizedBox.shrink(),
            50.verticalSpace,
            hasChecked && searchController.text.isNotEmpty
                ? Padding(
                  padding: EdgeInsets.only(bottom: 40.rh),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: store.length,
                    itemBuilder: (context, index) {
                      return _buildStore(store[index], context, provider);
                    },
                  ),
                )
                : SizedBox.shrink(),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }
}

Widget _buildStoreLocation(
  Map<String, dynamic> location,
  BuildContext context,
) {
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber.replaceAll(' ', ''));
    if (!await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      final fallbackUrl = Uri(
        scheme: 'tel',
        path: phoneNumber.replaceAll(' ', ''),
      );
      if (await canLaunchUrl(fallbackUrl)) {
        await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
      } else {
        print('Could not launch $phoneNumber');
      }
    }
  }

  Future<void> sendEmail(String email) async {
    final Uri uri = Uri(scheme: 'mailto', path: email.trim());

    if (!await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      final Uri uri = Uri(scheme: 'mailto', path: email.trim());
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
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
        border: Border.all(color: Color(0xFFE7E7E7), width: 1),
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
              fontWeight: FontWeight.w700,
            ),
          ),
          25.verticalSpace,
          Text(
            ('${location['address_line1']}, ${location['city']}, ${location['state']}, ${location['postcode']}'),
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 38.rt,
              fontWeight: FontWeight.w500,
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
              ),
            ),
          35.verticalSpace,
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.rs),
              border: Border.all(color: Color(0xFFBFBFBF), width: 1),
            ),
            padding: EdgeInsets.symmetric(horizontal: 100.rw, vertical: 20.rh),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                50.horizontalSpace,
                VerticalDivider(
                  color: Color(0xFF000000),
                  width: 1,
                  thickness: 1,
                ),
                50.horizontalSpace,
                GestureDetector(
                  onTap: () {
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildStore(
  Map<String, dynamic> store,
  BuildContext context,
  ShortProvider provider,
) {
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber.replaceAll(' ', ''));
    if (!await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      final fallbackUrl = Uri(
        scheme: 'tel',
        path: phoneNumber.replaceAll(' ', ''),
      );
      if (await canLaunchUrl(fallbackUrl)) {
        await launchUrl(fallbackUrl, mode: LaunchMode.externalApplication);
      } else {
        print('Could not launch $phoneNumber');
      }
    }
  }

  Future<void> sendEmail(String email) async {
    final Uri uri = Uri(scheme: 'mailto', path: email.trim());

    if (!await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      final Uri uri = Uri(scheme: 'mailto', path: email.trim());
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        print('Could not launch email client for $email');
      }
    }
  }

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 10.rh),
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(30.rs),
        border: Border.all(color: Color(0xFFE7E7E7), width: 1),
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
              fontWeight: FontWeight.w700,
            ),
          ),
          25.verticalSpace,
          Text(
            store['address'],
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 38.rt,
              fontWeight: FontWeight.w500,
            ),
          ),
          15.verticalSpace,
          Text(
            store['description'],
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 38.rt,
              fontWeight: FontWeight.w600,
            ),
          ),
          20.verticalSpace,
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.rs),
              border: Border.all(color: Color(0xFFBFBFBF), width: 1),
            ),
            padding: EdgeInsets.symmetric(horizontal: 150.rw, vertical: 15.rh),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                VerticalDivider(
                  color: Color(0xFF000000),
                  width: 20,
                  thickness: 10,
                ),
                GestureDetector(
                  onTap: () {
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          30.verticalSpace,
          GestureDetector(
            onTap: () {
              provider.selectStore(store);
              double screenWidth = MediaQuery.of(context).size.width;
              if (screenWidth > 800) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DateTimeScreen()),
                );
              } else {
                _showBottomSheet(context);
              }
            },
            child: Container(
              width: 970.rw,
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
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
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
