import 'package:flutter/material.dart';

class CurvedNavigationBar extends StatelessWidget {
  final int index;
  final Function(int) onTap;
  final List<Widget> items;
  final Color backgroundColor;
  final Color color;
  final Color? buttonBackgroundColor;
  final double height;

  const CurvedNavigationBar({
    super.key,
    required this.index,
    required this.onTap,
    required this.items,
    this.backgroundColor = Colors.green,
    this.color = Colors.white,
    this.buttonBackgroundColor,
    this.height = 75,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Stack(
          children: [
            // Background of the curved bottom bar
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
              ),
            ),
            // Items row
            Positioned.fill(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: items.asMap().entries.map((entry) {
                  int idx = entry.key;
                  Widget item = entry.value;
                  bool isSelected = idx == index;
                  
                  return Flexible(
                    child: GestureDetector(
                      onTap: () => onTap(idx),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: isSelected ? 65 : 50,
                        height: isSelected ? 50 : 30,
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? (buttonBackgroundColor ?? Colors.white)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: isSelected 
                              ? [
                                  BoxShadow(
                                    // ignore: deprecated_member_use
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: item,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}