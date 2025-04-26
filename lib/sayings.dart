import 'enums/saying_type.dart';
import 'provider/saying_data.dart';
import 'enums/language.dart';
import 'models/saying_model.dart';

export 'enums/saying_type.dart';
export 'enums/language.dart';
export 'models/saying_model.dart';

class Sayings {
  // 获取随机格言
  Future<Saying> getRandomSaying({SayingType? type, Language? language}) async {
    return await SayingsData.getRandomSaying(type: type, language: language);
  }

  // 获取随机格言内容
  Future<String> getRandomSayingContent({
    SayingType? type,
    Language? language,
  }) async {
    final saying = await SayingsData.getRandomSaying(
      type: type,
      language: language,
    );
    return saying.content;
  }
}
