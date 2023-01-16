import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spritewidget/spritewidget.dart';
import 'package:weather/src/widgets/weather_effects.dart';

enum WeatherType { sun, rain, snow, cloudy, thunderStorm }

class WeatherEffectsController extends GetxController {
  // The weather world is our sprite tree that handles the weather animations.
  late WeatherWorld weatherWorld;
  RxBool assetsLoaded = false.obs;
  // The image map hold all of our image assets.
  late ImageMap images;
  // The sprite sheet contains an image and a set of rectangles defining the
  // individual sprites.
  late SpriteSheet sprites;
  late SpriteSheet lightningSprites;

  initialSetup(context){
    // Get our root asset bundle
    AssetBundle bundle = rootBundle;
    // Load all graphics, then set the state to assetsLoaded and create the
    // WeatherWorld sprite tree
    _loadAssets(bundle,context).then((_) {
      assetsLoaded.value = true;
      weatherWorld = WeatherWorld(images,sprites,lightningSprites);
      update();
    });
  }

  // This method loads all assets that are needed for the demo.
  Future<void> _loadAssets(AssetBundle bundle,context) async {
    // Load images using an ImageMap
    images = ImageMap();
    await images.load(<String>[
      'assets/clouds-0.png',
      'assets/clouds-1.png',
      'assets/ray.png',
      'assets/sun.png',
      'assets/weathersprites.png',
      'assets/icon-sun.png',
      'assets/icon-rain.png',
      'assets/icon-snow.png',
      'assets/lightningSprite.png',
      'assets/lightning.png'
    ]);

    // Load the sprite sheet, which contains snowflakes and rain drops.
    String json = await DefaultAssetBundle.of(context).loadString('assets/weathersprites.json');
    sprites = SpriteSheet(
      image: images['assets/weathersprites.png']!,
      jsonDefinition: json,
    );

    // Load the sprite sheet, which contains lightning.
    String lightningSpriteJson = await DefaultAssetBundle.of(context).loadString('assets/lightningSprite.json');
    lightningSprites = SpriteSheet(
      image: images['assets/lightningSprite.png']!,
      jsonDefinition: lightningSpriteJson,
    );
  }

  setWeather(currentWeather){
    if(currentWeather.trim().toLowerCase() =='clear'){
      weatherWorld.weatherType = WeatherType.sun;
    }
    else if(currentWeather.trim().toLowerCase() =='clouds'){
      weatherWorld.weatherType = WeatherType.cloudy;
    }
    else if(currentWeather.trim().toLowerCase() =='rain'){
      weatherWorld.weatherType = WeatherType.rain;
    }
    else if(currentWeather.trim().toLowerCase() =='thunderstorm'){
      weatherWorld.weatherType = WeatherType.thunderStorm;
    }
    else if(currentWeather.trim().toLowerCase() =='Drizzle'){
      weatherWorld.weatherType = WeatherType.rain;
    }
    else if(currentWeather.trim().toLowerCase() =='snow'){
      weatherWorld.weatherType = WeatherType.snow;
    }
    else {
      weatherWorld.weatherType = WeatherType.rain;
    }
    update();
  }
}