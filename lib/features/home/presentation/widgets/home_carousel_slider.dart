import 'package:craftybay/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(height: 200.0, viewportFraction: 1,
          onPageChanged: (index, reason) {
            _selectedIndex.value = index;
          }),
          items: [1,2,3,4,5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    alignment: Alignment.center,
                    child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 10,),
        ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (context, selectedIndex, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(int i=0; i<5; i++)
                  Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.only(right:5),
                    decoration: BoxDecoration(
                        color: i == selectedIndex ? AppColors.themeColor : null,
                        border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16)
                    ),
                  )
              ],
            );
          }
        )

      ],
    );
  }
}
