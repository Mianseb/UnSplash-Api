class Photo {
  late String raw;
  late String full;
  late String regular;
  late String small;
  late String thumb;

  Photo(
      {required this.raw,
      required this.full,
      required this.regular,
      required this.small,
      required this.thumb});

  factory Photo.fromJson(Map<String, dynamic> map) {
    return Photo(
      raw: map['urls']['raw'],
      full: map['urls']['full'],
      regular: map['urls']['regular'],
      small: map['urls']['small'],
      thumb: map['urls']['thumb'],
    );
  }
}
