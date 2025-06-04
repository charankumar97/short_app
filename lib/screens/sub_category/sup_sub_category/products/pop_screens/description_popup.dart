import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';

class DescriptionPopup extends StatefulWidget {
  final int selectedTab;
  const DescriptionPopup({super.key, required this.selectedTab});

  @override
  State<DescriptionPopup> createState() => _DescriptionPopupState();
}

class _DescriptionPopupState extends State<DescriptionPopup> {
  late int selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = widget.selectedTab;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _){
      return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFFF8DEDE),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.rw, vertical: 50.rh),
              child: Column(
                children: [
                  Row(
                    children: List.generate(3, (index){
                      final labels = ['Description', 'Ingredients', 'Disclaimer'];
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.rs),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  offset: const Offset(4, 4),
                                  blurRadius: 4,
                                ),
                              ],
                              border: Border.all(
                                color: Colors.transparent,
                                width: 2,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 40.rw, vertical: 20.rh),
                            child: Text(
                              labels[index],
                              style: TextStyle(
                                color: selectedTab == index
                                    ? const Color(0xFF2D46C1)
                                    : Colors.black26,
                                fontSize: 40.rt,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  30.verticalSpace,
                  _buildTabContent(provider),
                ],
              ),
            ),
          ),
        )
      );
    });
  }
  Widget _buildTabContent(ShortProvider provider) {
    final List<String> description = provider.description.split('\n\n');
    final List<String> ingredient = provider.ingredient.split('\n\n');
    final List<String> disclaimer = provider.disclaimer.split('\n\n');
    switch(selectedTab){
      case 0: return Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 25.rw),
            itemCount: description.length,
            itemBuilder: (context, index) {
              final data = description[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 30.rh),
                child: Text(
                  data,
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 40.rt,
                    fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.start,
                ),
              );
            },
          )
        ],
      );
      case 1: return Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 25.rw),
            itemCount: ingredient.length,
            itemBuilder: (context, index) {
              final data = ingredient[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 30.rh),
                child: Text(
                  data,
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 40.rt,
                    fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.start,
                ),
              );
            },
          )
        ],
      );
      case 2: return Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 25.rw),
            itemCount: disclaimer.length,
            itemBuilder: (context, index) {
              final data = disclaimer[index];
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 30.rh),
                child: Text(
                  data,
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 40.rt,
                    fontWeight: FontWeight.w600
                  ),
                  textAlign: TextAlign.start,
                ),
              );
            },
          )
        ],
      );
      default: return SizedBox.shrink();
    }
  }
}

