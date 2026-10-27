import 'package:craftybay/app/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncrementDecrementButton extends StatefulWidget {
  const IncrementDecrementButton({super.key, required this.onChanged,  this.maxValue = 100, this.initialValue = 1});

  final Function(int) onChanged;
  final int maxValue ;
  final int initialValue;

  @override
  State<IncrementDecrementButton> createState() => _IncrementDecrementButtonState();
}

class _IncrementDecrementButtonState extends State<IncrementDecrementButton> {
  int _currentValue = 1;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildGestureDetector(
        onTap:() {
          if (_currentValue > 1) {
            _currentValue--;
            widget.onChanged(_currentValue);
            setState(() {});
          }
        },
          icon: Icons.remove,
        ),
        Text('$_currentValue', style: TextTheme.of(context).titleMedium,),
        _buildGestureDetector(onTap: () {
          if(_currentValue < widget.maxValue){
            _currentValue++;
            widget.onChanged(_currentValue);
            setState(() {});
          }
        }, icon: Icons.add,
        ),
      ],
    );
  }

  GestureDetector _buildGestureDetector({required VoidCallback onTap, required IconData icon}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.themeColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(icon,size: 20, color: Colors.white),
        ),
      );
  }
}
