

class Flashcard_Item {
  late String _imageName;
  late String _imagePath;
  late String _audioPath;
  late String _spellingPath;

  Flashcard_Item(String imageName, String imagePath, String audioPath, String spellingPath)
  {
    this._imageName = imageName;
    this._imagePath = imagePath;
    this._audioPath = audioPath;
    this._spellingPath = spellingPath;
  }

  String get spellingPath => _spellingPath;

  String get audioPath => _audioPath;

  String get imagePath => _imagePath;

  String get imageName => _imageName;
}
