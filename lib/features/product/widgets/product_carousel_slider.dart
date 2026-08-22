import 'package:craftybay/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductCarouselSlider extends StatefulWidget {
  const ProductCarouselSlider({super.key});

  @override
  State<ProductCarouselSlider> createState() => _ProductCarouselSliderState();
}

class _ProductCarouselSliderState extends State<ProductCarouselSlider> {
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(height: 240.0, viewportFraction: 1,
              onPageChanged: (index, reason) {
                _selectedIndex.value = index;
              }),
          items: [1,2,3,4,5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(50),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    alignment: Alignment.center,
                    child: Text('Image $i', style: TextStyle(fontSize: 16.0),)
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 10,),
        Positioned(
          bottom: 8,
          right: 0,
          left: 0,
          top: 0,
          child: ValueListenableBuilder(
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
          ),
        )

      ],
    );
  }
}
