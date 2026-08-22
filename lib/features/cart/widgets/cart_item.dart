import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../app/asset_paths.dart';
import '../../../app/constants.dart';
import '../presentation/screens/increment_decrement_button.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    return Card(
      elevation: 3,
      shadowColor: AppColors.themeColor.withAlpha(50),
      color: Colors.white,
      child: Row(
        spacing: 4,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetPaths.dummyImagePng, height: 80,width: 60),
          ),
          Expanded(child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nike KJ54DJ - new arrival shoe', maxLines: 1, style: textTheme.bodyLarge?.copyWith(
                            overflow: TextOverflow.ellipsis
                        ),
                        ),
                        Text('Color: Black Size: XL', style: textTheme.bodySmall?.copyWith(
                            color: Colors.grey
                        ),)
                      ],
                    ),
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Colors.grey,))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${Constants.takaSign}100',
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.themeColor,
                    ),
                  ),
                  IncrementDecrementButton(onChanged: (int value) {

                  },)
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}