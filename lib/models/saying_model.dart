import '../enums/saying_type.dart';
import '../enums/language.dart';

class Saying {
  final String content;
  final SayingType type;
  final Language language;
  final String? author;
  final int? weekday;

  const Saying({
    required this.content,
    required this.type,
    this.author,
    this.language = Language.zh,
    this.weekday,
  });

  factory Saying.fromJson(Map<String, dynamic> json, Language language) {
    return Saying(
      content: json['content'] as String,
      type: SayingType.values.firstWhere((e) => e.name == json['type']),
      author: json['author'] as String?,
      language: language,
      weekday: json['weekday'] as int?,
    );
  }
}
