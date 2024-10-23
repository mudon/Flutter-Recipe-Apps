// ignore_for_file: unused_field

class Recipe {
  final String name;
  String? _namaSamaran;
  String? _laluanGambar;
  final Map<String, List<String>> bahan;
  final Map<String, List<String>> penyediaan;

  Recipe({
    required this.name,
    String? laluanGambar,
    required this.bahan,
    required this.penyediaan,
    String? namaSamaran,
  });

  String? get namaSamaran =>
      _namaSamaran = name.toLowerCase().replaceAll(' ', '-');

  String? get laluanGambar => _laluanGambar;

  set laluanGambar(String? value) {
    _laluanGambar =
        value != null ? 'http://10.0.2.2:3000/recipeImage?$value.jpeg' : null;
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      name: map['name'],
      laluanGambar: map['laluanGambar'],
      bahan: convertToListStringMap(map['bahan']),
      penyediaan: convertToListStringMap(map['penyediaan']),
      namaSamaran: map['namaSamaran'],
    );
  }

  static Map<String, List<String>> convertToListStringMap(
      Map<String, dynamic> input) {
    return input.map((key, value) {
      if (value is List<dynamic>) {
        return MapEntry(key, value.cast<String>());
      } else {
        throw TypeError(); // Handle this case as necessary
      }
    });
  }
}
