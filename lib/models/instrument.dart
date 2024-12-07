import 'package:audioplayers/audioplayers.dart';

abstract class Instrument {
  final String _name;
  final String _imagePath;
  final String _soundPath;
  final String _spellingPath;

  Instrument(this._name, this._imagePath, this._soundPath, this._spellingPath);

  String get name => _name;
  String get imagePath => _imagePath;
  String get soundPath => _soundPath;
  String get spellingPath => _spellingPath;

  Future<void> playSound(AudioPlayer player);
  Future<void> playSpelling(AudioPlayer player);
  String get instrumentType;
}

class StringInstrument extends Instrument {
  StringInstrument(
      String name, String imagePath, String soundPath, String spellingPath)
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
  String get instrumentType => 'String';
}

class PercussionInstrument extends Instrument {
  PercussionInstrument(
      String name, String imagePath, String soundPath, String spellingPath)
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
  String get instrumentType => 'Percussion';
}

class WindInstrument extends Instrument {
  WindInstrument(
      String name, String imagePath, String soundPath, String spellingPath)
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
  String get instrumentType => 'Wind';
}
