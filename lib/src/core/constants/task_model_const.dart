import 'package:flutter/material.dart';

const Map<int, String> taskRepeats = {
  0: 'None',
  1: 'Daily',
  2: 'Weekly',
  3: 'Monthly',
};

String getRepeat(int repeatIndex) {
  switch (repeatIndex) {
    case 0:
      return 'None';
    case 1:
      return 'Daily';
    case 2:
      return 'Weekly';
    case 3:
      return 'Monthly';
    default:
      return 'Unknown repeat value!';
  }
}

const Map<int, String> taskReminders = {
  0: 'None',
  1: '10 minutes early',
  2: '30 minutes early',
  3: '1 hour early',
  4: '1 day early',
};

String getReminder(int reminderIndex) {
  switch (reminderIndex) {
    case 0:
      return 'None';
    case 1:
      return '10 minutes early';
    case 2:
      return '30 minutes early';
    case 3:
      return '1 hour early';
    case 4:
      return '1 day early';
    default:
      return 'Unknown reminder value!';
  }
}

const Map<int, Color> taskColors = {
  0: Colors.blue,
  1: Colors.red,
  2: Colors.orange,
  3: Colors.cyan,
  4: Colors.teal,
};
