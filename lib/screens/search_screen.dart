import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/sub_category/sup_sub_category/products/cakes_products.dart';
import 'package:short_app/screens/sub_category/sup_sub_category/products/product_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context,provider,_){
      List<Map<String, dynamic>> cake = provider.searchProduct.toList();
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox.expand(
                child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 30.rh),
                      child: Container(
                        width: 300.rw,
                        height: 110.rh,
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
                        padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 5.rh),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/Vector(1).svg',
                                width: 59.rw,
                                height: 59.rh,
                              ),
                              15.horizontalSpace,
                              Text(
                                'Back',
                                style: TextStyle(
                                  color: Color(0xFF1E4489),
                                  fontSize: 40.rt,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 80.rw, bottom: 10.rh),
                      child: Text(
                        'Search',
                        style: TextStyle(
                          color: Color(0xFF2D46C1),
                          fontSize: 60.rt,
                          fontWeight: FontWeight.w900
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 5.rh),
                      child: Container(
                        height: 130.rh,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100.rs),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(250, 18, 40, 0.15),
                              blurRadius: 50,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.only(left: 80.rw, top: 5.rh, bottom: 5.rh, right: 30.rw),
                        child: TextField(
                          controller: _searchController,
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 40.rt,
                            fontWeight: FontWeight.w500
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search delicious cakes',
                            hintStyle: TextStyle(
                              color: Color(0xFF0C1788),
                              fontSize: 40.rt,
                              fontWeight: FontWeight.w500
                            ),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                onPressed: (){
                                  _searchController.clear();
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.clear_outlined,
                                  size: 59.rs,
                                  color: Color(0xFFDC2328),
                                )
                            )
                                : Icon(
                              Icons.search_rounded,
                              size: 59.rs,
                              color: Color(0xFFDC2328),
                            ),
                          ),
                          onChanged: (value){
                            final value = _searchController.text;
                            setState(() {
                              value;
                            });
                            provider.fetchSearchProducts(value, context);
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 80.rw, vertical: 30.rh),
                      child: _searchController.text.isNotEmpty
                          ? Text(
                        'Found ${cake.length} items',
                        style: TextStyle(
                          color: Color(0xFF858585),
                          fontSize: 36.rt,
                          fontWeight: FontWeight.w400
                        ),
                      ) : SizedBox.shrink(),
                    ),
                    _searchController.text.isEmpty ?
                    GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 30.rw),
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.5,
                      ),
                      children: [
                        _buildCategoryItem(
                          'assets/images/image 228.png',
                          'BirthDay CAKES',
                          Color(0xFFFF83CD),
                          () {
                            final int categoryId = 192;
                            provider.fetchCategoryProducts(categoryId, context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CakesProducts(title: 'BirthDay CAKES'),
                              ),
                            );
                          },
                        ),
                        _buildCategoryItem(
                          'assets/images/kids-cake.jpg',
                          'KIDS BIRTHDAY CAKES',
                          Color(0xFF9690C7),
                          () {
                            final int categoryId = 177;
                            provider.fetchCategoryProducts(categoryId, context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CakesProducts(title: 'KIDS BIRTHDAY CAKES'),
                              ),
                            );
                          },
                        ),
                        _buildCategoryItem(
                          'assets/images/fruit-cakes.jpg',
                          'FRUIT CAKES',
                          Color(0xFF5ACC78),
                          () {
                            final int categoryId = 147;
                            provider.fetchCategoryProducts(categoryId, context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CakesProducts(title: 'FRUIT CAKES'),
                              ),
                            );
                          },
                        ),
                        _buildCategoryItem(
                          'assets/images/photo-cake.jpg',
                          'PHOTO CAKES',
                          Color(0xFFDE8FAC),
                          () {
                            final int categoryId = 141;
                            provider.fetchCategoryProducts(categoryId, context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CakesProducts(title: 'PHOTO CAKES'),
                              ),
                            );
                          },
                        ),
                        _buildCategoryItem(
                          'assets/images/cake-slices.jpg',
                          'CAKE SLICES',
                          Color(0xFFDE8FAC),
                          () {
                            final int categoryId = 159;
                            provider.fetchCategoryProducts(categoryId, context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CakesProducts(title: 'CAKE SLICES'),
                              ),
                            );
                          },
                        ),
                        _buildCategoryItem(
                          'assets/images/cupcakes.jpg',
                          'CUP CAKES',
                          Color(0xFF57B8EC),
                          () {
                            final int categoryId = 145;
                            provider.fetchCategoryProducts(categoryId, context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CakesProducts(title: 'CUP CAKES'),
                              ),
                            );
                          },
                        ),
                        _buildCategoryItem(
                          'assets/images/brownies.jpg',
                          'BROWNIES',
                          Color(0xFFF96F5D),
                          () {
                            final int categoryId = 198;
                            provider.fetchCategoryProducts(categoryId, context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CakesProducts(title: 'BROWNIES'),
                              ),
                            );
                          },
                        ),
                        _buildCategoryItem(
                          'assets/images/hoteats.png',
                          'HOT EATS',
                          Color(0xFF8E6565),
                          () {
                            final int categoryId = 262;
                            provider.fetchCategoryProducts(categoryId, context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CakesProducts(title: 'HOT EATS'),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                        : GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 30.rw),
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: cake.length,
                      itemBuilder: (context,index){
                        return _buildCakes(cake[index], context,provider);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      );
    });
  }
}

Widget _buildCategoryItem(String image, String label, Color bgColor, VoidCallback onTap,) {
  return Container(
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(20.rs),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 10.rh),
    child: GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Image.asset(
              image,
              width: 350.rw,
              height: 350.rh,
              fit: BoxFit.cover
            )
          ),
          10.horizontalSpace,
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.rt,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCakes(Map<String, dynamic> cake, BuildContext context, ShortProvider provider){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30.rs),
      border: Border.all(
        color: Colors.black12,
        width: 1,
      ),
    ),
    padding: EdgeInsets.symmetric(horizontal: 15.rw, vertical: 15.rh),
    child: GestureDetector(
      onTap: () async {
        final int? id = cake['id'];
        print(id);
        if(id != null){
          provider.fetchCakeSizes(id);
          provider.fetchSponges(id);
          provider.fetchFilling(id);
          provider.fetchDescription(id);
          provider.selectedProduct(cake);
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
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.rs),
              child: Image.network(
                cake['image'],
                width: 450.rw,
                height: 450.rh,
                fit: BoxFit.cover
              ),
            ),
          ),
          10.verticalSpace,
          Text(
            cake['title'],
            style: TextStyle(
              color: Color(0xFF283577),
              fontSize: 40.rt,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.rh),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'From ',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 36.rt,
                        fontWeight: FontWeight.w400
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '£${cake['final_price'].toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Color(0xFFEE2938),
                        fontSize: 40.rt,
                        fontWeight: FontWeight.w700
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    final int? id = cake['id'];
                    print(id);
                    if(id != null){
                      provider.fetchCakeSizes(id);
                      provider.fetchSponges(id);
                      provider.fetchFilling(id);
                      provider.fetchDescription(id);
                      provider.selectedProduct(cake);
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
                  child: Container(
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
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}