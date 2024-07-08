import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hello_web3auth/models/user_model.dart';
import 'package:hello_web3auth/utils/custom_exceptions.dart';
import 'package:hello_web3auth/utils/signin_response.dart';

abstract class UserRepository {
  Future<SignInResponse> signup(
      {required String email,
      required String username,
      required String password});

  Future<SignInResponse> signin(
      {required String email, required String password});
}

class UserRepositoryImpl implements UserRepository {
  // new dio instance
  // final baseUrl = "http://192.168.1.105:4000";
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://20.20.90.129:4000",
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60), // 60 seconds
      receiveTimeout: const Duration(seconds: 60), // 60 seconds
    ),
  );

  @override
  Future<SignInResponse> signin(
      {required String email, required String password}) async {
    // Sign in function
    try {
      // send signin request
      Response response = await dio
          .post("/users/signin", data: {"email": email, "password": password});

      print(response.data);
      print(response.headers.value('authorization')!);
      print("status : ${response.statusCode}");

      // check if response status code is 200
      if (response.statusCode == 200) {
        // if so the return signInResponse instance
        print("respose status : ${response.statusCode}");
        print(jsonDecode(response.data));
        return SignInResponse(jsonDecode(response.data)["email"],
            response.headers.value('authorization')!);
      }

      throw UnauthorizedException("wrong email or password");
    } catch (e) {
      // print(e.toString());
      throw UnauthorizedException(e.toString());
    }
  }

  @override
  Future<SignInResponse> signup(
      {required String email,
      required String username,
      required String password}) async {
    try {
      // send signup request
      Response response = await dio.post("/users/register", data: {
        "email": email,
        "password": password,
        "username": username,
      });

      // check if response status code is 200
      if (response.statusCode == 200) {
        // if so return SignInResponse instance
        return SignInResponse(
            response.data["email"], response.headers.value('authorization')!);
      }

      throw SignUpException(response.data['message']);
    } catch (e) {
      rethrow;
    }
  }
}
