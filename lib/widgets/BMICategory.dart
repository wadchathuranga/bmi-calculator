import 'package:flutter/material.dart';

class BMICategory extends StatelessWidget {
  const BMICategory({
    super.key,
    this.isActive = false,
    required this.title,
    required this.value,
    required this.color,
    required this.index,
  });

  final bool? isActive;
  final String title;
  final String value;
  final Color color;
  final int index;

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
            : index == 0
                ? const BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  )
                : index == 5
                    ? const BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      )
                    : BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(0),
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
                const SizedBox(
                  width: 10,
                ),
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
