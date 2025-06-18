import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/cart_screen.dart';
import 'package:short_app/screens/sub_category/sup_sub_category/products/pop_screens/description_popup.dart';
import '../../../../models/product_model.dart';
import '../../../account_screen.dart';
import '../../../search_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _controller = TextEditingController();
  final int _maxLength = 40;
  int sizeIndex = -1;
  int spongeIndex = -1;
  int fillingIndex = -1;
  String selectedSizeTitle = '';
  String selectedSpongeTitle = '';
  String selectedFillingTitle = '';
  String message = '';
  int? selectedSizeId;
  int? selectedSpongeId;
  int? selectedFillingId;
  int? selectedProductId;
  bool sizeError = false;
  bool spongeError = false;
  bool fillingError = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _){
      Map<String, dynamic> item = provider.selectProduct;
      List<Map<String, dynamic>> size = provider.cakeSize.toList();
      List<Map<String, dynamic>> sponge = provider.sponges.toList();
      List<Map<String, dynamic>> fill = provider.filling.toList();
      List<Map<String, dynamic>> ingredients = provider.ingredients.toList();
      final int itemCount = provider.selectProduct['sku'] == item['sku']
          ? provider.selectProduct['qty'] ?? 1
          : 0;
      final selectedProductId = item['id'];
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    item.isNotEmpty
                        ? Image.network(
                      item['image'],
                      width: double.infinity,
                      height: 1080.rh,
                      fit: BoxFit.cover,
                    )
                        : SizedBox(
                      height: 1080.rh,
                      width: double.infinity,
                      child: Container(color: Colors.grey.shade200),
                    ),
                    Positioned(
                      top: 50.rh,
                      left: 30.rw,
                      right: 30.rw,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 330.rw,
                            height: 130.rh,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100.rs),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(250, 18, 40, 0.15),
                                  offset: Offset(0, 4),
                                  blurRadius: 50,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 10.rh),
                            child: TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                                provider.clearSelectedSizePrice();
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
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100.rs),
                                  border: Border.all(color: Colors.white, width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(250, 18, 40, 0.15),
                                      offset: Offset(0, 4),
                                      blurRadius: 50,
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SearchScreen(showBackButton: true),
                                      ),
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/images/magnifier.svg',
                                    width: 59.rw,
                                    height: 59.rh,
                                    colorFilter: ColorFilter.mode(Color(0xFFEE2938), BlendMode.srcIn),
                                  ),
                                ),
                              ),
                              30.horizontalSpace,
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFDEDE),
                                  borderRadius: BorderRadius.circular(100.rs),
                                  border: Border.all(color: Color(0xFFFFDEDE), width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(250, 18, 40, 0.15),
                                      offset: Offset(0, 4),
                                      blurRadius: 50,
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => AccountScreen()),
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/images/user.svg',
                                    width: 59.rw,
                                    height: 59.rh,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFF0C1788),
                        width: 2,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 50.rh),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SKU: ${item['sku']}',
                        style: TextStyle(
                          color: const Color.fromRGBO(40, 53, 119, 0.6),
                          fontSize: 28.rt,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        item['title'],
                        style: TextStyle(
                          color: const Color(0xFF283577),
                          fontSize: 60.rt,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        '£${item['final_price']}',
                        style: TextStyle(
                          color: const Color(0xFFEF3645),
                          fontSize: 60.rt,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      20.verticalSpace,
                      SizedBox(
                        height: 130.rh,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(right: 80.rw),
                          itemCount: ingredients.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(right: 20.rw),
                              child: _buildIngredients(ingredients[index]),
                            );
                          },
                        ),
                      ),
                      30.verticalSpace,
                      Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              double screenWidth = MediaQuery.of(context).size.width;
                              int tabIndex = 0;
                              if (screenWidth > 800) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DescriptionPopup(selectedTab: tabIndex),
                                  ),
                                );
                              } else {
                                _showBottomSheet(context, tabIndex);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.rs),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    offset: Offset(4, 4),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 40.rw, vertical: 30.rh),
                              child: Text(
                                'Description',
                                style: TextStyle(
                                    color: Color(0xFF2D46C1),
                                    fontSize: 34.rt,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                          ),
                          10.horizontalSpace,
                          GestureDetector(
                            onTap: (){
                              double screenWidth = MediaQuery.of(context).size.width;
                              int tabIndex = 1;
                              if (screenWidth > 800) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DescriptionPopup(selectedTab: tabIndex),
                                  ),
                                );
                              } else {
                                _showBottomSheet(context, tabIndex);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.rs),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    offset: Offset(4, 4),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 40.rw, vertical: 30.rh),
                              child: Text(
                                'Ingredients',
                                style: TextStyle(
                                    color: Color(0xFF2D46C1),
                                    fontSize: 34.rt,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                          ),
                          10.horizontalSpace,
                          GestureDetector(
                            onTap: (){
                              double screenWidth = MediaQuery.of(context).size.width;
                              int tabIndex = 2;
                              if (screenWidth > 800) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DescriptionPopup(selectedTab: tabIndex),
                                  ),
                                );
                              } else {
                                _showBottomSheet(context, tabIndex);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.rs),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    offset: Offset(4, 4),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 40.rw, vertical: 30.rh),
                              child: Text(
                                'Disclaimer',
                                style: TextStyle(
                                    color: Color(0xFF2D46C1),
                                    fontSize: 34.rt,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6FF),
                    borderRadius: BorderRadius.circular(20.rs),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        offset: Offset(0, 0),
                        blurRadius: 0,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'CAKE SIZE*',
                              style: TextStyle(
                                color: Color(0xFF283577),
                                fontSize: 30.rt,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              '${provider.cakeSize.length} Sizes Available',
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                                fontSize: 30.rt,
                                fontWeight: FontWeight.w500
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 320.rh,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 30.rw),
                          itemCount: size.length,
                          itemBuilder: (context, index) {
                            final cakeSize = size[index];
                            final isSelected = index == sizeIndex;
                            return Padding(
                            padding: EdgeInsets.only(right: 20.rw),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  sizeIndex = index;
                                  selectedSizeTitle = cakeSize['title'];
                                  selectedSizeId = cakeSize['id'];
                                  sizeError = false;
                                });
                              },
                              child: Container(
                                width: 420.rw,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.rs),
                                  border: Border.all(
                                    color: isSelected ? Color(0xFFD41F36) : Color(0xFFB8B8B8),
                                    width: 1,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 15.rh),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.network(
                                      cakeSize['image_url'],
                                      width: 150.rw,
                                      height: 150.rh,
                                      fit: BoxFit.cover,
                                    ),
                                    20.verticalSpace,
                                    Text(
                                      cakeSize['title'],
                                      style: TextStyle(
                                        fontSize: 40.rt,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF000000)
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                          },
                        ),
                      ),
                      if (sizeError)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 10.rh),
                          child: Text(
                            'Please select a Size option.',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 36.rt,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                20.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6FF),
                    borderRadius: BorderRadius.circular(20.rs),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        offset: Offset(0, 0),
                        blurRadius: 0,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'SPONGE*',
                              style: TextStyle(
                                color: Color(0xFF283577),
                                fontSize: 30.rt,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: sponge.length,
                          itemBuilder: (context, index) {
                            final spong = sponge[index];
                            final isSelected = index == spongeIndex;
                            final title = spong['title']?.toString().toLowerCase() ?? '';
                            final isEggless = title.contains('eggless');
                            final image = isEggless ? provider.image['eggless'] : provider.image['egg'];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 20.rh),
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    spongeIndex = index;
                                    selectedSpongeTitle= spong['title'];
                                    selectedSpongeId = spong['id'];
                                    spongeError = false;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.rs),
                                    border: Border.all(
                                      color: isSelected ? Color(0xFFFFED32) : Color(0xFFB8B8B8),
                                      width: 1,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 15.rh),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 70.rw,
                                        height: 70.rh,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.black26),
                                        ),
                                        child: isSelected ? Icon(Icons.check, color: Color(0xFFEF3645),size: 50.rw,): null,
                                      ),
                                      20.horizontalSpace,
                                      Expanded(
                                        flex: 4,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              spong['title'],
                                              style: TextStyle(
                                                color: Color(0xFF000000),
                                                fontSize: 40.rt,
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                            SvgPicture.network(
                                              image,
                                              width: 35.rw,
                                              height: 50.rh,
                                              fit: BoxFit.cover,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      if (spongeError)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 10.rh),
                          child: Text(
                            'Please select a sponge option.',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 36.rt,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                20.verticalSpace,
                fill.isNotEmpty
                    ? Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6FF),
                    borderRadius: BorderRadius.circular(20.rs),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        offset: Offset(0, 0),
                        blurRadius: 0,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'FILLING*',
                              style: TextStyle(
                                color: Color(0xFF283577),
                                fontSize: 30.rt,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: fill.length,
                          itemBuilder: (context, index) {
                            final filling = fill[index];
                            final isSelected = index == fillingIndex;
                            return Padding(
                              padding: EdgeInsets.only(bottom: 20.rh),
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    fillingIndex = index;
                                    selectedFillingTitle = filling['title'];
                                    selectedFillingId = filling['id'];
                                    fillingError = false;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.rs),
                                    border: Border.all(
                                      color: isSelected ? Color(0xFFFFED32) : Color(0xFFB8B8B8),
                                      width: 1,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 15.rh),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 70.rw,
                                        height: 70.rh,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.black26),
                                        ),
                                        child: isSelected ? Icon(Icons.check, color: Color(0xFFEF3645),size: 50.rw,): null,
                                      ),
                                      50.horizontalSpace,
                                      Text(
                                        filling['title'],
                                        style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 40.rt,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      if (fillingError)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 10.rh),
                          child: Text(
                            'Please select a filling option.',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 36.rt,
                            ),
                          ),
                        ),
                    ],
                  ),
                )
                    :SizedBox.shrink(),
                20.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6FF),
                    borderRadius: BorderRadius.circular(20.rs),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        offset: Offset(0, 0),
                        blurRadius: 0,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'MESSAGE*',
                              style: TextStyle(
                                color: Color(0xFF283577),
                                fontSize: 30.rt,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              '${_controller.text.length}/$_maxLength characters only',
                              style: TextStyle(
                                color: Color(0xFF283577),
                                fontSize: 30.rt,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextField(
                        controller: _controller,
                        maxLength: _maxLength,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 36.rt,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF7A7A9D),
                        ),
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: 'Message you would like on the cake',
                          hintStyle: TextStyle(
                            color: Color(0xFF7A7A9D),
                            fontSize: 36.rt,
                            fontWeight: FontWeight.w500
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 15.rh),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.rs),
                            borderSide: const BorderSide(color: Color(0xFFB8B8B8)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.rs),
                            borderSide: const BorderSide(color: Color(0xFFB8B8B8)),
                          ),
                        ),
                        onChanged: (val) => setState(() {message = val;}),
                      ),
                    ],
                  ),
                ),
                50.verticalSpace,
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Container(
              height: 420.rh,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20.rs),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    offset: Offset(0, 0),
                    blurRadius: 0,
                    spreadRadius: 2,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6FF),
                      borderRadius: BorderRadius.circular(40.rs),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Text(
                                '($itemCount) ADDED',
                                style: TextStyle(
                                  color: Color(0xFF0B1156),
                                  fontSize: 40.rt,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              10.horizontalSpace,
                              VerticalDivider(
                                width: 2,
                                thickness: 1,
                                color: Color(0xFF0B1156),
                              ),
                              10.horizontalSpace,
                              Text(
                                '£${provider.itemTotal}',
                                style: TextStyle(
                                  color: Color(0xFF1C2040),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 40.rt,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.rs),
                            border: Border.all(
                              color: Color(0xFFDDDDDD),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.remove_outlined,
                                    size: 50.rw,
                                    color: Color(0xFFEE2938),
                                  ),
                                  onPressed: itemCount > 1 ? () {
                                    provider.decrementQty();
                                  } : null,
                                ),
                                Text(
                                  itemCount.toString(),
                                  style: TextStyle(
                                    fontSize: 35.rt,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF0B1156),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.add_outlined,
                                    size: 50.rw,
                                    color: Color(0xFFEE2938),
                                  ),
                                  onPressed: () {
                                    provider.incrementQty();
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.rw),
                    child: GestureDetector(
                      onTap: () {
                        final hasSize = selectedSizeId != null;
                        final hasSponge = selectedSpongeId != null;
                        final hasFilling = selectedFillingId != null;

                        setState(() {
                          sizeError = !hasSize;
                          spongeError = !hasSponge;
                          fillingError = !hasFilling;
                        });

                        if (hasSize && hasSponge && hasFilling) {
                          final sizeTitle = selectedSizeTitle;
                          final spongTitle = selectedSpongeTitle;
                          final fillTitle = selectedFillingTitle;
                          final text = message;
                          final sizeId = selectedSizeId;
                          final spongeId = selectedSpongeId;
                          final fillingId = selectedFillingId;
                          final productId = selectedProductId;

                          provider.selectedItemId(sizeId!, spongeId!, fillingId!, productId!);
                          provider.selectedItem(sizeTitle, spongTitle, fillTitle, text);
                          provider.fetchProductPrice();

                          final product = Product(
                            title: item['title'],
                            sellPrice: item['sell_price'].toDouble(),
                            id: item['id'],
                            sku: item['sku'],
                            qty: itemCount,
                            total: item['final_price'],
                            finalPrice: item['final_price'],
                            image: item['image'],
                          );

                          provider.addProducts(product);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartScreen(showBackButton: true)),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.black, Color(0xFF3A3A3A)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'PROCEED TO CHECKOUT',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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


Widget _buildIngredients(Map<String, dynamic> ingredient) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(60.rs),
    ),
    padding: EdgeInsets.symmetric(horizontal: 15.rw, vertical: 10.rh),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          ingredient['image_url'] ,
          width: 60.rw,
          height: 60.rh,
          fit: BoxFit.contain,
        ),
        Center(
          child: Text(
            ingredient['title'],
            style: TextStyle(
              color: Color(0xFF283577),
              fontSize: 30.rt,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

void _showBottomSheet(BuildContext context, int tabIndex) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Color(0xFFFACFCF),
    builder: (BuildContext context) {
      return DescriptionPopup(selectedTab: tabIndex,);
    },
  );
}