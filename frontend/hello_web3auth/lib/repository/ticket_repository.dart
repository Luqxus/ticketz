import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hello_web3auth/models/ticket_model.dart';
import 'package:hello_web3auth/utils/custom_exceptions.dart';

abstract class TicketRepository {
  Future<void> buyTicket(String token, String eventId);
  Future<TicketModel> getTicket(String token, String ticketId);
  Future<List<TicketModel>> getTickets(String token);
}

class TicketRepositoryImpl implements TicketRepository {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://20.20.90.129:4000",
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60), // 60 seconds
      receiveTimeout: const Duration(seconds: 60), // 60 seconds
    ),
  );

  @override
  Future<void> buyTicket(String token, String eventId) async {
    try {
      Response response = await dio.post(
        "/events/tickets/$eventId",
        options: Options(
          headers: {"authorization": token},
        ),
      );

      if (response.statusCode == 200) {
        return;
      }

      throw BuyTicketException(jsonDecode(response.data)['message']);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<TicketModel> getTicket(String token, String ticketId) async {
    try {
      Response response = await dio.get(
        "/events/tickets/ticket/$ticketId",
        options: Options(
          headers: {"authorization": token},
        ),
      );

      if (response.statusCode == 200) {
        return TicketModel.fromMap(jsonDecode(response.data));
      }

      throw GetTicketException(jsonDecode(response.data)['message']);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<TicketModel>> getTickets(String token) async {
    try {
      Response response = await dio.get(
        "/events/tickets",
        options: Options(
          headers: {"authorization": token},
        ),
      );

      if (response.statusCode == 200) {
        List<TicketModel> tickets = [];

        print('----------------------------------');
        print(jsonDecode(response.data));

        print('----------------------------------');

        for (Map<String, dynamic> item in jsonDecode(response.data)) {
          tickets.add(TicketModel.fromMap(item));
        }

        return tickets;
      }

      throw GetTicketException(jsonDecode(response.data)['message']);
    } catch (error) {
      rethrow;
    }
  }
}
