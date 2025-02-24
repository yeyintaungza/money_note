import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.7, // 70% of screen width
      height: screenHeight * 0.3, // 30% of screen height
      child: Center(
        child: Text('No data', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
