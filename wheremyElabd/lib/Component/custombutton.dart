import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color containerColor;
  final ImageProvider<Object>? image; // Use ImageProvider instead
  final VoidCallback? onPressed; // Function to be called when the button is pressed

  const CustomButton({
    required this.text,
    required this.textColor,
    required this.containerColor,
    this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed, // Call the onPressed function when tapped
      child: Container(
        width: screenSize.width * 0.874,
        height: screenSize.height * 0.075,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null) // Check if an image is provided
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Image(
                  image: image!,
                ),
              ),
            Center(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
