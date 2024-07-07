import 'package:hello_web3auth/models/location_model.dart';

class TicketModel {
  final String ticketId;
  final String eventId;
  final String eventTitle;
  final double eventPrice;
  final LocationModel location;
  final String imageUrl;

  TicketModel({
    required this.eventId,
    required this.ticketId,
    required this.eventPrice,
    required this.eventTitle,
    required this.imageUrl,
    required this.location,
  });

  factory TicketModel.fromMap(Map<String, dynamic> data) {
    return TicketModel(
      eventId: data['event_id'],
      ticketId: data['ticket_id'],
      eventPrice: double.parse('${data['price']}'),
      eventTitle: data['event_title'],
      imageUrl: data['image_url'],
      location: LocationModel.fromMap(data['location']),
    );
  }
}
