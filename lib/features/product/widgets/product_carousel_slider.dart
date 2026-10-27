import 'package:craftybay/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductCarouselSlider extends StatefulWidget {
  const ProductCarouselSlider({super.key, required this.imageUrls});

  final List<String> imageUrls;

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
          options: CarouselOptions(
            height: 240.0,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              _selectedIndex.value = index;
            },
          ),
          items: widget.imageUrls.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(50),
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),

                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        Positioned(
          bottom: 8,
          right: 0,
          left: 0,
          child: ValueListenableBuilder(
            valueListenable: _selectedIndex,
            builder: (context, selectedIndex, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < widget.imageUrls.length; i++)
                    Container(
                      width: 10,
                      height: 10,
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: i == selectedIndex ? AppColors.themeColor : null,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
