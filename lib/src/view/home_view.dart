import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:weather/src/controller/weather_effects_controller.dart';
import 'package:weather/src/controller/home_controller.dart';
import 'dart:core';
import 'package:weather/src/common/styles.dart';
import 'package:weather/src/settings/settings_view.dart';
import 'package:weather/src/view/test_view.dart';
import 'package:weather/src/widgets/calender.dart';
import 'package:weather/src/widgets/drawer_widget.dart';
import 'package:weather/src/widgets/weather_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routeName = '/home';
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController homeCon = Get.put(HomeController());
  WeatherEffectsController weatherEffectsCon = Get.put(WeatherEffectsController());

  @override
  void initState() {
    super.initState();
    weatherEffectsCon.initialSetup(context);
    homeCon.getCurrentLocation().then((value){
      if(value!=null){
        homeCon.currentWeather(value.latitude,value.longitude);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const DrawerWidget(),
      body: Obx((){
        return weatherEffectsCon.assetsLoaded.value==false
        ?const Center(
          child: CircularProgressIndicator(),
        )
        : Material(
          child: homeCon.currentWeatherLoading.value
            ?const SizedBox()
            :Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                SpriteWidget(weatherEffectsCon.weatherWorld),
                // Stream Time 12 and 24 and weather Api data & sfCalender
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top:20,bottom: kBottomNavigationBarHeight-10,left:10.0,right:10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: StreamBuilder(
                            stream: Stream.periodic(const Duration(seconds: 1)),
                            builder: (context, snapshot) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(
                                    child: SimpleShadow(
                                      opacity: 0.8,         // Default: 0.5
                                      color: black,   // Default: Black
                                      offset: const Offset(0, 2), // Default: Offset(2, 2)
                                      sigma: 1.5,             // Default: 2
                                      child: RichText(
                                        overflow : TextOverflow.visible,
                                        softWrap: true,
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context).style,
                                          children: [
                                            TextSpan(
                                              text: DateFormat('hh').format(DateTime.now()),
                                              style: textStyle1,
                                            ),
                                            TextSpan(
                                              text: ':',
                                              style: textStyle1
                                            ),
                                            TextSpan(
                                              text: DateFormat('mm').format(DateTime.now()),
                                              style: textStyle1,
                                            ),
                                            TextSpan(
                                              text: ':',
                                              style: textStyle1
                                            ),
                                            TextSpan(
                                              text: DateFormat('ss').format(DateTime.now()),
                                              style: textStyle1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: SimpleShadow(
                                      opacity: 0.8,         // Default: 0.5
                                      color: black,   // Default: Black
                                      offset: const Offset(0, 2), // Default: Offset(2, 2)
                                      sigma: 1.5,            // Default: 2
                                      child: RichText(
                                        overflow : TextOverflow.visible,
                                        softWrap: true,
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context).style,
                                          children: [
                                            TextSpan(
                                              text: DateFormat('HH').format(DateTime.now()),
                                              style: textStyle1,
                                            ),
                                            TextSpan(
                                              text: ':',
                                              style: textStyle1
                                            ),
                                            TextSpan(
                                              text: DateFormat('mm').format(DateTime.now()),
                                              style: textStyle1,
                                            ),
                                            TextSpan(
                                              text: ':',
                                              style: textStyle1
                                            ),
                                            TextSpan(
                                              text: DateFormat('ss').format(DateTime.now()),
                                              style: textStyle1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Flexible(
                          child: homeCon.currentWeatherData!=null
                          ?Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              homeCon.currentWeatherData.coord.lat!=null || homeCon.currentWeatherData.coord.lat!=""
                              ?Flexible(
                                child: SimpleShadow(
                                  opacity: 0.8,         // Default: 0.5
                                  color: black,   // Default: Black
                                  offset: const Offset(0, 2), // Default: Offset(2, 2)
                                  sigma: 1.5,             // Default: 2
                                  child:Text(
                                    "latitude : ${homeCon.currentWeatherData.coord.lat}",
                                    softWrap: false,
                                    textAlign:TextAlign.center,
                                    style: textStyle2,
                                  )
                                ),
                              )
                              :const SizedBox(),
                              homeCon.currentWeatherData.coord.lon!=null || homeCon.currentWeatherData.coord.lon!=""
                              ?Flexible(
                                child: SimpleShadow(
                                  opacity: 0.8,         // Default: 0.5
                                  color: black,   // Default: Black
                                  offset: const Offset(0, 2), // Default: Offset(2, 2)
                                  sigma: 1.5,             // Default: 2
                                  child:Text(
                                    "longitude : ${homeCon.currentWeatherData.coord.lon}",
                                    softWrap: false,
                                    textAlign:TextAlign.center,
                                    style: textStyle2,
                                  )
                                ),
                              )
                              :const SizedBox(),
                              homeCon.currentWeatherData.sys.sunrise!=null || homeCon.currentWeatherData.sys.sunrise!=""
                              ?Flexible(
                                child: SimpleShadow(
                                  opacity: 0.8,         // Default: 0.5
                                  color: black,   // Default: Black
                                  offset: const Offset(0, 2), // Default: Offset(2, 2)
                                  sigma: 1.5,             // Default: 2
                                  child:Text(
                                    "Sunrise : ${homeCon.currentWeatherData.sys.sunrise}",
                                    softWrap: false,
                                    textAlign:TextAlign.center,
                                    style: textStyle2,
                                  )
                                ),
                              )
                              :const SizedBox(),
                              homeCon.currentWeatherData.sys.sunset != null || homeCon.currentWeatherData.sys.sunset != ""
                              ?Flexible(
                                child: SimpleShadow(
                                  opacity: 0.8,         // Default: 0.5
                                  color: black,   // Default: Black
                                  offset: const Offset(0, 2), // Default: Offset(2, 2)
                                  sigma: 1.5,             // Default: 2
                                  child:Text(
                                    "Sunset : ${homeCon.currentWeatherData.sys.sunset}",
                                    softWrap: false,
                                    textAlign:TextAlign.center,
                                    style: textStyle2,
                                  )
                                ),
                              )
                              : const SizedBox(),
                              homeCon.currentWeatherData.name != null || homeCon.currentWeatherData.name != ""
                              ?Flexible(
                                child: SimpleShadow(
                                  opacity: 0.8,         // Default: 0.5
                                  color: black,   // Default: Black
                                  offset: const Offset(0, 2), // Default: Offset(2, 2)
                                  sigma: 1.5,             // Default: 2
                                  child:Text(
                                    "location : ${homeCon.currentWeatherData.name}",
                                    softWrap: false,
                                    textAlign:TextAlign.center,
                                    style: textStyle2,
                                  )
                                ),
                              )
                              :const SizedBox(),
                              homeCon.currentWeatherData.weather.length != 0
                              ?Flexible(
                                child: SimpleShadow(
                                  opacity: 0.8,         // Default: 0.5
                                  color: black,   // Default: Black
                                  offset: const Offset(0, 2), // Default: Offset(2, 2)
                                  sigma: 1.5,             // Default: 2
                                  child:Text(
                                    "Status : ${homeCon.currentWeatherData.weather[0].main}",
                                    softWrap: false,
                                    textAlign:TextAlign.center,
                                    style: textStyle2,
                                  )
                                ),
                              )
                              :const SizedBox(),
                              homeCon.currentWeatherData.weather.length != 0
                              ?Flexible(
                                child: SimpleShadow(
                                  opacity: 0.8,         // Default: 0.5
                                  color: black,   // Default: Black
                                  offset: const Offset(0, 2), // Default: Offset(2, 2)
                                  sigma: 1.5,             // Default: 2
                                  child:Text(
                                    "Description : ${homeCon.currentWeatherData.weather[0].description}",
                                    softWrap: false,
                                    textAlign:TextAlign.center,
                                    style: textStyle2,
                                  )
                                ),
                              )
                              :const SizedBox(),
                              homeCon.currentWeatherData.weather.length != 0
                              ?Image.network(
                                "http://openweathermap.org/img/wn/${homeCon.currentWeatherData.weather[0].icon}.png",
                                width: 40,
                                height: 40,
                              )
                              :const SizedBox(),
                            ],
                          )
                          :const SizedBox(),
                        ),
                        const Flexible(
                          flex: 2,
                          child: Calander()
                        )
                      ],
                    ),
                  ),
                ),
                // Reload
                Align(
                  alignment: Alignment.bottomRight,
                  child: SimpleShadow(
                    opacity: 0.8,         // Default: 0.5
                    color: black,   // Default: Black
                    offset: const Offset(0, 2), // Default: Offset(2, 2)
                    sigma: 1.5,            // Default: 2
                    child: WeatherButton(
                      onPressed: (){
                        homeCon.getCurrentLocation().then((value){
                          if(value!=null){
                            homeCon.currentWeather(value.latitude,value.longitude);
                          }
                        });
                      }, 
                      materialIconSize: 18,
                      materialIcon: Icons.replay_outlined, 
                      selected: true,
                      backgroundColor: transparent,
                    ),
                  ),
                ),
                // Settings
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SimpleShadow(
                    opacity: 0.8,         // Default: 0.5
                    color: black,   // Default: Black
                    offset: const Offset(0, 2), // Default: Offset(2, 2)
                    sigma: 1.5,            // Default: 2
                    child: WeatherButton(
                      onPressed: (){
                        Navigator.restorablePushNamed(context, SettingsView.routeName);
                      }, 
                      materialIconSize: 18,
                      materialIcon: Icons.settings, 
                      selected: true,
                      backgroundColor: transparent,
                    ),
                  ),
                ),
                // Weather Buttons
                Align(   
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: WeatherButton(
                          onPressed: () {
                            setState(() {
                              weatherEffectsCon.weatherWorld.weatherType = WeatherType.sun;
                            });
                          },
                          selected: weatherEffectsCon.weatherWorld.weatherType == WeatherType.sun,
                          icon: 'assets/icon-sun.png',
                          backgroundColor: transparent,
                        ),
                      ),
                      Flexible(
                        child: WeatherButton(
                          onPressed: () {
                            setState(() {
                              weatherEffectsCon.weatherWorld.weatherType = WeatherType.rain;
                            });
                          },
                          selected: weatherEffectsCon.weatherWorld.weatherType == WeatherType.rain,
                          icon: 'assets/icon-rain.png',
                          backgroundColor: transparent,
                        ),
                      ),
                      Flexible(
                        child: WeatherButton(
                          onPressed: () {
                            setState(() {
                              weatherEffectsCon.weatherWorld.weatherType = WeatherType.snow;
                            });
                          },
                          selected: weatherEffectsCon.weatherWorld.weatherType == WeatherType.snow,
                          icon: 'assets/icon-snow.png',
                          backgroundColor: transparent,
                        ),
                      ),
                      Flexible(
                        child: WeatherButton(
                          onPressed: () {
                            setState(() {
                              weatherEffectsCon.weatherWorld.weatherType = WeatherType.cloudy;
                            });
                          },
                          selected: weatherEffectsCon.weatherWorld.weatherType == WeatherType.cloudy,
                          icon: 'assets/coinIcon.png',
                          backgroundColor: transparent,
                        ),
                      ),
                      Flexible(
                        child: WeatherButton(
                          onPressed: () {
                            setState(() {
                              weatherEffectsCon.weatherWorld.weatherType = WeatherType.thunderStorm;
                            });
                          },
                          selected: weatherEffectsCon.weatherWorld.weatherType == WeatherType.thunderStorm,
                          icon: 'assets/coinIcon.png',
                          backgroundColor: transparent,
                        ),
                      ),
                      Flexible(
                        child: WeatherButton(
                          onPressed: () {
                            Get.to(() => const TestView());
                          },
                          selected: weatherEffectsCon.weatherWorld.weatherType == WeatherType.thunderStorm,
                          icon: 'assets/coinIcon.png',
                          backgroundColor: transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      )
    );
  }
}
