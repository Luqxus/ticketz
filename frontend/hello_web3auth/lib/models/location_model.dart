class LocationModel {
  final String city;
  final String province;
  final String country;
  final String venue;

  LocationModel({
    required this.city,
    required this.province,
    required this.country,
    required this.venue,
  });

  factory LocationModel.fromMap(Map<String, dynamic> data) {
    return LocationModel(
      city: data['city']!,
      province: data['province']!,
      country: data['country']!,
      venue: data['venue']!,
    );
  }
}
