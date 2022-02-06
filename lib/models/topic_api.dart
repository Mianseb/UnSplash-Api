import 'package:flutter/foundation.dart';

class Topic {
  late String title;
  late String photos;

  Topic({required this.title, required this.photos});

  factory Topic.fromJson(Map<String, dynamic> map) {
    return Topic(
      title: map['title'],
      photos: map['links']['photos'],
    );
  }
}
