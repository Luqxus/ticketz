class EventModel {
  final String eventId;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime eventDate;
  final DateTime createdAt;
  final LocationModel location;

  EventModel({
    required this.createdAt,
    required this.description,
    required this.eventDate,
    required this.eventId,
    required this.imageUrl,
    required this.location,
    required this.title,
  });

  factory EventModel.fromMap(Map<String, dynamic> data) {
    return EventModel(
      createdAt: data['createdAt']!,
      description: data['description']!,
      eventDate: data['eventDate']!,
      eventId: data['eventId']!,
      imageUrl: data['imageUrl']!,
      location: LocationModel.fromMap(data['location']!),
      title: data['title']!,
    );
  }
}

class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel({required this.latitude, required this.longitude});

  factory LocationModel.fromMap(Map<String, double> data) {
    return LocationModel(
        latitude: data['latitude']!, longitude: data['longitude']!);
  }
}
