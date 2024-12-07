

class Quiz_Item {
  late String _imageName;
  late String _imagePath;
  late String _audioPath;

  Quiz_Item(String correctImage, String imagePath, String audioPath)
  {
    this._imageName = correctImage;
    this._imagePath = imagePath;
    this._audioPath = audioPath;
  }

  String get imagePath => _imagePath;

  String get imageName => _imageName;

  String get audioPath => _audioPath;
}