import "package:calendar_date_picker2/calendar_date_picker2.dart";
import "package:flutter/material.dart";
import 'package:intl/date_symbol_data_local.dart';

class CalendarDatePickerWidget extends StatefulWidget {
  const CalendarDatePickerWidget({super.key});

  @override
  State<CalendarDatePickerWidget> createState() => _CalendarDatePickerWidgetState();
}

class _CalendarDatePickerWidgetState extends State<CalendarDatePickerWidget> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeLocale();
  }

  Future<void> _initializeLocale() async {
    await initializeDateFormatting('en', null); // Remplace 'en' par ta locale si nécessaire
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<DateTime?> _singleDatePickerValueWithDefaultValue = [
      DateTime.now().add(const Duration(days: 1)),
    ];

    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: Theme.of(context).colorScheme.primary,
      weekdayLabels: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
      weekdayLabelTextStyle: const TextStyle(
        fontSize: 10
      ),
      firstDayOfWeek: 1,
      controlsHeight: 30,
      dayMaxWidth: 25,
      animateToDisplayedMonthDate: true,
      controlsTextStyle: const TextStyle(
        fontSize: 10,
      ),
      dayTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w400,
        fontSize: 10
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
          fontSize: 10
      ),
      centerAlignModePicker: true,
      useAbbrLabelForMonthModePicker: true,
      modePickersGap: 0,
      modePickerTextHandler: ({required monthDate, isMonthPicker}) {
        if (isMonthPicker ?? false) {
          // Custom month picker text
          return getLocaleShortMonthFormat(const Locale('en')).format(monthDate);
        }
        return null;
      },
      yearTextStyle: const TextStyle(
        fontSize: 10
      ),
      monthTextStyle: const TextStyle(
        fontSize: 10
      ),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month + 6,DateTime.now().day),
      /*selectableDayPredicate: (day) =>
      !day
          .difference(DateTime.now().add(const Duration(days: 3)))
          .isNegative &&
          day.isBefore(DateTime.now().add(const Duration(days: 30))),*/
    );

    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator()); // Affiche un loader en attendant l'initialisation
    }

    return Localizations.override(
      context: context,
      locale: const Locale("en"),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CalendarDatePicker2(
            displayedMonthDate: _singleDatePickerValueWithDefaultValue.first,
            config: config,
            value: _singleDatePickerValueWithDefaultValue,
            onValueChanged: (dates) => setState(
                    () => _singleDatePickerValueWithDefaultValue = dates),
          ),
         /* SizedBox(
            width: 270,
            child: CalendarDatePicker2(
              displayedMonthDate: _singleDatePickerValueWithDefaultValue.first,
              config: config,
              value: _singleDatePickerValueWithDefaultValue,
              onValueChanged: (dates) => setState(
                      () => _singleDatePickerValueWithDefaultValue = dates),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Selection(s):  '),
              const SizedBox(width: 10),
              Text(
                _getValueText(
                  config.calendarType,
                  _singleDatePickerValueWithDefaultValue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),*/
        ],
      ),
    );
  }

  String _getValueText(
      CalendarDatePicker2Type datePickerType,
      List<DateTime?> values,
      ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
          .map((v) => v.toString().replaceAll('00:00:00.000', ''))
          .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }
}
