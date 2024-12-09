import 'package:audioplayers/audioplayers.dart';

abstract class Shape {
  final String _name;
  final String _imagePath;
  final String _descriptionPath;
  final String _spellingPath;

  Shape(this._name, this._imagePath, this._descriptionPath, this._spellingPath);

  String get name => _name;
  String get imagePath => _imagePath;
  String get descriptionPath => _descriptionPath;
  String get spellingPath => _spellingPath;

  Future<void> playDescription(AudioPlayer player);
  Future<void> playSpelling(AudioPlayer player);
  String get shapeType;
}

class TwoDimensionalShape extends Shape {
  TwoDimensionalShape(
      String name, String imagePath, String descriptionPath, String spellingPath)
      : super(name, imagePath, descriptionPath, spellingPath);

  @override
  Future<void> playDescription(AudioPlayer player) async {
    await player.play(AssetSource(descriptionPath.replaceAll('assets/', '')));
  }

  @override
  Future<void> playSpelling(AudioPlayer player) async {
    await player.play(AssetSource(spellingPath.replaceAll('assets/', '')));
  }

  @override
  String get shapeType => '2D Shape';
}

