import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ColoredButton extends StatefulWidget {
  const ColoredButton(
      {super.key, required this.onButtonCLick, required this.text});

  final VoidCallback onButtonCLick;
  final String text;

  @override
  State<ColoredButton> createState() => _ColoredButtonState();
}

class _ColoredButtonState extends State<ColoredButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: double.infinity,
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(
              colors: [Color(0xffe0055f), Color(0xff2020ed)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
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
                  fontSize: 19, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
