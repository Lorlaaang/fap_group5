import 'package:audioplayers/audioplayers.dart';

class Color_Model {
  final String _name;
  final String _imagePath;
  final String _soundPath;
  final String _spellingPath;

  Color_Model(this._name, this._imagePath, this._soundPath, this._spellingPath);

  String get name => _name;
  String get imagePath => _imagePath;
  String get soundPath => _soundPath;
  String get spellingPath => _spellingPath;

  Future <void> playSound(AudioPlayer player) async {
    await player.play(AssetSource(soundPath.replaceAll('assets/', '')));
  }

  Future <void> playSpelling(AudioPlayer player) async {
    await player.play(AssetSource(spellingPath.replaceAll('assets/', '')));
  }
}