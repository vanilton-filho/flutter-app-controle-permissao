import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  String? label;
  Function()? onPressed;

  CustomButton({
    this.label,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      child: ElevatedButton(
        onPressed: this.onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: Text(
            this.label!,
            style: GoogleFonts.sourceSansPro(
              fontSize: 21.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(8.0)),
          foregroundColor: MaterialStateProperty.all<Color>(
            Colors.green,
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.green,
          ),

          // ButtonStyle(
          //     padding: MaterialStateProperty.all<EdgeInsets>(
          //         const EdgeInsets.all(8.0)),
          //     foregroundColor: MaterialStateProperty.all<Color>(
          //       Colors.grey,
          //     ),
          //     backgroundColor: MaterialStateProperty.all<Color>(
          //       Colors.grey,
          //     ),
          // shape: MaterialStateProperty.all<
          //     RoundedRectangleBorder>(
          //   RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(18.0),
          //   ),
          // ),
        ),
      ),
    );
  }
}
