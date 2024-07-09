import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hello_web3auth/models/event_model.dart';
import 'package:hello_web3auth/service/secure_storage.dart';
import 'package:hello_web3auth/utils/custom_exceptions.dart';

abstract class EventRepository {
  Future<void> createEvent({
    required String description,
    required DateTime eventDate,
    required String imageUrl,
    required String city,
    required String province,
    required String country,
    required String title,
    required String venue,
    required double price,
    required DateTime endDate,
  });

  Future<EventModel> getEvent({required String eventID});

  Future<List<EventModel>> getEvents();

  Future<void> bookmarkEvent({required String eventID});
}

class EventRepositoryImpl implements EventRepository {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.1.105:4000",
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60), // 60 seconds
      receiveTimeout: const Duration(seconds: 60), // 60 seconds
    ),
  );

  @override
  Future<void> createEvent({
    required String description,
    required DateTime eventDate,
    required String imageUrl,
    required String city,
    required String province,
    required String country,
    required String title,
    required String venue,
    required double price,
    required DateTime endDate,
  }) async {
    try {
      print("create event");
      Response response = await dio.post(
        "/events",
        data: {
          'description': description,
          'event_date': eventDate.toUtc().toIso8601String(),
          'image_url': imageUrl,
          'event_price': price,
          'location': {
            'city': city,
            'province': province,
            'country': country,
            'venue': venue,
          },
          'end_time': endDate.toUtc().toIso8601String(),
          'title': title,
        },
        options: Options(
          headers: {"authorization": await SecureStorage().getToken()},
        ),
      );

      if (response.statusCode != 200) {
        throw CreateEventException(jsonDecode(response.data)['message']);
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<EventModel> getEvent({required String eventID}) async {
    try {
      Response response = await dio.get("/events/event/$eventID");

      if (response.statusCode == 200) {
        return EventModel.fromMap(jsonDecode(response.data));
      }

      throw FetchEventException(jsonDecode(response.data)['message']);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<EventModel>> getEvents() async {
    try {
      Response response = await dio.get(
        "/events",
        options: Options(
          headers: {
            "authorization": await SecureStorage().getToken(),
          },
        ),
      );

      if (response.statusCode == 200) {
        List<EventModel> events = [];

        for (Map<String, dynamic> item in jsonDecode(response.data)) {
          print(item);
          events.add(EventModel.fromMap(item));
        }

        return events;
      }

      throw FetchEventException(jsonDecode(response.data)['message']);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> bookmarkEvent({required String eventID}) async {
    try {
      print("Bookmark event");
      Response response = await dio.post(
        "/events/bookmark/$eventID",
        options: Options(
          headers: {
            "authorization": await SecureStorage().getToken(),
          },
        ),
      );

      print(response.data);

      if (response.statusCode != 200) {
        throw FetchEventException(jsonDecode(response.data)['message']);
      }
    } catch (error) {
      rethrow;
    }
  }
}
