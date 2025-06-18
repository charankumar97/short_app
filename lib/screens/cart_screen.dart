import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/delivery_options_screen.dart';
import 'package:short_app/screens/empty_cart_screen.dart';
import 'package:short_app/screens/sub_category/accessories_screen.dart';
import '../models/product_model.dart';

class CartScreen extends StatefulWidget {
  final bool showBackButton;
  const CartScreen({super.key, this.showBackButton = false});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> categories = [
    {'id': '153', 'title': 'Balloons'},
    {'id': '154', 'title': 'Candles'},
    {'id': '184', 'title': 'Balloon Weights'},
    {'id': '188', 'title': 'Toppers'},
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _){
      final List<Product> cartProduct = provider.cartProducts.toList();
      List<Map<String, dynamic>> item = provider.products.toList();
      return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: cartProduct.isEmpty
            ? EmptyCartScreen()
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF283277),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if(widget.showBackButton)
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
                          'CART',
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
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFDBE5FF),
                        Color(0xFFDBE5FF),
                      ],
                      stops: [0.3396, 0.7651],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 45.rw,top : 20.rh, bottom: 10.rh),
                    child: Text(
                      'YOUR CART',
                      style: TextStyle(
                          color: Color(0xFF283577),
                          fontSize: 40.rt,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ),
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartProduct.length,
                    itemBuilder: (context, index){
                      return _buildItems(cartProduct[index], provider,context);
                    }
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6FF),
                    borderRadius: BorderRadius.circular(20.rs),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 50.rh),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'PARTY ACCESSORIES',
                          style: TextStyle(
                              color: Color(0xFF0B1156),
                              fontSize: 46.rt,
                              fontWeight: FontWeight.w700
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        'Now that you have selected your celebration cake, Let’s make you occasion more special with our party decorations.',
                        style: TextStyle(
                          color: Color.fromRGBO(40, 53, 119, 0.6),
                          fontSize: 30.rt,
                          fontWeight: FontWeight.w400,

                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.rh),
                        child: SizedBox(
                          height: 100.rh,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 30.rw),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 20.rw),
                                child: _buildCategory(categories[index], context, provider, index),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.rh),
                        child: SizedBox(
                          height: 505.rh,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            // padding: EdgeInsets.symmetric(horizontal: 20.rw),
                            itemCount: item.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 0.rw),
                                child: _buildAccessories(item[index], context, provider),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.rs),
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccessoriesScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'SEE ALL(${item.length})',
                            style: TextStyle(
                                color: Color(0xFF2D46C1),
                                fontSize: 30.rt,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 50.rh),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFF0007),
                      borderRadius: BorderRadius.circular(30.rs),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 130.rw, vertical: 40.rh),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeliveryOptionsScreen(),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          'CHOOSE DELIVERY OPTIONS',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 50.rt,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

Widget _buildItems(Product cartProduct, ShortProvider provider, BuildContext context){
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFDBE5FF),
          Color(0xFFDBE5FF),
        ],
        stops: [0.3396, 0.7651],
      ),
    ),
    padding: EdgeInsets.only(left: 45.rw, top: 10.rh, right: 45.rw, bottom: 30.rh),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.rs),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      cartProduct.image,
                      width: 100.rw,
                      height: 100.rh,
                      fit: BoxFit.contain,
                    ),
                  ),
                  30.horizontalSpace,
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartProduct.title,
                          style: TextStyle(
                            color: Color(0xFF1E4489),
                            fontWeight: FontWeight.w600,
                            fontSize: 40.rt,
                          ),
                        ),
                        13.verticalSpace,
                        Row(
                          children: [
                            Text(
                              '${cartProduct.qty} x £${cartProduct.finalPrice.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Color(0xFF7F7F7F),
                                fontWeight: FontWeight.w500,
                                fontSize: 32.rt,
                              ),
                            ),
                            8.horizontalSpace,
                            Text(
                              '|',
                              style: TextStyle(
                                color: Color(0xFF7F7F7F),
                                fontWeight: FontWeight.w500,
                                fontSize: 32.rt,
                              ),
                            ),
                            8.horizontalSpace,
                            Text(
                              'SKU: ${cartProduct.sku}',
                              style: TextStyle(
                                color: Color(0xFF7F7F7F),
                                fontWeight: FontWeight.w500,
                                fontSize: 32.rt,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  30.horizontalSpace,
                  Expanded(
                    flex: 2,
                    child: Text(
                      '£${cartProduct.total}',
                      style: TextStyle(
                        color: Color(0xFFEE2938),
                        fontWeight: FontWeight.w700,
                        fontSize: 40.rt,
                      ),
                    ),
                  )
                ],
              ),
              10.verticalSpace,
              provider.isCakeProduct(cartProduct)
                 ?Container(
                  width: 930.rw,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.rs),
                    border: Border.all(
                      color: Color(0xFFB6B6B6),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 20.rh),
                        child: Text(
                          '${provider.sizeTitle} . ${provider.spongTitle} . ${provider.fillTitle} .',
                          style: TextStyle(
                            color: Color(0xFF283577),
                            fontSize: 32.rt,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      10.verticalSpace,
                      provider.message.isNotEmpty?Divider(
                        height : 1,
                        thickness: 0,
                        color: Color(0xFFB6B6B6),
                      ):SizedBox.shrink(),
                      provider.message.isNotEmpty?Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 20.rh),
                        child: Text(
                          provider.message,
                          style: TextStyle(
                            color: Color(0xFF283577),
                            fontSize: 30.rt,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ):SizedBox.shrink()
                    ],
                  ),
                ): const SizedBox.shrink(),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      provider.deleteCartProduct(cartProduct.sku);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmptyCartScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.rs),
                        border: Border.all(
                          color: Color(0xFFCDCDCD),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 100.rw, vertical: 30.rh),
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              size: 60.rw,
                              color: Color(0xFFD41F36),
                            ),
                            30.horizontalSpace,
                            Text(
                              'DELETE',
                              style: TextStyle(
                                color: Color(0xFFD41F36),
                                fontWeight: FontWeight.w500,
                                fontSize: 30.rt
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.rs),
                      border: Border.all(
                        color: Color(0xFFCDCDCD),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.rw),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              provider.decrementProduct(cartProduct);
                              if (cartProduct.qty <= 1) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const EmptyCartScreen()),
                                );
                              }
                            },
                            icon: Icon(
                              Icons.remove,
                              size: 50.rt,
                              color: Color(0xFFEE2938),
                            ),
                          ),
                          30.horizontalSpace,
                          Text(
                            cartProduct.qty.toString(),
                            style: const TextStyle(color: Colors.black),
                          ),
                          30.horizontalSpace,
                          IconButton(
                            onPressed: () {
                              provider.incrementProduct(cartProduct);
                            },
                            icon: Icon(
                              Icons.add,
                              size: 50.rw,
                              color: Color(0xFFEE2938),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCategory(Map<String, dynamic> category, BuildContext context, ShortProvider provider, int index,) {
  final int categoryId = int.parse(category['id']);
  return Container(
    // width: 280.rw,
    height: 100.rh,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: provider.selectedCategoryId == categoryId
          ? Color(0xFFEE2938): Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(20.rs),
      border: Border.all(
        color: Colors.black12,
        width: 1,
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 20.rh),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                provider.fetchProducts(categoryId, context);
              },
              child: Text(
                category['title'],
                style: TextStyle(
                  color: provider.selectedCategoryId == categoryId
                      ? Color(0xFFFFFFFF)
                      : Color(0xFF2D46C1),
                  fontSize: 34.rt,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildAccessories(Map<String, dynamic> item, BuildContext context, ShortProvider provider){
  final index = provider.cartProducts.indexWhere((p) => p.sku == item['sku']);
  final itemCount = index != -1 ? provider.cartProducts[index] : null;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 20.rh),
    child: Container(
      width: 450.rw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.rs),
        color: Color(0xFFFFFFFF),
        border: Border.all(
          color: Color(0xFFFFFFFF),
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 20.rh),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.rs),
              child: Center(
                child: Image.network(
                  item['image'],
                  width: 300.rw,
                  height: 228.495.rh,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          10.verticalSpace,
          Expanded(
            child: Text(
              item['title'],
              style: TextStyle(
                color: Color(0xFF1E4489),
                fontSize: 35.rt,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '£${item['final_price']}',
                style: TextStyle(
                    color: Color(0xFFEE2938),
                    fontSize: 36.rt,
                    fontWeight: FontWeight.w500
                ),
              ),
              50.horizontalSpace,
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.rs),
                  border: Border.all(
                    color: Color(0xFFDDDDDD),
                    width: 1,
                  ),
                ),
                child: itemCount != null?
                Center(
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.remove_outlined,
                          size: 50.rw,
                          color: Color(0xFFEE2938),
                        ),
                        onPressed: () {
                          provider.decrementProduct(itemCount);
                        },
                      ),
                      Text(
                        itemCount.qty.toString(),
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
                          provider.incrementProduct(itemCount);
                        },
                      ),
                    ],
                  ),
                )
                    : GestureDetector(
                  onTap: () {
                    Product product = Product(
                        title: item['title'],
                        sellPrice: item['sell_price'].toDouble(),
                        id: item['id'],
                        sku: item['sku'],
                        qty: 1,
                        total: item['final_price'],
                        finalPrice: item['final_price'],
                        image: item['image']
                    );
                    provider.addProducts(product);
                  },
                  child: Container(
                      width: 200.rw,
                      height: 80.rh,
                      decoration: BoxDecoration(
                        color: Color(0xFFEE2938),
                        borderRadius: BorderRadius.circular(20.rs),
                        border: Border.all(
                          color: Color(0xFFEE2938),
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 18.rh),
                      child: Text(
                        'ADD',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 36.rt,
                            fontWeight: FontWeight.w400
                        ),
                        textAlign: TextAlign.center,
                      )
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}