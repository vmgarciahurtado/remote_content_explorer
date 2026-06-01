import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_content_explorer/core/constants/env.dart';

final Provider<String> imageBaseUrlProvider = Provider<String>((Ref ref) {
  return Env.imageBaseUrl;
});

final Provider<String> actorImageBaseUrlProvider = Provider<String>((Ref ref) {
  return Env.actorImageBaseUrl;
});

final Provider<String> noImageUrlProvider = Provider<String>((Ref ref) {
  return Env.noImageUrl;
});
