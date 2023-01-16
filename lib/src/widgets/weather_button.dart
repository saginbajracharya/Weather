// Copyright 2022 The SpriteWidget Authors. All rights reserved.
// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:weather/src/common/styles.dart';

const double _kWeatherButtonSize = 40.0;
const double _kWeatherIconSize = 26.0;

// The WeatherButton is a round material design styled button with an
// image asset as its icon.
class WeatherButton extends StatelessWidget {
  const WeatherButton({
    required this.onPressed,
    required this.selected,
    this.materialIconSize,
    this.materialIcon,
    this.icon,
    this.backgroundColor,
    this.bgSize,
    Key? key,
  }) : super(key: key);

  final String? icon;
  final IconData? materialIcon;
  final double? materialIconSize;
  final Color? backgroundColor;
  final double? bgSize;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Color color;
    if(backgroundColor==null){
      if (selected) {
        color = Theme.of(context).primaryColor;
      } else {
        color = const Color(0x33000000);
      }
    }
    else{
      color=backgroundColor!;
    }

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SimpleShadow(
        opacity: 0.8,         // Default: 0.5
        color: black,   // Default: Black
        offset: const Offset(0, 2), // Default: Offset(2, 2)
        sigma: 1,            // Default: 2
        child: Material(
          color: color,
          // type: MaterialType.circle,
          borderRadius: BorderRadius.circular(18),
          elevation: 0.0,
          child: SizedBox(
            width: bgSize??_kWeatherButtonSize,
            height: bgSize??_kWeatherButtonSize,
            child: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onTap: onPressed,
              splashFactory:InkRipple.splashFactory,
              child: SimpleShadow(
                opacity: 0.8,         // Default: 0.5
                color: black,   // Default: Black
                offset: const Offset(0, 2), // Default: Offset(2, 2)
                sigma: 1.5,            // Default: 2
                child: Center(
                  child: materialIcon!=null
                  ?Icon(
                    materialIcon??Icons.circle,
                    size: materialIconSize??4.0,
                  )
                  :Image.asset(
                    icon!,
                    width: _kWeatherIconSize, 
                    height: _kWeatherIconSize
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
