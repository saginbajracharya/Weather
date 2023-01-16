import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const white = Color(0xffffffff);
const white45 = Colors.white54;
const white60 = Colors.white60;
const white70 = Colors.white70;
const black = Colors.black;
const transparent = Colors.transparent;

Color backdropColor = const Color.fromARGB(2, 42, 42, 42);

TextStyle textStyle1 = const TextStyle(
  fontSize: 40.0,
  color: white,
  height: 1,
  fontWeight: FontWeight.w900,
);

TextStyle textStyle2 = const TextStyle(
  fontSize: 14.0,
  color: white,
  height: 1.5,
  fontWeight: FontWeight.bold,
);

TextStyle textStyle3 = const TextStyle(
  fontSize: 20.0,
  color: white,
  height: 1.5,
  fontWeight: FontWeight.bold,
);

TextStyle gold13 = const TextStyle(
  color: Color(0xff9F703A),
  fontSize: 13.0
);
TextStyle black13 = const TextStyle(
  color: Color(0xff121212),
  fontSize: 13.0
);
TextStyle white13 = const TextStyle(
  color: Color(0xfff9f9f9),
  fontSize: 13.0
);



var gotuRegular1 = GoogleFonts.gotu(fontSize:14,fontWeight:FontWeight.bold,color: white);
var gotuRegular2 = GoogleFonts.gotu(fontSize:20,fontWeight:FontWeight.bold,color: white);
var gotuRegular3 = GoogleFonts.gotu(fontSize:40,fontWeight:FontWeight.bold,color: white);


gotu(color,double fontsize) => GoogleFonts.gotu(fontSize:fontsize,fontWeight:FontWeight.w400,color: color,letterSpacing: 0.36,textStyle: const TextStyle(letterSpacing: 0.36,height: 1.5));
jostRegular(color,double fontsize) => GoogleFonts.jost(fontSize: fontsize,color: color,fontWeight:  FontWeight.w400,letterSpacing: 0.13);
jostMedium(color, double fontsize) => GoogleFonts.jost(fontSize : fontsize,fontWeight:  FontWeight.w500,color: color,letterSpacing: 0.6);
jostLight(color,double fontsize) => GoogleFonts.jost(fontSize: fontsize,fontWeight:  FontWeight.w300,color: color,letterSpacing: 0);
jostSemiBold(color,double fontsize) => GoogleFonts.jost(fontSize: fontsize,fontWeight:  FontWeight.w400,color: color,letterSpacing: 0.6);
jostMediumUnderLine(color, double fontsize) => GoogleFonts.jost(fontSize : fontsize,fontWeight:  FontWeight.w500,color: color,letterSpacing: 0.5,
  decoration: TextDecoration.lineThrough,
  decorationThickness: 3,
  decorationColor: white.withOpacity(0.8),
  decorationStyle: TextDecorationStyle.solid
);