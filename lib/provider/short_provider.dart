import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:short_app/models/person_model.dart';
import '../models/product_model.dart';
import '../screens/login_screen.dart';

class ShortProvider extends ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Person> _users = [];
  List<Person> get users => _users;

  List<Map<String, dynamic>> _bestSellers = [];
  List<Map<String, dynamic>> get bestSellers => _bestSellers;

  List<Map<String, dynamic>> _stores = [];
  List<Map<String, dynamic>> get stores => _stores;

  List<Map<String, dynamic>> _cakes = [];
  List<Map<String, dynamic>> get cakes => _cakes;

  List<Map<String, dynamic>> _allCakes = [];
  List<Map<String, dynamic>> get allCakes => _allCakes;

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> get products => _products;

  List<Map<String, dynamic>> _cupCakes = [];
  List<Map<String, dynamic>> get cupCakes => _cupCakes;

  List<Map<String, dynamic>> _weddingCakes = [];
  List<Map<String, dynamic>> get weddingCakes => _weddingCakes;

  List<Map<String, dynamic>> _treats = [];
  List<Map<String, dynamic>> get treats => _treats;

  List<Map<String, dynamic>> _delivery = [];
  List<Map<String, dynamic>> get delivery => _delivery;

  List<Map<String, dynamic>> _cakeSize = [];
  List<Map<String, dynamic>> get cakeSize => _cakeSize;

  List<Map<String, dynamic>> _sponges = [];
  List<Map<String, dynamic>> get sponges => _sponges;

  List<Map<String, dynamic>> _searchProduct = [];
  List<Map<String, dynamic>> get searchProduct => _searchProduct;

  Map<String, dynamic> _image = {};
  Map<String, dynamic> get image => _image;

  List<Map<String, dynamic>> _filling = [];
  List<Map<String, dynamic>> get filling => _filling;

  List<Map<String, dynamic>> _ingredients = [];
  List<Map<String, dynamic>> get ingredients => _ingredients;

  String _description = '';
  String get description => _description;

  String _ingredient = '';
  String get ingredient => _ingredient;

  String _disclaimer = '';
  String get disclaimer => _disclaimer;

  String _text = '';
  String get text => _text;

  List<Map<String, dynamic>> _collection = [];
  List<Map<String, dynamic>> get collection => _collection;

  List<String> _pickUpTime = [];
  List<String> get pickUpTime => _pickUpTime;

  String _selectedTime = '';
  String get selectedTime => _selectedTime;

  List<Product> _cartProducts = [];
  List<Product> get cartProducts => _cartProducts;

  List<Map<String, dynamic>> _address = [];
  List<Map<String, dynamic>> get address => _address;

  List<Map<String, dynamic>> _showAddress = [];
  List<Map<String, dynamic>> get showAddress => _showAddress;

  List<Map<String, dynamic>> _orders = [];
  List<Map<String, dynamic>> get orders => _orders;

  List<Map<String, dynamic>> _allCoupons = [];
  List<Map<String, dynamic>> get allCoupons => _allCoupons;

  Map<String, dynamic> _selectedCoupon = {};
  Map<String, dynamic> get selectedCoupon => _selectedCoupon;

  Map<String, dynamic> _selectedStoreTitle = {};
  Map<String, dynamic> get selectedStoreTitle => _selectedStoreTitle;

  Map<int, List<Map<String, dynamic>>> _categoryProducts = {};
  Map<int, List<Map<String, dynamic>>> get allCategoryProducts => _categoryProducts;

  int? _selectedCategoryId ;
  int? get selectedCategoryId => _selectedCategoryId;

  Map<String, dynamic> _selectProduct = {};
  Map<String, dynamic> get selectProduct => _selectProduct;

  double _selectSizePrice = 0.0;
  double get selectSizePrice => _selectSizePrice;

  String _sizeTitle = '';
  String get sizeTitle => _sizeTitle;
  String _spongTitle = '';
  String get spongTitle => _spongTitle;
  String _fillTitle = '';
  String get fillTitle => _fillTitle;
  String _message = '';
  String get message => _message;

  String _firstName = '';
  String get firstName => _firstName;
  String _lastName = '';
  String get lastName => _lastName;
  String _email = '';
  String get email => _email;
  String _mobile = '';
  String get mobile => _mobile;

  String _date = '';
  String get date => _date;
  String _time = '';
  String get time => _time;
  int _selectedSizeId = 0;
  int get selectedSizeId => _selectedSizeId;
  int _selectedSpongeId = 0;
  int get selectedSpongeId => _selectedSpongeId;
  int _selectedFillingId = 0;
  int get selectedFillingId => _selectedFillingId;
  int _selectedProductId = 0;
  int get selectedProductId => _selectedProductId;

  double _sellPrice = 0;
  double get sellPrice =>_sellPrice;

  late Box<Person> _personBox;

  ShortProvider({
    required List<Person> user,
    required BuildContext context,
  }) {
    _users = user;
    _initHive(context);
  }

  Future<void> _initHive(BuildContext context) async {
    await Hive.initFlutter();
    _personBox = await Hive.openBox<Person>('person');
    _loadDetails();
    fetchBestSellers();
    fetchStoresLocation();
    fetchCakes();
    fetchCupCakes();
    fetchWeddingCakes();
    fetchTreats();
    fetchTimeSlots();
    fetchCategoryProducts(192, context);
    fetchProducts(153, context);
    fetchCakeSizes(2566);
    fetchSponges(2566);
    fetchFilling(2566);
    fetchDescription(2566);
    fetchDelivery("3");
    fetchShowAddress(1621);
    fetchAllCoupons();
  }

  Future<void> fetchBestSellers() async {
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/products/157');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('products')) {
          final List<dynamic> productsList = responseData['products'];
          _bestSellers = productsList
              .map<Map<String, dynamic>>((item) => Map<String, dynamic>.from(item))
              .toList();
          notifyListeners();
        } else {
          print('Key "products" not found in the response.');
        }
      } else {
        print('Failed to load best sellers. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('An error occurred: $error');
    }
  }

  Future<void> fetchStoresLocation() async{
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/ourstores');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body)['ourstores'];
      _stores = data.cast<Map<String, dynamic>>();
    }else{
      print('Failed to load stores');
    }
    notifyListeners();
  }

  Future<void> fetchSearchSuggestions(String postcode, BuildContext context) async{
    final List<String> skus = cartProducts.map((e) => e.sku).toList();
    final payload = {
      "skus": skus,
    };
    print(payload);
    try {
      final response = await http.post(Uri.parse('https://www.staging.cakesandbakes.net/api/search-postcode?postcode=rm52nl'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _text = data['message'] ?? '';
        _collection = (data['collection'] ?? []).cast<Map<String, dynamic>>();
      } else {
        print('Failed to load stores. Status code: ${response.statusCode}');
      }
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchSearchProducts(String query, BuildContext context) async{
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/search?query=$query');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body)['products'];
      _searchProduct = data.cast<Map<String, dynamic>>();
      _allCakes = data.cast<Map<String, dynamic>>();
    }else{
      print('Failed to load stores');
    }
    notifyListeners();
  }
  
  Future<void> fetchCakes() async{
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/cakes');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body)['data'];
      _cakes = data.cast<Map<String, dynamic>>();
    }else{
      print('Failed to load sub-category');
    }
    notifyListeners();
  }

  Future<void> fetchCupCakes() async{
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/products/145');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body)['products'];
      _cupCakes = data.cast<Map<String, dynamic>>();
    }else{
      print('Failed to load sub-category');
    }
    notifyListeners();
  }

  Future<void> fetchWeddingCakes() async{
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/products/51');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body)['products'];
      _weddingCakes = data.cast<Map<String, dynamic>>();
    }else{
      print('Failed to load sub-category');
    }
    notifyListeners();
  }

  Future<void> fetchTreats() async{
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/treats');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body)['data'][0]['Treats'];
      _treats = data.cast<Map<String, dynamic>>();
    }else{
      print('Failed to load sub-category');
    }
    notifyListeners();
  }

  Future<void> fetchDelivery(String zoneId) async {
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/delivery-prices');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body)['data'];
        _delivery = (json[zoneId]['Normal Day']).cast<Map<String, dynamic>>();
      } else {
        _delivery = [];
        print('Failed to load delivery prices: ${response.statusCode}');
      }
    } catch (e) {
      _delivery = [];
      print('Error fetching delivery prices: $e');
    }
    notifyListeners();
  }

  Future<void> fetchTimeSlots() async {
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/time-slots');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final data = json.decode(response.body)['timeSlots'];
      _pickUpTime = data.cast<String>();
      _selectedTime = _pickUpTime[0];
    }else{
      print('Failed to load time');
    }
    notifyListeners();
  }

  void selectTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  Future<void> fetchCategoryProducts(int id, BuildContext context) async {
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/products/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['products'];
        _allCakes = data.cast<Map<String, dynamic>>();
      } else {
        print('Failed to load sub-category: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching category products: $e');
    }
    notifyListeners();
  }

  Future<void> fetchProducts(int id, BuildContext context) async {
    _selectedCategoryId = id;
    notifyListeners();
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/products/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['products'];
        _products = data.cast<Map<String, dynamic>>();
      } else {
        print('Failed to load sub-category: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching category products: $e');
    }
    notifyListeners();
  }


  Future<void> fetchProduct(int categoryId) async {
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/products/$categoryId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['products'];
        _categoryProducts[categoryId] = data.cast<Map<String, dynamic>>();
        notifyListeners();
      } else {
        print('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }


  Future<void> fetchCakeSizes(int id) async{
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/cakesizes/$id');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body)['sizes'];
      _cakeSize = data.cast<Map<String, dynamic>>();
    }else{
      print('Failed to load sub-category');
    }
    notifyListeners();
  }

  Future<void> fetchSponges(int id) async {
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/sponges/$id');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body)['sponges'];
      final imageData = jsonDecode(response.body)['image_url'];
      _sponges = data.cast<Map<String, dynamic>>();
      _image = imageData;
    }else{
      print('Failed to load sub-category');
    }
    notifyListeners();
  }

  Future<void> fetchFilling(int id) async {
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/filling/$id');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body)['filling'];
      _filling = data.cast<Map<String, dynamic>>();
    }else{
      print('Failed to load sub-category');
    }
    notifyListeners();
  }

  Future<void> fetchDescription(int id) async{
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/description/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final data = json['data'];
      _description = data['description'] ?? '';
      _ingredient = data['ingredients'] ?? '';
      _disclaimer = data['disclaimer'] ?? '';
      _ingredients = (data['ingredients_1'] as List).cast<Map<String, dynamic>>();
      notifyListeners();
    } else {
      print('Failed to load description data');
    }
  }

  Future<void> fetchShowAddress(int userId) async {
    try {
      final url = Uri.parse('https://www.staging.cakesandbakes.net/api/user-addresses/$userId');
      print('Fetching from: $url');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        if (response.headers['content-type']?.contains('application/json') == true) {
          final data = jsonDecode(response.body);
          _showAddress = data.cast<Map<String, dynamic>>();
        } else {
          print(response.body);
        }
      } else {
        print('Failed to load address: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching address: $e');
    }
    notifyListeners();
  }

  Future<void> fetchOrders(int userId) async {
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/orders/$userId');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body)['orders'][0]['products'];
      _orders = data.cast<Map<String, dynamic>>();
    }else{
      print('Failed to load sub-category');
    }
    notifyListeners();
  }

  Future<void> fetchProductPrice() async{
    final payload = {
      "channel_product_id": _selectedProductId,
      "size_id": _selectedSizeId,
      "sponge_id": _selectedSpongeId,
      "filling_id": _selectedFillingId
    };
    print(payload);
    try {
      final response = await http.post(Uri.parse('https://www.staging.cakesandbakes.net/api/get-product-price'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        _sellPrice = data['sell_price'];
        print(sellPrice);
      } else {
        print('Failed to load product-price. Status code: ${response.statusCode}');
      }
      notifyListeners();
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchAllCoupons() async{
    final url = Uri.parse('https://www.staging.cakesandbakes.net/api/coupons');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final data = json.decode(response.body);
      _allCoupons = data.cast<Map<String, dynamic>>();
    }
    else{
      print('Failed to load Coupons');
    }
    notifyListeners();
  }
  void selectCoupon(Map<String, dynamic> coupon) {
    _selectedCoupon = coupon;
    notifyListeners();
  }

  void clearCoupon() {
    _selectedCoupon = {};
    notifyListeners();
  }

  bool isCakeProduct(Product product) {
    final title = product.title.toLowerCase();
    return title.contains('cake') || title.contains('cupcake');
  }
  void addProducts(Product product) {
    final index = _cartProducts.indexWhere((p) => p.sku == product.sku);

    final title = product.title.toLowerCase().replaceAll(' ', '');
    final bool isCake = title.contains('cake') || title.contains('cupcake');

    if (index != -1) {
      _cartProducts[index].qty += product.qty;

      _cartProducts[index].total = isCake
          ? _cartProducts[index].qty * _cartProducts[index].finalPrice
          : _cartProducts[index].qty * _cartProducts[index].finalPrice;
    } else {
      product.total = isCake
          ? product.finalPrice * product.qty
          : product.finalPrice * product.qty;

      _cartProducts.add(product);
    }
    notifyListeners();
  }

  Future<void> incrementProduct(Product product) async{
    final index = _cartProducts.indexWhere((p) => p.sku == product.sku);
    if (index != -1) {
      final existingProduct = _cartProducts[index];
      existingProduct.qty += 1;
      existingProduct.total =
          (existingProduct.finalPrice + selectSizePrice) * existingProduct.qty;
    }
    notifyListeners();
  }

  Future<void> decrementProduct(Product product) async{
    final index = _cartProducts.indexWhere((p) => p.sku == product.sku);
    if (index != -1) {
      final existingProduct = _cartProducts[index];
      if (existingProduct.qty == 1) {
        _cartProducts.removeAt(index);
      } else {
        existingProduct.qty -= 1;
        existingProduct.total =
            (existingProduct.finalPrice + selectSizePrice) * existingProduct.qty;
      }
    }
    notifyListeners();
  }

  void deleteCartProduct(String sku) {
    _cartProducts.removeWhere((product) => product.sku == sku);
    notifyListeners();
  }

  int get cartItemCount {
    return _cartProducts.fold(0, (sum, product) => sum + product.qty);
  }

  int get itemCount {
    return _selectProduct['qty'] ?? 1;
  }

  void selectedItem(String sizeTitle, String spongeTitle, String fillingTitle, String message){
    _sizeTitle = sizeTitle;
    _spongTitle = spongeTitle;
    _fillTitle = fillingTitle;
    _message = message;
    notifyListeners();
  }
  void selectedItemId(int sizeId, int spongeId, int fillingId, int productId){
    _selectedSizeId = sizeId;
    _selectedSpongeId = spongeId;
    _selectedFillingId = fillingId;
    _selectedProductId = productId;
    notifyListeners();
  }
  void selectedProduct(Map<String, dynamic> product) {
    product['qty'] = 1;
    _selectProduct = Map<String, dynamic>.from(product);
    notifyListeners();
  }
  void incrementQty() {
    if (_selectProduct.containsKey('qty')) {
      _selectProduct['qty'] += 1;
      notifyListeners();
    }
  }

  void decrementQty() {
    if (_selectProduct.containsKey('qty') && _selectProduct['qty'] > 1) {
      _selectProduct['qty'] -= 1;
      notifyListeners();
    }
  }

  void clearSelectedProducts() {
    _selectProduct.clear();
    notifyListeners();
  }

  void selectedAddress(Map<String, dynamic> address) {
    _address = [address];
    notifyListeners();
  }

  void prerson(String firstName ,String lastName ,String email ,String mobile){
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _mobile = mobile;
    notifyListeners();
  }

  void selectStore(Map<String, dynamic> store){
    _selectedStoreTitle = store;
    notifyListeners();
  }


  Map<String, dynamic> get currentAddress {
    return _address.isNotEmpty ? _address.first : {};
  }

  Future<void> deleteAddressById(int addressId, int userId) async {
    try {
      final url = Uri.parse('https://www.staging.cakesandbakes.net/api/delete-address/$userId/$addressId');
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print('Address deleted: $addressId');
        fetchShowAddress(userId);
        notifyListeners();
      } else {
        print('Failed to delete address: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting address: $e');
    }
  }

  void selectedDate(String date){
    _date = date;
    notifyListeners();
  }
  void selectDeliveryTime(String time){
    _time = time;
    notifyListeners();
  }

  void selectedSizePrice(double price){
    _selectSizePrice = price;
    notifyListeners();
  }
  void clearSelectedSizePrice() {
    _selectSizePrice = 0.0;
    notifyListeners();
  }

  double get itemTotal {
    if (_selectProduct.isEmpty) return 0.0;
    final basePrice = (_selectProduct['final_price'] as num?)?.toDouble() ?? 0.0;
    final qty = (_selectProduct['qty'] as int?) ?? 1;
    return (basePrice + selectSizePrice) * qty;
  }

  double get totalAmount => _cartProducts.fold(0, (sum, item) => sum + (item.finalPrice * item.qty));

  Future<void> registerUser(Person user, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _personBox.clear();
      await _personBox.add(user);

      _users = [user];

      print('User registered: $user');
    } catch (e) {
      print('Error registering user: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> updateUser(Person user, BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _personBox.clear();
      await _personBox.add(user);
      _loadDetails();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User details updated')),
      );
    } catch (e) {
      print('Error updating user: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> updateUserDetails(Person user, BuildContext context) async{
    await _personBox.clear();
    _users.clear();
    try{
      await _personBox.add(user);
      _users.add(user);
    }catch(e){
      print('Error adding user: $e');
    }
    notifyListeners();
  }

  Future<void> logOut(BuildContext context) async {
    await _personBox.clear();
    _users.clear();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
    notifyListeners();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User logged out')),
    );
  }


  void _loadDetails() {
    _users = _personBox.values.toList();
  }

  double get packagingFee => 0.00;
  double get discount {
    if (selectedCoupon.isEmpty) return 0.0;

    final value = selectedCoupon['discount'];
    if (value is int) return value.toDouble();
    if (value is double) return value;
    return 0.0;
  }
  double get grandTotal => totalAmount + packagingFee - discount;

  bool isLoggedIn() => _users.isNotEmpty;

}