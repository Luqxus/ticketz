import 'package:equatable/equatable.dart';

class CreateEventState extends Equatable {
  final String title;
  final String description;
  final String imageUrl;
  final DateTime eventDate;
  final DateTime endDate;
  final double price;
  final String city;
  final String province;
  final String country;
  final String venue;
  final bool loading;
  final bool failed;
  final bool success;
  final String errorMessage;
  final bool createButtonPressed;

  CreateEventState({
    required this.city,
    required this.country,
    required this.description,
    required this.endDate,
    required this.eventDate,
    required this.imageUrl,
    required this.price,
    required this.province,
    required this.title,
    required this.venue,
    required this.loading,
    required this.failed,
    required this.success,
    required this.errorMessage,
    required this.createButtonPressed,
  });

  CreateEventState copyWith({
    city,
    country,
    description,
    endDate,
    eventDate,
    imageUrl,
    price,
    province,
    title,
    venue,
    loading,
    failed,
    success,
    errorMessage,
    createButtonPressed,
  }) {
    return CreateEventState(
      city: city ?? this.city,
      country: country ?? this.country,
      description: description ?? this.description,
      endDate: endDate ?? this.endDate,
      eventDate: eventDate ?? this.eventDate,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      province: province ?? this.province,
      title: title ?? this.title,
      venue: venue ?? this.venue,
      loading: loading ?? this.loading,
      failed: failed ?? this.failed,
      success: success ?? this.success,
      errorMessage: errorMessage ?? this.errorMessage,
      createButtonPressed: createButtonPressed ?? this.createButtonPressed,
    );
  }

  @override
  List<Object?> get props => [
        city,
        country,
        description,
        endDate,
        eventDate,
        imageUrl,
        price,
        province,
        title,
        venue,
        loading,
        failed,
        success,
        errorMessage,
        createButtonPressed
      ];
}
