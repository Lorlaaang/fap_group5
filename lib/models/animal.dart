import 'package:audioplayers/audioplayers.dart';

abstract class Animal {
  final String _name;
  final String _imagePath;
  final String _soundPath;
  final String _spellingPath;

  Animal(this._name, this._imagePath, this._soundPath, this._spellingPath);

  String get name => _name;
  String get imagePath => _imagePath;
  String get soundPath => _soundPath;
  String get spellingPath => _spellingPath;

  Future<void> playSound(AudioPlayer player);
  Future<void> playSpelling(AudioPlayer player);
  String get animalType;
}

class Mammal extends Animal {
  Mammal(String name, String imagePath, String soundPath, String spellingPath)
      : super(name, imagePath, soundPath, spellingPath);

  @override
  Future<void> playSound(AudioPlayer player) async {
    await player.play(AssetSource(soundPath.replaceAll('assets/', '')));
  }

  @override
  Future<void> playSpelling(AudioPlayer player) async {
    await player.play(AssetSource(spellingPath.replaceAll('assets/', '')));
  }

  @override
  String get animalType => 'Mammal';
}

class Bird extends Animal {
  Bird(String name, String imagePath, String soundPath, String spellingPath)
      : super(name, imagePath, soundPath, spellingPath);

  @override
  Future<void> playSound(AudioPlayer player) async {
    await player.play(AssetSource(soundPath.replaceAll('assets/', '')));
  }

  @override
  Future<void> playSpelling(AudioPlayer player) async {
    await player.play(AssetSource(spellingPath.replaceAll('assets/', '')));
  }

  @override
  String get animalType => 'Bird';
}

class Reptile extends Animal {
  Reptile(String name, String imagePath, String soundPath, String spellingPath)
      : super(name, imagePath, soundPath, spellingPath);

  @override
  Future<void> playSound(AudioPlayer player) async {
    await player.play(AssetSource(soundPath.replaceAll('assets/', '')));
  }

  @override
  Future<void> playSpelling(AudioPlayer player) async {
    await player.play(AssetSource(spellingPath.replaceAll('assets/', '')));
  }

  @override
  String get animalType => 'Reptile';
}
