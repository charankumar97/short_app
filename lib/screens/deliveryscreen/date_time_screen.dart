import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:short_app/models/person_model.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/deliveryscreen/personal_details_screen.dart';
import '../check_out_screen.dart';

class DateTimeScreen extends StatefulWidget {
  const DateTimeScreen({super.key});

  @override
  State<DateTimeScreen> createState() => _DateTimeScreenState();
}

class _DateTimeScreenState extends State<DateTimeScreen> {
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ShortProvider>(context, listen: false);
      final formatted = DateFormat('dd MMM yyyy').format(DateTime.now());
      _dateController.text = formatted;
      provider.selectedDate(formatted);
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider,_){
      List<String> pickTime = provider.pickUpTime.toList();
      List<Person> user = provider.users.toList();
      return ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.rs)),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
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
                                'assets/images/Vector(1).svg',
                                width: 59.rw,
                                height: 59.rh,
                              ),
                              label: Text(
                                'Back',
                                style: TextStyle(
                                  color: Color(0xFF0C1787),
                                  fontSize: 40.rt,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'PICKUP DATE & TIME',
                            style: TextStyle(
                              color: Color(0xFF0B1156),
                              fontSize: 40.rt,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 10.rh),
                    child: Container(
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F6FF),
                        borderRadius: BorderRadius.circular(20.rs),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            spreadRadius: 1.5,
                            blurRadius: 0,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pickup Date & Time',
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 36.rt,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          30.verticalSpace,
                          Container(
                            height: 120.rh,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.rs),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 6.rh),
                            child: TextField(
                              controller: _dateController,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 38.rt,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Date',
                                suffixIcon: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: SvgPicture.asset(
                                    'assets/images/date.svg',
                                    width: 60.rw,
                                    height: 60.rh,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 38.rt,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.tryParse(_dateController.text) ?? DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year - 100),
                                  lastDate: DateTime(DateTime.now().year + 100),
                                );
                                if (selectedDate != null) {
                                  final formatted = DateFormat('dd MMM yyyy').format(selectedDate);
                                  _dateController.text = formatted;
                                  final String date = formatted;
                                  provider.selectedDate(date);
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 50.rh),
                            child: GridView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 30.rw),
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                childAspectRatio: 2.5,
                              ),
                              itemCount: pickTime.length,
                              itemBuilder: (context,index) {
                                return _buildTimeSlots(pickTime[index], provider);
                              },
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                  50.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 30.rh),
                    child: GestureDetector(
                      onTap: (){
                        user.isEmpty
                            ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonalDetailsScreen(),
                          ),
                        )
                            : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckOutScreen(),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFF000000),
                          borderRadius: BorderRadius.circular(20.rs),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              spreadRadius: 1.5,
                              blurRadius: 0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30.rw, vertical: 30.rh),
                        child: Text(
                          'CONFIRM',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 36.rt,
                            fontWeight: FontWeight.w600
                          ),
                        ),
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
}
Widget _buildTimeSlots(String pickTime, ShortProvider provider){
  return GestureDetector(
    onTap: (){
      provider.selectTime(pickTime);
    },
    child: Container(
      decoration: BoxDecoration(
        color: pickTime == provider.selectedTime? Color(0xFFDC2328):Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(30.rs),
        border: Border.all(
          color: Color(0xFF777777),
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.rw, vertical: 15.rh),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            pickTime ,
            style: TextStyle(
              color: pickTime == provider.selectedTime?Color(0xFFFFFFFF):Color(0xFF777777),
              fontSize: 34.rt,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
