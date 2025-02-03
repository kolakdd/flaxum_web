import 'package:flaxum_fileshare/dio_client.dart';
import 'package:flaxum_fileshare/network/users/login_user.dart';

// Зарегестрировать пользователя, после чего
// авторизовать и вернуть токен авторизации
Future<String?> registerUser(
    String email, String password, String userName) async {
  var response = await dioUnauthorized.post('/user/register', data: {
    'email': email,
    'password': password,
    'user_name': userName,
  });
  if (response.statusCode == 201) {
    return await authorizationUser(email, password);
  } else if (response.statusCode == 401) {
    throw Exception('User already registered');
  } else {
    throw Exception('Failed to load objects');
  }
}
