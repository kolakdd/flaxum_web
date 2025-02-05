import 'package:flaxum_fileshare/app/api/dio_client.dart';

// Авторизировать пользователя и вернуть токен авторизации
Future<String?> authorizationUser(String email, String password) async {
  var response = await dioUnauthorized.post('/user/login', data: {
    'email': email,
    'password': password,
  });
  if (response.statusCode == 200) {
    return response.data["token"];
  } else {
    throw Exception("Wrong password or email");
  }
}
