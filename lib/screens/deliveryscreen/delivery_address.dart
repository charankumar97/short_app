import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/deliveryscreen/address_screen.dart';

class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({super.key});

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ShortProvider>(context, listen: false);
      final int userId = int.parse(provider.users[0].id);
      provider.fetchShowAddress(userId);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _) {
      List<Map<String, dynamic>> address = provider.showAddress.toList();
      return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.rs)),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 30.rh),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(100.rs),
                              border: Border.all(color: Colors.transparent, width: 1),
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
                            'SELECT DELIVERY ADDRESS',
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
                  20.verticalSpace,
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddressScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.rs),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
                        child: Text(
                            '+ ADD Address'
                        ),
                      ),
                    ),
                  ),
                  50.verticalSpace,
                  Divider(height: 1, thickness: 1, color: Color(0xFF000000),),
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                    child: Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: address.length,
                        itemBuilder: (context, index) {
                          return _buildAddress(address[index], provider);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ),
      );
    });
  }
  Widget _buildAddress(Map<String, dynamic> address, ShortProvider provider,){
    return GestureDetector(
      onTap: (){
        provider.selectedAddress(address);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
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
                      '${address['address_line1']},',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 38.rt,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    10.verticalSpace,
                    Text(
                      '${address['city']}, ${address['state']}, ${address['country']}, ${address['postcode']}',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 38.rt,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    10.verticalSpace,
                    Text(
                      '${address['contact_number']},',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontSize: 38.rt,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    10.verticalSpace,
                    Text(
                      address['email'],
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
                        // final int addressId = address['id'];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AddressScreen(address: address,),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.edit,
                        color: Color(0xFF2D46C1),
                        size: 60.rw,
                      ),
                    ),
                    50.horizontalSpace,
                    GestureDetector(
                      onTap: (){
                        final addressId = address['id'];
                        print(addressId);
                        final int userId = int.parse(provider.users[0].id);
                        print(userId);
                        if (addressId != null) {
                          provider.deleteAddressById(addressId, userId);
                        }
                      },
                      child: Icon(
                        Icons.delete,
                        color: Color(0xFFEE2938),
                        size: 60.rw,
                      ),
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}

