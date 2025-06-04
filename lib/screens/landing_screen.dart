import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:short_app/screens/login_screen.dart';
import 'package:short_app/screens/register_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0C1788),
      body: SafeArea(
        child: Column(
          children: [
            80.verticalSpace,
            Center(
              child: Text(
                'OUR CREATIONS \n FOR YOUR CELEBRATIONS',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w700,
                  fontSize: 60.rt,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            80.verticalSpace,
            SizedBox(
              width: 1080.rw,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  30.verticalSpace,
                  SizedBox(
                    width: 550.rw,
                    height: 650.rh,
                    child: Image.asset('assets/images/IMG_3136 1.png', fit: BoxFit.fill),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      'assets/images/cake-slice.png',
                      width: 192.rw,
                      height: 214.rh,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/image 84.png',
                      width: 195.rw,
                      height: 214.rh,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      'assets/images/image 91.png',
                      width: 195.rw,
                      height: 214.rh,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 0,
                    child: Image.asset(
                      'assets/images/orie.png',
                      width: 190.rw,
                      height: 104.rh,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 80,
                    child: SvgPicture.asset(
                      'assets/images/Soft Star.svg',
                      width: 80.rw,
                      height: 80.rh,
                    ),
                  ),
                  Positioned(
                    top: 70,
                    left: 70,
                    child: SvgPicture.asset(
                      'assets/images/Soft Star.svg',
                      width: 80.rw,
                      height: 80.rh,
                    ),
                  ),
                  Positioned(
                    top: 120,
                    right: 70,
                    child: Image.asset(
                      'assets/images/cnb-stamp 1.png',
                      width: 180.rw,
                      height: 180.rh,
                    ),
                  ),
                ],
              ),
            ),
            150.verticalSpace,
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
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
                  'Log in with Email',
                  style: TextStyle(
                    color: Color(0xFF8001D3),
                    fontSize: 54.rt,
                    fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.center,
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
        )
      ),
    );
  }
}
