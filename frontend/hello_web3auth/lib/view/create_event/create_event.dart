import 'package:flutter/material.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_web3auth/view/create_event/bloc/bloc.dart';
import 'package:hello_web3auth/view/create_event/bloc/event.dart';
import 'package:hello_web3auth/view/create_event/bloc/state.dart';
import 'package:hello_web3auth/view/splash_screen.dart';

class CreateEventScreen extends StatelessWidget {
  CreateEventScreen({super.key});

  final scrollController = ScrollController();

  final controller = BoardDateTimeController();

  final ValueNotifier<DateTime> builderDate = ValueNotifier(DateTime.now());

  @override
  Widget build(BuildContext context) {
    Widget scaffold() {
      return BlocListener<CreateEventBloc, CreateEventState>(
        listener: (context, state) {
          if (state.success) {
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Create Event'),
          ),
          backgroundColor: const Color.fromARGB(255, 245, 245, 250),
          body: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 560,
                ),
                child: Column(
                  children: [
                    SectionWidget(
                      items: [
                        CustomTextFormField(
                          hintText: 'Image Url',
                          onChanged: (value) {
                            BlocProvider.of<CreateEventBloc>(context)
                                .add(SetImageUrlEvent(value));
                          },
                        ),
                        CustomTextFormField(
                          hintText: 'Title',
                          onChanged: (value) {
                            BlocProvider.of<CreateEventBloc>(context)
                                .add(SetTitleEvent(value));
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    SectionWidget(
                      items: [
                        PickerItemWidget(
                          title: 'Start Date',
                          date: ValueNotifier(
                              BlocProvider.of<CreateEventBloc>(context)
                                  .state
                                  .eventDate),
                          pickerType: DateTimePickerType.datetime,
                          onChanged: (result) {
                            BlocProvider.of<CreateEventBloc>(context)
                                .add(SetDateEvent(result));
                          },
                        ),
                        // const SizedBox(
                        //   height: 12.0,
                        // ),
                        PickerItemWidget(
                          title: 'End Date',
                          date: ValueNotifier(
                            BlocProvider.of<CreateEventBloc>(context)
                                .state
                                .endDate,
                          ),
                          pickerType: DateTimePickerType.datetime,
                          onChanged: (result) {
                            BlocProvider.of<CreateEventBloc>(context)
                                .add(SetEndDateEvent(result));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    SectionWidget(
                      items: [
                        CustomTextFormField(
                          hintText: 'Venue',
                          onChanged: (value) {
                            BlocProvider.of<CreateEventBloc>(context)
                                .add(SetVenueEvent(value));
                          },
                        ),
                        CustomTextFormField(
                          hintText: 'City',
                          onChanged: (value) {
                            BlocProvider.of<CreateEventBloc>(context)
                                .add(SetCityEvent(value));
                          },
                        ),
                        CustomTextFormField(
                          hintText: 'Province',
                          onChanged: (value) {
                            BlocProvider.of<CreateEventBloc>(context)
                                .add(SetProvinceEvent(value));
                          },
                        ),
                        CustomTextFormField(
                          hintText: 'Country',
                          onChanged: (value) {
                            BlocProvider.of<CreateEventBloc>(context)
                                .add(SetCountryEvent(value));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    SectionWidget(
                      items: [
                        CustomTextFormField(
                          hintText: 'Price',
                          onChanged: (value) {
                            BlocProvider.of<CreateEventBloc>(context)
                                .add(SetTicketPriceEvent(double.parse(value)));
                          },
                        ),
                        CustomTextFormField(
                          height: 5,
                          maxLength: 256,
                          hintText: 'Description',
                          onChanged: (value) {
                            BlocProvider.of<CreateEventBloc>(context)
                                .add(SetDescriptionEvent(value));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    _createEventButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return BlocBuilder<CreateEventBloc, CreateEventState>(
        builder: (context, state) {
      if (state.loading) {
        return const SplashScreen();
      }

      return BoardDateTimeBuilder<BoardDateTimeCommonResult>(
        builder: (context) => scaffold(),
        controller: controller,
        options: const BoardDateTimeOptions(
          languages: BoardPickerLanguages.en(),
          // boardTitle: 'Board Picker',
          // backgroundColor: Colors.black,
          // textColor: Colors.white,
          // foregroundColor: const Color(0xff303030),
          // activeColor: Colors.blueGrey,
          // backgroundDecoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: <Color>[
          //       Color(0xff1A2980),
          //       Color(0xff26D0CE),
          //     ],
          //   ),
          // ),
          // pickerSubTitles: BoardDateTimeItemTitles(year: 'year'),
          // customOptions: BoardPickerCustomOptions.every15minutes(),
          // customOptions: BoardPickerCustomOptions(
          //   hours: [0, 6, 12, 18],
          //   minutes: [0, 15, 30, 45],
          // ),
          // weekend: BoardPickerWeekendOptions(
          //   sundayColor: Colors.yellow,
          //   saturdayColor: Colors.red,
          // ),
        ),
        // minimumDate: DateTime(2023, 12, 15, 0, 15),
        // maximumDate: DateTime(2024, 12, 31),
        onChange: (val) {
          builderDate.value = val;
        },
      );
    });
  }

  _createEventButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
            onPressed: () {
              BlocProvider.of<CreateEventBloc>(context)
                  .add(CreateEventButtonPressed());
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: Text(
                'Create event',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.controller,
      required this.hintText,
      required this.onChanged,
      this.height = 1,
      this.maxLength,
      this.obscureText = false});

  final int? maxLength;
  final int height;
  final Function(String) onChanged;
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        maxLength: maxLength,
        maxLines: height,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          hintText: hintText,
          filled: true,
          fillColor:
              Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.6),
        ),
      ),
    );
  }
}

class SectionWidget extends StatelessWidget {
  final List<Widget> items;

  const SectionWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).cardColor,
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: items,
          ),
        ),
      ],
    );
  }
}

class PickerItemWidget extends StatelessWidget {
  PickerItemWidget({
    super.key,
    required this.title,
    required this.pickerType,
    required this.onChanged,
    required this.date,
  });

  final Function(DateTime) onChanged;

  final DateTimePickerType pickerType;

  final String title;

  final ValueNotifier<DateTime> date;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final result = await showBoardDateTimePicker(
            context: context,
            pickerType: pickerType,
            options: const BoardDateTimeOptions(
              languages: BoardPickerLanguages.en(),
              startDayOfWeek: DateTime.sunday,
              pickerFormat: PickerFormat.ymd,
              // boardTitle: 'Board Picker',
              // pickerSubTitles: BoardDateTimeItemTitles(year: 'year'),
            ),
            // Specify if you want changes in the picker to take effect immediately.
            valueNotifier: date,
          );
          if (result != null) {
            date.value = result;
            onChanged(result);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            children: [
              Material(
                color: pickerType.color,
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: Center(
                    child: Icon(
                      pickerType.icon,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: date,
                builder: (context, data, _) {
                  return Text(
                    BoardDateFormat(pickerType.format).format(data),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension DateTimePickerTypeExtension on DateTimePickerType {
  String get title {
    switch (this) {
      case DateTimePickerType.date:
        return 'Date';
      case DateTimePickerType.datetime:
        return 'DateTime';
      case DateTimePickerType.time:
        return 'Time';
    }
  }

  IconData get icon {
    switch (this) {
      case DateTimePickerType.date:
        return Icons.date_range_rounded;
      case DateTimePickerType.datetime:
        return Icons.date_range_rounded;
      case DateTimePickerType.time:
        return Icons.schedule_rounded;
    }
  }

  Color get color {
    switch (this) {
      case DateTimePickerType.date:
        return Colors.blue;
      case DateTimePickerType.datetime:
        return Colors.orange;
      case DateTimePickerType.time:
        return Colors.pink;
    }
  }

  String get format {
    switch (this) {
      case DateTimePickerType.date:
        return 'yyyy/MM/dd';
      case DateTimePickerType.datetime:
        return 'yyyy/MM/dd HH:mm';
      case DateTimePickerType.time:
        return 'HH:mm';
    }
  }
}
