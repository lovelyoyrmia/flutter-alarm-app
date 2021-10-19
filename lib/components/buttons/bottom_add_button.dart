import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class BottomAddButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final String image;
  const BottomAddButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      strokeWidth: 3,
      color: Theme.of(context).colorScheme.primaryVariant,
      borderType: BorderType.RRect,
      radius: Radius.circular(30),
      dashPattern: [5, 4],
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: TextButton(
          onPressed: onPressed,
          child: Column(
            children: [
              Container(
                height: 70,
                width: 70,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
