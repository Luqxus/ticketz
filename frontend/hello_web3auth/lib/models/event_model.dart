import 'package:hello_web3auth/models/location_model.dart';

class EventModel {
  final String eventId;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  // final DateTime eventDate;
  // final DateTime endDate;
  // final DateTime createdAt;
  final LocationModel location;

  EventModel({
    // required this.createdAt,
    required this.description,
    required this.price,
    // required this.eventDate,
    required this.eventId,
    required this.imageUrl,
    required this.location,
    required this.title,
    // required this.endDate,
  });

  factory EventModel.fromMap(Map<String, dynamic> data) {
    return EventModel(
      // createdAt: data['created_at']!,
      price: double.parse('${data['event_price']!}'),
      description: data['description']!,
      // eventDate: data['event_date']!,
      // endDate: data['end_time']!,
      eventId: data['event_id']!,
      imageUrl: data['image_url']!,
      location: LocationModel.fromMap(data['location']!),
      title: data['title']!,
    );
  }
}
