import 'package:mockito/annotations.dart';
import 'package:video_game_catalogue_riverpod/providers/auth_provider.dart';
import 'package:video_game_catalogue_riverpod/providers/review_provider.dart';
import 'package:video_game_catalogue_riverpod/providers/user_session_provider.dart';

@GenerateMocks([UserSessionNotifier, ReviewNotifier, AuthNotifier])
void main() {}
