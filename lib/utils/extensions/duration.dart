import 'package:car2gouser/utils/extensions/int.dart';

extension DurationToHumanReadableTime on Duration {
  int get toHumanReadableSeconds =>
      inSeconds.remainder(Duration.secondsPerMinute);
  String get toHumanReadableSecondsText => toHumanReadableSeconds.to2Digits;

  int get toHumanReadableMinutes =>
      inMinutes.remainder(Duration.minutesPerHour);

  String get toHumanReadableMinutesText => toHumanReadableMinutes.to2Digits;

  int get toHumanReadableHours => inHours.remainder(Duration.hoursPerDay);
  String get toHumanReadableHoursText => toHumanReadableHours.to2Digits;
}
