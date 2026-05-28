import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'env.dart';

final Provider<String> imageBaseUrlProvider = Provider<String>((Ref ref) {
  return Env.imageBaseUrl;
});

final Provider<String> actorImageBaseUrlProvider = Provider<String>((Ref ref) {
  return Env.actorImageBaseUrl;
});
