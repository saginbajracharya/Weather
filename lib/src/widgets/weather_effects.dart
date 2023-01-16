import 'package:flutter/material.dart';
import 'package:spritewidget/spritewidget.dart';
import 'dart:ui' as ui show Image;

import 'package:weather/src/controller/weather_effects_controller.dart';

// For the different weathers we are displaying different gradient backgrounds,
// these are the colors for top and bottom.
const List<Color> _kBackgroundColorsTop = <Color>[
  Color(0xff5ebbd5), //sun
  Color(0xff0b2734), //rain
  Color(0xffcbced7), //snow
  Color.fromARGB(255, 140, 153, 157), //cloudy
  Color(0xff0b2734), //thunderStorm
];

const List<Color> _kBackgroundColorsBottom = <Color>[
  Color(0xff4aaafb), //sun
  Color(0xff4c5471), //rain
  Color(0xffe0e3ec), //snow
  Color.fromARGB(255, 24, 201, 255), //cloudy
  Color(0xff0b2739), //thunderStorm
];

// The WeatherWorld is our root node for our sprite tree. The size of the tree
// will be scaled to fit into our SpriteWidget container.
class WeatherWorld extends NodeWithSize {
  final ImageMap images;
  final SpriteSheet sprites;
  final SpriteSheet lightningSprite;
  WeatherWorld(this.images,this.sprites,this.lightningSprite) : super(const Size(2048.0, 2048.0)) {
    // Start by adding a background.
    _background = GradientNode(
      size,
      _kBackgroundColorsTop[0],
      _kBackgroundColorsBottom[0],
    );
    addChild(_background);

    // Then three layers of clouds, that will be scrolled in parallax.
    _cloudsSharp = CloudLayer(
      image: images['assets/clouds-0.png']!,
      rotated: false,
      dark: false,
      loopTime: 20.0,
    );
    addChild(_cloudsSharp);

    _cloudsDark = CloudLayer(
      image: images['assets/clouds-1.png']!,
      rotated: true,
      dark: true,
      loopTime: 40.0,
    );
    addChild(_cloudsDark);

    _cloudsSoft = CloudLayer(
      image: images['assets/clouds-1.png']!,
      rotated: false,
      dark: false,
      loopTime: 60.0,
    );
    addChild(_cloudsSoft);

    // Add the sun, rain, and snow (which we are going to fade in/out depending
    // on which weather are selected.
    _sun = Sun(images: images);
    _sun.position = const Offset(1024.0, 1024.0);
    _sun.scale = 1.5;
    addChild(_sun);

    _rain = Rain(sprites: sprites);
    addChild(_rain);

    _snow = Snow(sprites: sprites);
    addChild(_snow);

    _cloudy = Cloudy(sprites: sprites);
    addChild(_cloudy);

    _thunderStorm = ThunderStorm(images: images);
    addChild(_thunderStorm);
  }

  late GradientNode _background;
  late CloudLayer _cloudsSharp;
  late CloudLayer _cloudsSoft;
  late CloudLayer _cloudsDark;
  late Sun _sun;
  late Rain _rain;
  late Snow _snow;
  late Cloudy _cloudy;
  late ThunderStorm _thunderStorm;

  WeatherType get weatherType => _weatherType;

  WeatherType _weatherType = WeatherType.sun;

  set weatherType(WeatherType weatherType) {
    if (weatherType == _weatherType) {
      return;
    }
    // Handle changes between weather types.
    _weatherType = weatherType;
    // Fade the background
    _background.motions.stopAll();
    // Fade the background from one gradient to another.
    _background.motions.run(
      MotionTween<Color>(
        setter: (a) => _background.colorTop = a,
        start: _background.colorTop,
        end: _kBackgroundColorsTop[weatherType.index],
        duration: 1.0,
      ),
    );
    _background.motions.run(
      MotionTween<Color>(
        setter: (a) => _background.colorBottom = a,
        start: _background.colorBottom,
        end: _kBackgroundColorsBottom[weatherType.index],
        duration: 1.0,
      ),
    );
    // Activate/deactivate sun, rain, snow, and dark clouds.
    _cloudsDark.active = weatherType != WeatherType.sun;
    _sun.active = weatherType == WeatherType.sun;
    _rain.active = weatherType == WeatherType.rain;
    _snow.active = weatherType == WeatherType.snow;
    _cloudy.active = weatherType == WeatherType.cloudy;
    _thunderStorm.active = weatherType == WeatherType.thunderStorm;
  }

  @override
  void spriteBoxPerformedLayout() {
    // If the device is rotated or if the size of the SpriteWidget changes we
    // are adjusting the position of the sun.
    _sun.position = spriteBox!.visibleArea!.topLeft + const Offset(350.0, 180.0);
  }
}

// The GradientNode performs custom drawing to draw a gradient background.
class GradientNode extends NodeWithSize {
  GradientNode(Size size, this.colorTop, this.colorBottom) : super(size);

  Color colorTop;
  Color colorBottom;

  @override
  void paint(Canvas canvas) {
    applyTransformForPivot(canvas);

    Rect rect = Offset.zero & size;
    Paint gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: FractionalOffset.topLeft,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[colorTop, colorBottom],
        stops: const <double>[0.0, 1.0],
      ).createShader(rect);

    canvas.drawRect(rect, gradientPaint);
  }
}

// Draws and animates a cloud layer using two sprites.
class CloudLayer extends Node {
  CloudLayer({
    required ui.Image image,
    required bool dark,
    required bool rotated,
    required double loopTime
  }) {
    // Creates and positions the two cloud sprites.
    _sprites.add(_createSprite(image, dark, rotated));
    _sprites[0].position = const Offset(1024.0, 1024.0);
    addChild(_sprites[0]);

    _sprites.add(_createSprite(image, dark, rotated));
    _sprites[1].position = const Offset(3072.0, 1024.0);
    addChild(_sprites[1]);

    // Animates the clouds across the screen.
    motions.run(
      MotionRepeatForever(
        motion: MotionTween<Offset>(
          setter: (a) => position = a,
          start: Offset.zero,
          end: const Offset(-2048.0, 0.0),
          duration: loopTime,
        ),
      ),
    );
  }

  final List<Sprite> _sprites = <Sprite>[];

  Sprite _createSprite(ui.Image image, bool dark, bool rotated) {
    Sprite sprite = Sprite.fromImage(image);
    if (rotated) sprite.scaleX = -1.0;
    if (dark) {
      sprite.colorOverlay = const Color(0xff000000);
      sprite.opacity = 0.0;
    }
    return sprite;
  }

  set active(bool active) {
    // Toggle visibility of the cloud layer
    double opacity;
    if (active) {
      opacity = 1.0;
    } else {
      opacity = 0.0;
    }
    for (Sprite sprite in _sprites) {
      sprite.motions.stopAll();
      sprite.motions.run(
        MotionTween<double>(
          setter: (a) => sprite.opacity = a,
          start: sprite.opacity,
          end: opacity,
          duration: 1.0,
        ),
      );
    }
  }
}

const double _kNumSunRays = 50.0;

// Create an animated sun with rays
class Sun extends Node {
  final ImageMap images;

  Sun({ Key? key ,required this.images}) {
    // Create the sun
    _sun = Sprite.fromImage(images['assets/sun.png']!);
    _sun.scale = 2.0;
    _sun.blendMode = BlendMode.plus;
    addChild(_sun);

    // Create rays
    _rays = <Ray>[];
    for (int i = 0; i < _kNumSunRays; i += 1) {
      Ray ray = Ray(images: images);
      addChild(ray);
      _rays.add(ray);
    }
  }

  late Sprite _sun;
  late List<Ray> _rays;

  set active(bool active) {
    // Toggle visibility of the sun

    motions.stopAll();

    double targetOpacity;
    if (!active) {
      targetOpacity = 0.0;
    } else {
      targetOpacity = 1.0;
    }

    motions.run(
      MotionTween<double>(
        setter: (a) => _sun.opacity = a,
        start: _sun.opacity,
        end: targetOpacity,
        duration: 2.0,
      ),
    );

    if (active) {
      for (Ray ray in _rays) {
        motions.run(
          MotionSequence(
            motions: [
              MotionDelay(delay: 1.5),
              MotionTween<double>(
                setter: (a) => ray.opacity = a,
                start: ray.opacity,
                end: ray.maxOpacity,
                duration: 1.5,
              ),
            ],
          ),
        );
      }
    } else {
      for (Ray ray in _rays) {
        motions.run(
          MotionTween<double>(
            setter: (a) => ray.opacity = a,
            start: ray.opacity,
            end: 0.0,
            duration: 0.2,
          ),
        );
      }
    }
  }
}

// An animated sun ray
class Ray extends Sprite {
  late double _rotationSpeed;
  late double maxOpacity;
  final ImageMap images;
  Ray({ Key? key ,required this.images}) : super.fromImage(images['assets/ray.png']!) {
    pivot = const Offset(0.0, 0.5);
    blendMode = BlendMode.plus;
    rotation = randomDouble() * 360.0;
    maxOpacity = randomDouble() * 0.2;
    opacity = maxOpacity;
    scaleX = 2.5 + randomDouble();
    scaleY = 0.3;
    _rotationSpeed = randomSignedDouble() * 2.0;

    // Scale animation
    double scaleTime = randomSignedDouble() * 2.0 + 4.0;

    motions.run(
      MotionRepeatForever(
        motion: MotionSequence(
          motions: [
            MotionTween<double>(
              setter: (a) => scaleX = a,
              start: scaleX,
              end: scaleX * 0.5,
              duration: scaleTime,
            ),
            MotionTween<double>(
              setter: (a) => scaleX = a,
              start: scaleX * 0.5,
              end: scaleX,
              duration: scaleTime,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    rotation += dt * _rotationSpeed;
  }
}

// Rain layer. Uses three layers of particle systems, to create a parallax
// rain effect.
class Rain extends Node {
  final SpriteSheet sprites;

  Rain({ Key? key ,required this.sprites}) {
    addParticles(1.0);
    addParticles(1.5);
    addParticles(2.0);
  }

  final List<ParticleSystem> _particles = <ParticleSystem>[];

  void addParticles(double distance) {
    ParticleSystem particles = ParticleSystem(
      texture: sprites['raindrop.png']!,
      blendMode: BlendMode.srcATop,
      posVar: const Offset(1300.0, 0.0),
      direction: 90.0,
      directionVar: 0.0,
      speed: 1000.0 / distance,
      speedVar: 100.0 / distance,
      startSize: 1.2 / distance,
      startSizeVar: 0.2 / distance,
      endSize: 1.2 / distance,
      endSizeVar: 0.2 / distance,
      life: 1.5 * distance,
      lifeVar: 1.0 * distance,
    );
    particles.position = const Offset(1024.0, -200.0);
    particles.rotation = 10.0;
    particles.opacity = 0.0;

    _particles.add(particles);
    addChild(particles);
  }

  set active(bool active) {
    motions.stopAll();
    for (ParticleSystem system in _particles) {
      if (active) {
        motions.run(
          MotionTween<double>(
            setter: (a) => system.opacity = a,
            start: system.opacity,
            end: 1.0,
            duration: 2.0,
          ),
        );
      } else {
        motions.run(
          MotionTween<double>(
            setter: (a) => system.opacity = a,
            start: system.opacity,
            end: 0.0,
            duration: 0.5,
          ),
        );
      }
    }
  }
}

// Snow. Uses 9 particle systems to create a parallax effect of snow at
// different distances.
class Snow extends Node {
  final SpriteSheet sprites;
  Snow({ Key? key ,required this.sprites}) {
    _addParticles(sprites['flake-0.png']!, 1.0);
    _addParticles(sprites['flake-1.png']!, 1.0);
    _addParticles(sprites['flake-2.png']!, 1.0);

    _addParticles(sprites['flake-3.png']!, 1.5);
    _addParticles(sprites['flake-4.png']!, 1.5);
    _addParticles(sprites['flake-5.png']!, 1.5);

    _addParticles(sprites['flake-6.png']!, 2.0);
    _addParticles(sprites['flake-7.png']!, 2.0);
    _addParticles(sprites['flake-8.png']!, 2.0);
  }

  final List<ParticleSystem> _particles = <ParticleSystem>[];

  void _addParticles(SpriteTexture texture, double distance) {
    ParticleSystem particles = ParticleSystem(
      texture: texture,
      blendMode: BlendMode.srcATop,
      posVar: const Offset(1300.0, 0.0),
      direction: 90.0,
      directionVar: 0.0,
      speed: 150.0 / distance,
      speedVar: 50.0 / distance,
      startSize: 1.0 / distance,
      startSizeVar: 0.3 / distance,
      endSize: 1.2 / distance,
      endSizeVar: 0.2 / distance,
      life: 20.0 * distance,
      lifeVar: 10.0 * distance,
      emissionRate: 2.0,
      startRotationVar: 360.0,
      endRotationVar: 360.0,
      radialAccelerationVar: 10.0 / distance,
      tangentialAccelerationVar: 10.0 / distance,
    );
    particles.position = const Offset(1024.0, -50.0);
    particles.opacity = 0.0;

    _particles.add(particles);
    addChild(particles);
  }

  set active(bool active) {
    motions.stopAll();
    for (ParticleSystem system in _particles) {
      if (active) {
        motions.run(
          MotionTween<double>(
            setter: (a) => system.opacity = a,
            start: system.opacity,
            end: 1.0,
            duration: 2.0,
          ),
        );
      } else {
        motions.run(
          MotionTween<double>(
            setter: (a) => system.opacity = a,
            start: system.opacity,
            end: 0.0,
            duration: 0.5,
          ),
        );
      }
    }
  }
}

class Cloudy extends Node {
  final SpriteSheet sprites;

  Cloudy({ Key? key ,required this.sprites});

  set active(bool active) {
    motions.stopAll();
  }
}

class ThunderStorm extends Node {
  final ImageMap images;
  final double _kNumLightning = 2.0;

  ThunderStorm({ Key? key ,required this.images}) {
    // Create lightning
    _lightning = <Lightning>[];
    for (int i = 0; i < _kNumLightning; i += 1) {
      Lightning lightning = Lightning(images: images);
      addChild(lightning);
      _lightning.add(lightning);
    }
  }

  late List<Lightning> _lightning;

  set active(bool active) {
    // Toggle visibility of the sun

    motions.stopAll();

    if (active) {
      for (Lightning lightning in _lightning) {
        motions.run(
          MotionSequence(
            motions: [
              MotionDelay(delay: 1.5),
              MotionTween<double>(
                setter: (a) => lightning.opacity = a,
                start: lightning.opacity,
                end: lightning.maxOpacity,
                duration: 1.5,
              ),
            ],
          ),
        );
      }
    } else {
      for (Lightning lightning in _lightning) {
        motions.run(
          MotionTween<double>(
            setter: (a) => lightning.opacity = a,
            start: lightning.opacity,
            end: 0.0,
            duration: 0.2,
          ),
        );
      }
    }
  }
}

class Lightning extends Sprite {
  final double _rotationSpeed = 0.10;
  late double maxOpacity;
  final ImageMap images;
  Lightning({ Key? key ,required this.images}) : super.fromImage(images['assets/lightning.png']!) {
    pivot = const Offset(0, 0);
    blendMode = BlendMode.plus;
    rotation = 0;
    maxOpacity = 1;
    opacity = 1.0;
    scaleX = 2.5 + randomDouble();
    scaleY = 0.3;
    // _rotationSpeed = randomSignedDouble() * 2.0;

    // Scale animation
    // double scaleTime = randomSignedDouble() * 2.0 + 4.0;

    motions.run(
      MotionRepeatForever(
        motion: 
          MotionSequence(
            motions: [
              // Fade in the particle system
              MotionTween<double>(
                setter: (a) => maxOpacity = a,
                start: 0.0,
                end: 1.0,
                duration: 0.5,
              ),
              // Move the particle system down to the bottom of the screen
              MotionTween<Offset>(
                setter: (a) => pivot = a,
                start: const Offset(0.0, 0.0),
                end: const Offset(0.0, 500.0),
                duration: 0.5,
              ),
              // Fade out the particle system
              MotionTween<double>(
                setter: (a) => maxOpacity = a,
                start: 1.0,
                end: 0.0,
                duration: 0.5,
              ),
            ],
          ),
      ),
      // MotionSequence(
      //   motions: [
      //     MotionTween<double>(
      //       setter: (a) => scaleX = a,
      //       start: scaleX,
      //       end: scaleX * 0.5,
      //       duration: 1.5,
      //     ),
      //     MotionTween<double>(
      //       setter: (a) => scaleX = a,
      //       start: scaleX * 0.5,
      //       end: scaleX,
      //       duration: 1.5,
      //     ),
      //   ],
      // ),
    );
  }

  @override
  void update(double dt) {
    rotation += dt * _rotationSpeed;
  }
}