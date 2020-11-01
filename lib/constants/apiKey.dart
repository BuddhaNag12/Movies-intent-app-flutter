import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKey {
  final String apiKey = DotEnv().env['API_KEY'];
}
