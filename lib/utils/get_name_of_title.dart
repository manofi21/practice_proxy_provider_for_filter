import 'package:proxy_provider_for_filter/provider/reading_provider.dart';

import '../provider/base_provider.dart';
import '../provider/gaming_provider.dart';
import '../provider/watching_provider.dart';

String getNameOfTitle(BaseProvider baseProvider) {
  if (baseProvider is GamingProvider) {
    return "Game";
  }

  if (baseProvider is ReadingProvider) {
    return "Read/Book";
  }

  if (baseProvider is WatchingProvider) {
    return "Movie/Series";
  }

  return '';
}