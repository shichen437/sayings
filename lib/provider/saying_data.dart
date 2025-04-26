import 'dart:convert';
import 'dart:io';
import 'dart:math';
import '../enums/saying_type.dart';
import '../enums/language.dart';
import '../models/saying_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class SayingsData {
  static final Map<SayingType, List<Saying>> _cache = {};

  static Future<List<Saying>> getSayingsByType(
    SayingType type,
    Language language,
  ) async {
    final sayings = await _loadSayings(type, language);
    final filteredByLanguage = sayings.where((s) => s.language == language);

    if (type == SayingType.week) {
      final currentWeekday = DateTime.now().weekday;
      return filteredByLanguage
          .where((s) => s.weekday == currentWeekday)
          .toList();
    }

    return filteredByLanguage.toList();
  }

  static Future<Saying> getRandomSaying({
    SayingType? type,
    Language? language,
  }) async {
    final sayingType = type ?? _getRandomType();
    final currentLanguage = language ?? _getCurrentLanguage();
    final sayings = await getSayingsByType(sayingType, currentLanguage);
    if (sayings.isEmpty) {
      throw Exception('No Found Sayings');
    }
    final random = Random();
    return sayings[random.nextInt(sayings.length)];
  }

  static Future<List<Saying>> _loadSayings(
    SayingType type,
    Language language,
  ) async {
    if (_cache.containsKey(type)) return _cache[type]!;

    final indexContent = await rootBundle.loadString(
      'packages/sayings/lib/data/index.json',
    );
    final indexData = jsonDecode(indexContent);
    final fileName = indexData['files'][language.name][type.name];

    final content = await rootBundle.loadString(
      'packages/sayings/lib/data/$fileName',
    );
    final data = jsonDecode(content);
    final sayings =
        (data['sayings'] as List)
            .map((s) => Saying.fromJson(s, language))
            .toList();

    _cache[type] = sayings;
    return sayings;
  }

  static SayingType _getRandomType() {
    final types = SayingType.values.toList();
    final random = Random();
    return types[random.nextInt(types.length)];
  }

  static Language _getCurrentLanguage() {
    final String systemLanguage = Platform.localeName.toLowerCase();
    if (systemLanguage.contains('zh') || systemLanguage.contains('cn')) {
      return Language.zh;
    }
    return Language.en;
  }
}
