// routes/admin/_middleware.dart
import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'user_repository.dart';

Handler middleware(Handler handler) {
  return handler.use(
    basicAuthentication<User>(
      authenticator: (context, username, password) {
        final userRepository = context.read<UserRepository>();
        return userRepository.fetchFromCredentials(username, password);
      },
    ),
  );
}
