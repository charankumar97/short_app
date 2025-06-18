import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/models/person_model.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/profile_screen.dart';
import 'package:short_app/screens/sub_category/sup_sub_category/products/product_screen.dart';
import 'deliveryscreen/address_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
   late int selectedTab;
   @override
   void initState() {
     super.initState();
     selectedTab = 0;
   }
  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _){
      List<Person> user = provider.users.toList();
      String initials = '${user[0].firstName[0]}${user[0].firstName[5]}'.toUpperCase();
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox.expand(
                child: Image.asset('assets/images/image.png', fit: BoxFit.cover),
              ),
              Positioned(
                top: 20.rh,
                left: 0,
                right: 0,
                child: SvgPicture.asset(
                  'assets/images/account 2.svg',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(
                  'assets/images/account 1.svg',
                  width: MediaQuery.of(context).size.width,
                  height: 400.rh,
                  fit: BoxFit.cover,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.rh),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: (){Navigator.pop(context);},
                            icon: SvgPicture.asset(
                              'assets/images/Group 620.svg',
                              width: 32.rw,
                              height: 32.rh,
                              fit: BoxFit.cover,
                            )
                          ),
                          Container(
                            width: 130.rw,
                            height: 130.rh,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: AlignmentDirectional.bottomStart,
                                end: AlignmentDirectional.topEnd,
                                colors: [
                                  Color(0xFFFF50B9),
                                  Color(0xFFD30054),
                                ],
                                stops: [0.1279, 0.9049],
                                transform: GradientRotation(155 * 3.1415926535 / 180),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 8.rh),
                            child: Center(
                              child: Text(
                                initials,
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 40.rt,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                          10.horizontalSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Hi, ',
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 40.rt,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  Text(
                                    user[0].firstName,
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontSize: 40.rt,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ],
                              ),
                              5.verticalSpace,
                              Text(
                                '${user[0].mobile} | ${user[0].email}',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 40.rt,
                                  fontWeight: FontWeight.w400,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(),
                                ),
                              );
                            },
                            child: Container(
                              width: 125.rw,
                              height: 60.rh,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.rs),
                                border: Border.all(
                                  color: Color.fromRGBO(255, 255, 255, 0.5),
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 8.rh),
                              child: Text(
                                'EDIT',
                                style: TextStyle(
                                  color: Color(0xFF97BCFF),
                                  fontSize: 30.rt,
                                  fontWeight: FontWeight.w400
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 30.rh),
                      child: Container(
                        width: 948.rw,
                        height: 120.rh,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.rs),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 100.rw, vertical: 10.rh),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(2, (index){
                            final labels = ['ORDERS', 'ADDRESSES'];
                            return Padding(
                              padding: EdgeInsets.only(right: 20.rw),
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectedTab = index;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFFFFF),
                                    borderRadius: BorderRadius.circular(20.rs),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 80.rw, vertical: 20.rh),
                                  child: Text(
                                    labels[index],
                                    style: TextStyle(
                                      color: Color(0xFF1E4489),
                                      fontSize: 36.rt,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    _buildTabContent(provider),
                  ],
                ),
              ),
            ],
          ),
        )
      );
    });
  }
  Widget _buildTabContent(ShortProvider provider) {
     List<Map<String, dynamic>> address = provider.showAddress.toList();
     List<Map<String, dynamic>> order = provider.orders.toList();
     List<Map<String, dynamic>> bestSeller = provider.bestSellers.toList();
     switch(selectedTab){
       case 0: return Column(
         children: [
           order.isEmpty
               ?Container(
             width: 978.rw,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(30.rs),
               boxShadow: [
                 BoxShadow(
                   color: Colors.black.withOpacity(0.05),
                   offset: Offset(8, 8),
                   blurRadius: 10,
                 ),
               ],
             ),
             child: Column(
               children: [
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                         'NO ORDERS YET? \n LET’S FIX THAT!',
                         style: TextStyle(
                           color: Color(0xFFEE2938),
                           fontSize: 50.rt,
                           fontWeight: FontWeight.w600
                         ),
                       ),
                     ],
                   ),
                 ),
                 Divider(height: 1, thickness: 1, color: Color(0xFFD3D3D3)),
                 Padding(
                   padding: EdgeInsets.symmetric(vertical: 50.rh),
                   child: Column(
                     children: [
                       Text(
                         'TRY OUR BEST SELLING IRRESISTIBLE CAKES',
                         style: TextStyle(
                           color: Color(0xFF1E4489),
                           fontSize: 36.rt,
                           fontWeight: FontWeight.w700
                         ),
                         textAlign: TextAlign.center,
                       ),
                       30.verticalSpace,
                       SizedBox(
                         height: 505.rh,
                         child: ListView.builder(
                           scrollDirection: Axis.horizontal,
                           itemCount: bestSeller.length,
                           itemBuilder: (context, index) {
                             return _buildItem(
                               bestSeller[index],
                               provider,
                               context,
                             );
                           },
                         ),
                       ),
                     ],
                   ),
                 )
               ],
             ),
           )
               :ListView.builder(
             shrinkWrap: true,
             physics: const NeverScrollableScrollPhysics(),
             itemCount: order.length,
             itemBuilder: (context, index) {
               final data = order[index];
               return Padding(
                 padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 10.rh),
                 child: Container(
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(30.rs),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black.withOpacity(0.05),
                         offset: Offset(8, 8),
                         blurRadius: 10,
                       ),
                     ],
                   ),
                   padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 50.rh),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Expanded(
                         flex: 2,
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               '${data['title']},',
                               style: TextStyle(
                                 color: Color(0xFF000000),
                                 fontSize: 38.rt,
                                 fontWeight: FontWeight.w500
                               ),
                             ),
                             10.verticalSpace,
                             Text(
                               data['sku'],
                               style: TextStyle(
                                 color: Color(0xFF000000),
                                 fontSize: 38.rt,
                                 fontWeight: FontWeight.w500
                               ),
                             ),
                             10.verticalSpace,
                             Text(
                               '${data['sell_price']},',
                               style: TextStyle(
                                 color: Color(0xFF000000),
                                 fontSize: 38.rt,
                                 fontWeight: FontWeight.w500
                               ),
                             ),
                             10.verticalSpace,
                             Text(
                               data['image'],
                               style: TextStyle(
                                 color: Color(0xFF000000),
                                 fontSize: 38.rt,
                                 fontWeight: FontWeight.w500
                               ),
                             )
                           ],
                         )
                       ),
                     ],
                   ),
                 ),
               );
             },
           ),
         ],
       );
       case 1: return Column(
         children: [
           ListView.builder(
             shrinkWrap: true,
             physics: const NeverScrollableScrollPhysics(),
             itemCount: address.length,
             itemBuilder: (context, index) {
               final data = address[index];
               return Padding(
                 padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 10.rh),
                 child: Container(
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(30.rs),
                     boxShadow: [
                       BoxShadow(
                         color: Colors.black.withOpacity(0.05),
                         offset: Offset(8, 8),
                         blurRadius: 10,
                       ),
                     ],
                   ),
                   padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 50.rh),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Expanded(
                         flex: 1,
                         child: Container(
                           width: 90.rw,
                           height: 90.rh,
                           decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             color: Color(0xFFDC2328)
                           ),
                           child: Center(
                             child: SvgPicture.asset(
                               'assets/images/home.svg',
                               width: 60.rw,
                               height: 60.rh,
                               colorFilter: ColorFilter.mode(Color(0xFFFFFFFF),BlendMode.srcIn),
                               fit: BoxFit.contain,
                             ),
                           ),
                         ),
                       ),
                       Expanded(
                         flex: 2,
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               '${data['address_line1']},',
                               style: TextStyle(
                                 color: Color(0xFF000000),
                                 fontSize: 38.rt,
                                 fontWeight: FontWeight.w500
                               ),
                             ),
                             10.verticalSpace,
                             Text(
                               '${data['city']}, ${data['state']}, ${data['country']}, ${data['postcode']}',
                               style: TextStyle(
                                 color: Color(0xFF000000),
                                 fontSize: 38.rt,
                                 fontWeight: FontWeight.w500
                               ),
                             ),
                             10.verticalSpace,
                             Text(
                               '${data['contact_number']},',
                               style: TextStyle(
                                 color: Color(0xFF000000),
                                 fontSize: 38.rt,
                                 fontWeight: FontWeight.w500
                               ),
                             ),
                             10.verticalSpace,
                             Text(
                               data['email'],
                               style: TextStyle(
                                 color: Color(0xFF000000),
                                 fontSize: 38.rt,
                                 fontWeight: FontWeight.w500
                               ),
                             )
                           ],
                         )
                       ),
                       Expanded(
                         flex: 1,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             GestureDetector(
                               onTap: (){
                                 Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                     builder: (_) => AddressScreen(address: data,),
                                   ),
                                 );
                               },
                               child: Text(
                                 'EDIT',
                                 style: TextStyle(
                                   color: Color(0xFF2F80ED),
                                   fontSize: 36.rt,
                                   fontWeight: FontWeight.w500
                                 ),
                               ),
                             ),
                           ],
                         )
                       )
                     ],
                   ),
                 ),
               );
             },
           ),
           80.verticalSpace,
           GestureDetector(
             onTap: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (_) => AddressScreen(),
                 ),
               );
             },
             child: Container(
               width: 978.rw,
               height: 100.rh,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(30.rs),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black.withOpacity(0.05),
                     offset: Offset(8, 8),
                     blurRadius: 10,
                   ),
                 ],
               ),
               padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   SvgPicture.asset(
                     'assets/images/Vector(3).svg',
                     width: 35.rw,
                     height: 34.rh,
                     fit: BoxFit.cover,
                   ),
                   20.horizontalSpace,
                   Text(
                     'ADD NEW ADDRESS',
                     style: TextStyle(
                       color: Color(0xFF2D46C1),
                       fontSize: 38.rt,
                       fontWeight: FontWeight.w500
                     ),
                   )
                 ],
               ),
             ),
           )
         ],
       );
       default: return SizedBox.shrink();
     }
   }
}

Widget _buildItem(Map<String, dynamic> bestSeller, ShortProvider provider, BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.rw,),
    child: Container(
      width: 400.rw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.rs),
        color: Color(0xFFFFFFFF),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 8.rh),
      child: GestureDetector(
        onTap: () async {
          final int? id = bestSeller['id'];
          print(id);
          if(id != null){
            provider.fetchCakeSizes(id);
            provider.fetchSponges(id);
            provider.fetchFilling(id);
            provider.fetchDescription(id);
            provider.selectedProduct(bestSeller);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductScreen(),
              ),
            );
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Invalid ID')),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.rs),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.rs),
                  child: Image.network(
                    bestSeller['image'],
                    width: 350.rw,
                    height: 300.rh,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            20.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.rh),
              child: Text(
                bestSeller['title'],
                style: TextStyle(
                  color: Color(0xFF1E4489),
                  fontSize: 30.rt,
                  fontWeight: FontWeight.w600
                ),
                textAlign: TextAlign.start,
              ),
            ),
            20.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.rh),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '£${bestSeller['final_price']}',
                    style: TextStyle(
                      color: Color(0xFFEE2938),
                      fontSize: 30.rt,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Container(
                    width: 40.rw,
                    height: 40.rh,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEF3645),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Color(0xFFFFFFFF),
                        size: 30.rt,
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
  );
}