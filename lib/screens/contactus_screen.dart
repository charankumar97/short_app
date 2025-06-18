import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/franchise_enquiry.dart';
import 'package:short_app/screens/general_enquiry.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactusScreen extends StatefulWidget {
  const ContactusScreen({super.key});

  @override
  State<ContactusScreen> createState() => _ContactusScreenState();
}

class _ContactusScreenState extends State<ContactusScreen> {
  Future<void> sendEmail(String email) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email.trim(),
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print('Could not launch email client for $email');
    }
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
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF283277),
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
                          'CONTACT US',
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
                  padding: EdgeInsets.symmetric(horizontal: 40.rw, vertical: 30.rh),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.rs),
                          child: Image.asset(
                            'assets/images/contact-img1.png',
                            width: 570.rw,
                            height: 450.rh,
                            fit: BoxFit.cover,
                          ),
                        )
                      ),
                      20.horizontalSpace,
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.rs),
                          child: Image.asset(
                            'assets/images/contact-img2.png',
                            width: 380.rw,
                            height: 450.rh,
                            fit: BoxFit.cover,
                          ),
                        )
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.rw, vertical: 20.rh),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.rh),
                        child: Text(
                          'FOLLOW US ON',
                          style: TextStyle(
                            color: Color(0xFF283277),
                            fontSize: 36.rt,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.rh),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){},
                              child: SvgPicture.asset(
                                'assets/images/facebook.svg',
                                width: 95.rw,
                                height: 95.rh,
                                fit: BoxFit.cover,
                              ),
                            ),
                            30.horizontalSpace,
                            GestureDetector(
                              onTap: (){},
                              child: SvgPicture.asset(
                                'assets/images/instagram.svg',
                                width: 95.rw,
                                height: 95.rh,
                                fit: BoxFit.cover,
                              ),
                            ),
                            30.horizontalSpace,
                            GestureDetector(
                              onTap: (){},
                              child: SvgPicture.asset(
                                'assets/images/twitter.svg',
                                width: 95.rw,
                                height: 95.rh,
                                fit: BoxFit.cover,
                              ),
                            ),
                            30.horizontalSpace,
                            GestureDetector(
                              onTap: (){},
                              child: SvgPicture.asset(
                                'assets/images/whatsapp.svg',
                                width: 95.rw,
                                height: 95.rh,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                50.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.rw, vertical: 15.rh),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FranchiseEnquiry(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(20.rs),
                        border: Border.all(
                          color: Color(0xFFBFBFBF),
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 30.rh),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'FRANCHISE ENQUIRY',
                            style: TextStyle(
                              color: Color(0xFF283277),
                              fontSize: 38.rt,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right, size: 60.rw, color: Color(0xFF000000))
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.rw, vertical: 15.rh),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GeneralEnquiry(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(20.rs),
                        border: Border.all(
                          color: Color(0xFFBFBFBF),
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 30.rh),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ALL ENQUIRIES',
                            style: TextStyle(
                              color: Color(0xFF283277),
                              fontSize: 38.rt,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          Icon(Icons.keyboard_arrow_right, size: 60.rw, color: Color(0xFF000000))
                        ],
                      ),
                    ),
                  ),
                ),
                50.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.rw, vertical: 10.rh),
                  child: Container(
                    width: 980.rw,
                    height: 720.rh,
                    decoration: BoxDecoration(
                      color: Color(0xFFE3102C),
                      borderRadius: BorderRadius.circular(20.rs),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 50.rh),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Our phone lines are open',
                          style: TextStyle(
                            color: Color(0xFFFFBEBE),
                            fontSize: 47.rt,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        20.verticalSpace,
                        Text(
                          '020 3475 9909',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 80.rt,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        10.verticalSpace,
                        Text(
                          '079 1575 9909',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 80.rt,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        15.verticalSpace,
                        Text(
                          'Mon to Sat: 10.00am - 8.00pm Sun: 10.00am - 3.00pm',
                          style: TextStyle(
                            color: Color(0xFFFFBEBE),
                            fontSize: 46.rt,
                            fontWeight: FontWeight.w400
                          ),
                          textAlign: TextAlign.center,
                        ),
                        50.verticalSpace,
                        GestureDetector(
                          onTap: (){
                            sendEmail('hello@cakesandbakes.co.uk');
                          },
                          child: Container(
                            height: 140.rh,
                            decoration: BoxDecoration(
                              color: Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(20.rs),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 20.rh),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/mail.svg',
                                  width: 42.rw,
                                  height: 42.rh,
                                  fit: BoxFit.cover,
                                ),
                                30.horizontalSpace,
                                Text(
                                  'hello@cakesandbakes.co.uk',
                                  style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontSize: 40.rt,
                                    fontWeight: FontWeight.w600
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
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
