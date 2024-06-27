import 'package:dio/dio.dart';
import 'package:hello_web3auth/models/user_model.dart';
import 'package:hello_web3auth/utils/custom_exceptions.dart';
import 'package:hello_web3auth/utils/signin_response.dart';

abstract class UserRepository {
  Future<void> signup(
      {required String email,
      required String username,
      required String password});

  Future<SignInResponse> signin(
      {required String email, required String password});
}

class UserRepositoryImpl implements UserRepository {
  final Dio dio = Dio();
  final baseUrl = "127.0.0.1:3000";

  @override
  Future<SignInResponse> signin(
      {required String email, required String password}) async {
    try {
      Response response = await dio.post("$baseUrl/users/signin",
          data: {"email": email, "password": password});

      if (response.statusCode == 200) {
        return SignInResponse(
            response.data['email'], response.headers.value('authorization')!);
      }

      throw UnauthorizedException(response.data['message']);
    } catch (e) {
      throw UnauthorizedException(e.toString());
    }
  }

  @override
  Future<void> signup(
      {required String email,
      required String username,
      required String password}) async {
    try {
      Response response = await dio.post("$baseUrl/user/signup",
          data: {"email": email, "password": password});

      if (response.statusCode == 200) {
        return;
      }

      throw SignUpException(response.data['message']);
    } catch (e) {
      rethrow;
    }
  }
}
