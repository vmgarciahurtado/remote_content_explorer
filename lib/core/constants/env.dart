import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get imageBaseUrl => dotenv.env['IMAGE_BASE_URL'] ?? '';
  static String get actorImageBaseUrl =>
      dotenv.env['ACTOR_IMAGE_BASE_URL'] ?? '';
  static String get noImageUrl => dotenv.env['NO_IMAGE_URL'] ?? '';
}
