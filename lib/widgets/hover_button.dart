import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const HoverButton(
      {super.key, required this.onPressed, required this.buttonText});

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  Color buttonColor = Colors.black;
  Color textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: buttonColor, // background color // text color
        ),
        onPressed: widget.onPressed,
        onHover: (value) {
          setState(() {
            if (value) {
              buttonColor = Colors.white;
              textColor = Colors.black;
            } else {
              buttonColor = Colors.black;
              textColor = Colors.white;
            }
          });
        },
        child: Text(widget.buttonText,
            style: TextStyle(color: textColor, fontSize: 10)),
      ),
    );
  }
}
