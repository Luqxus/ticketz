import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hello_web3auth/models/event_model.dart';
import 'package:hello_web3auth/utils/custom_exceptions.dart';

abstract class EventRespository {
  Future<void> createEvent({
    required String description,
    required DateTime eventDate,
    required String imageUrl,
    required List<double> location,
    required String title,
  });

  Future<EventModel> getEvent({required String eventID});

  Future<List<EventModel>> getEvents();
}

class EventRepositoryImpl implements EventRespository {
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
    required List<double> location,
    required String title,
  }) async {
    try {
      Response response = await dio.post("/events", data: {
        'description': description,
        'eventDate': eventDate,
        'imageUrl': imageUrl,
        'location': location,
        'title': title,
      });

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
      Response response = await dio.get("/events");

      if (response.statusCode == 200) {
        List<EventModel> events = [];

        for (Map<String, dynamic> item in jsonDecode(response.data)['events']) {
          events.add(EventModel.fromMap(item));
        }

        return events;
      }

      throw FetchEventException(jsonDecode(response.data)['message']);
    } catch (error) {
      rethrow;
    }
  }
}
