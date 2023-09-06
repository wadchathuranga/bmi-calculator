import 'package:flutter/material.dart';

class BMICategory extends StatelessWidget {
  const BMICategory({
    super.key,
    this.isActive = false, required this.title, required this.value, required this.color,
  });

  final bool? isActive;
  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      decoration: isActive!
          ? BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      )
          : null,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: isActive!
            ? null
            : BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  isActive! ? Icons.circle_outlined : Icons.circle,
                  color: isActive! ? null : color,
                ),
                const SizedBox(width: 10,),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: isActive! ? FontWeight.bold : null,
                  ),
                ),
              ],
            ),
            Text(
              value,
              style: TextStyle(
                fontWeight: isActive! ? FontWeight.bold : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}