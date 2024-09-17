import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleButton extends StatefulWidget {
  const SimpleButton(
      {super.key, required this.onButtonCLick, required this.text});

  final VoidCallback onButtonCLick;
  final String text;

  @override
  State<SimpleButton> createState() => _SimpleButtonState();
}

class _SimpleButtonState extends State<SimpleButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: Center(
        child: SizedBox(
          height: 54,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.onButtonCLick,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              widget.text,
              style: GoogleFonts.figtree(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
          ),
        ),
      ),
    );
  }
}
