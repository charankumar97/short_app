import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/deliveryscreen/pickup_store_screen.dart';

class DeliveryOptionsScreen extends StatefulWidget {
  const DeliveryOptionsScreen({super.key});

  @override
  State<DeliveryOptionsScreen> createState() => _DeliveryOptionsScreenState();
}

class _DeliveryOptionsScreenState extends State<DeliveryOptionsScreen> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _){
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF0C1788),
                    Color.fromRGBO(12, 23, 136, 0.9),
                    Color.fromRGBO(12, 23, 136, 0.6),
                  ],
                  stops: [0.004, 0.344, 1.0],
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 30.rh),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    // padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
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
                            'DELIVERY OPTIONS',
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
                  Padding(
                    padding: EdgeInsets.only(top: 50.rh),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedIndex = 0;
                            });
                            double screenWidth = MediaQuery.of(context).size.width;
                            int tabIndex = 0;
                            if (screenWidth > 800) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PickupStoreScreen(selectedTab: tabIndex),
                                ),
                              );
                            } else {
                              _showBottomSheet(context, tabIndex);
                            }
                          },
                          child: Container(
                            width: 450.rw,
                            height: 505.rh,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: selectedIndex == 0?Color(0xFFFF0000):Color.fromRGBO(255, 255, 255, 0.8),
                              borderRadius: BorderRadius.circular(50.rs),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 50.rh),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/image 190.png',
                                  width: 242.rw,
                                  height: 203.rh,
                                  fit: BoxFit.contain,
                                ),
                                20.verticalSpace,
                                Text(
                                  'Pickup',
                                  style: TextStyle(
                                    color: selectedIndex == 0?Color(0xFFFFFFFF):Color(0xFF0B1156),
                                    fontSize: 50.rt,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                20.verticalSpace,
                                Text(
                                  'Click nearby stores for availability',
                                  style: TextStyle(
                                    color: selectedIndex == 0?Color(0xFFFFFFFF):Color.fromRGBO(0, 0, 0, 0.6),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 32.rt
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ),
                        40.horizontalSpace,
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedIndex = 1;
                            });
                            double screenWidth = MediaQuery.of(context).size.width;
                            int tabIndex = selectedIndex;
                            if (screenWidth > 800) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PickupStoreScreen(selectedTab: tabIndex,),
                                ),
                              );
                            } else {
                              _showBottomSheet(context, tabIndex);
                            }
                          },
                          child: Container(
                            width: 450.rw,
                            height: 505.rh,
                            decoration: BoxDecoration(
                              color: selectedIndex == 1?Color(0xFFFF0000):Color.fromRGBO(255, 255, 255, 0.8),
                              borderRadius: BorderRadius.circular(50.rs),
                            ),
                            padding: EdgeInsets.symmetric( vertical: 50.rh),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  'assets/images/Frame.svg',
                                  width: 242.rw,
                                  height: 210.rh,
                                  fit: BoxFit.contain,
                                ),
                                20.verticalSpace,
                                Text(
                                  'Delivery',
                                  style: TextStyle(
                                    color: selectedIndex == 1?Color(0xFFFFFFFF):Color(0xFF0B1156),
                                    fontSize: 50.rt,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                20.verticalSpace,
                                Text(
                                  'Confirm your address to check eligibility',
                                  style: TextStyle(
                                    color: selectedIndex == 1?Color(0xFFFFFFFF):Color.fromRGBO(0, 0, 0, 0.60),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 32.rt
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      );
    });
  }
}

void _showBottomSheet(BuildContext context, int tabIndex) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return PickupStoreScreen(selectedTab: tabIndex);
    },
  );
}
