import 'dart:ui';

class Category {
  late String _name;
  late String _description;
  late String _image;
  late Color _color;

  Category(String name, String description, String image, Color color) {
    this._name = name;
    this._description = description;
    this._image = image;
    this._color = color;
  }

  Color get color => _color;

  set color(Color value) {
    _color = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}