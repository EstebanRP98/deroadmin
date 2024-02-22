import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

String createMessage(
  String negocio,
  String numero,
) {
  String mensajeEnvio = "";

  mensajeEnvio = "https://api.whatsapp.com/send?phone=+593" +
      numero +
      "&text=Hola%20Dero%2C%20quiero%20generar%20un%20recordatorio%20para%20mi%20cita%20en%20" +
      negocio;

  return mensajeEnvio;
}

String? generateRandomUUID() {
  int length = 20;
  const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  math.Random r = math.Random();
  String ran = "";
  ran = ran +
      String.fromCharCodes(Iterable.generate(
          length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  return ran;
}

int add(
  int x1,
  int y1,
) {
  return x1 + y1;
}

dynamic dateInfoCopy(DateTime dateObj) {
  var weekdays = ['', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
  var months = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  return {
    'day': dateObj.day.toInt(),
    'weekday': weekdays[dateObj.weekday],
    'month': months[dateObj.month]
  };
}

dynamic dateInfo(DateTime dateObj) {
  var weekdays = ['', 'LUN', 'MAR', 'MIE', 'JUE', 'VIE', 'SAB', 'DOM'];
  var months = [
    '',
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Augosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];

  return {
    'day': dateObj.day.toInt(),
    'weekday': weekdays[dateObj.weekday],
    'month': months[dateObj.month]
  };
}

int eventDuration(
  dynamic event,
  int hourHeight,
) {
// given a list of maps with start and end timestamps as strings, return the total duration of time
  DateTime start = DateTime.parse(event['start_time']);
  DateTime end = DateTime.parse(event['end_time']);
  return (hourHeight * (end.difference(start).inSeconds ~/ 60) ~/ 60);
}

List<DateTime> generateSurroundingDays(DateTime? selectedDay) {
// Add your function code here!
  if (selectedDay == null) {
    return [];
  }

  final List<DateTime> days = [];

  for (int i = -3; i <= 3; i++) {
    days.add(selectedDay.add(Duration(days: i)));
  }

  return days;
}

dynamic getEvents() {
// return a JSON array of strings, each string being an hour of the day
  var today = DateTime.now();
  var yesterday = today.subtract(Duration(days: 1));
  var tomorrow = today.add(Duration(days: 1));
  var nextDay = today.add(Duration(days: 2));

  var colors = {
    'work': '#BAB4F9', // purple
    'health': '#BCF0EA', // green
    'personal': '#F7CAB6', // orange
    'meals': '#FFADB3', // pink
    'travel': '#D0D7DC', // grey
  };

  var events = {
    'events': [
      // Yesterday
      {
        'title': '✈️ Flight to SF',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 3, 0)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 15, 0)),
        'description':
            'Lufthansa flight 8621\nDeparting Munich MUC airport\nTerminal 2; Gate 21D',
        'location': 'MUC Airport',
        'alert': '2 hours before',
        'color': colors['travel'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          },
          {
            'name': 'JP',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fjp.jpg?alt=media&token=ce97b2fe-f4d8-4d92-8f1c-486049020c21'
          }
        ]
      },
      {
        'title': 'Watch Black Adam 🍿',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 6, 0)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 8, 0)),
        'description':
            'In ancient Kahndaq, Teth Adam was bestowed the almighty powers of the gods. After using these powers for vengeance, he was imprisoned, becoming Black Adam. Nearly 5,000 years have passed, and Black Adam has gone from man to myth to legend. Now free, his unique form of justice, born out of rage, is challenged by modern-day heroes who form the Justice Society: Hawkman, Dr. Fate, Atom Smasher and Cyclone.',
        'location': 'In-flight entertainment',
        'alert': 'No alerts set',
        'color': colors['personal'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          }
        ]
      },
      {
        'title': 'Uber to hotel',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 15, 30)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 16, 0)),
        'description':
            'For Terminals 1-3, UberX, UberPool, and Express Pool pickups take place on Level 5 of the Domestic Garage, while all other pickups at Terminals 1-3 are curbside on the Departures Level (2nd floor, domestic).',
        'location': 'SFO Arrivals (Level 5)',
        'alert': 'No alerts set',
        'color': colors['travel'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          }
        ]
      },
      {
        'title': 'Walk with JP 🚶',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 17, 45)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 18, 30)),
        'description':
            'Just an evening walk with the little guy. Make sure to check the weather forecast (but it`s definitely better than Munich lol). Time adjustment means he might already be asleep.',
        'location': 'Palo Alto, CA',
        'alert': 'No alerts set',
        'color': colors['personal'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'JP',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fjp.jpg?alt=media&token=ce97b2fe-f4d8-4d92-8f1c-486049020c21'
          }
        ]
      },
      {
        'title': 'Debug with Maggie',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 19, 0)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 20, 0)),
        'description':
            'Date night! But with laptops. We need to ensure the order confirmation email has all fields set correctly.',
        'location': 'Late Night Coffee, 54 Main Street',
        'alert': 'No alerts set',
        'color': colors['work'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          }
        ]
      },
// Today
      {
        'title': 'Coffee ☕️',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 7, 30)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 8, 00)),
        'description':
            'Quick trip to pick up the lifeblood that gets me through each day.',
        'location': 'Blue Bottle',
        'alert': 'No alerts set',
        'color': colors['meals'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          }
        ]
      },
      {
        'title': 'Design sprint 💎',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 8, 30)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 10, 30)),
        'description':
            'Brainstorming design and flow for Cloud Function marketplace within FlutterFlow with user-customizable features.',
        'location': 'FlutterFlow HQ',
        'alert': '10 minutes before',
        'color': colors['work'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          },
          {
            'name': 'Andrew',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fandrew.jpg?alt=media&token=b2841046-d7d7-45d5-99ab-71253255fe31'
          },
          {
            'name': 'Alex',
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Falex.jpg?alt=media&token=16b79ff2-9577-4666-8f68-03a77afd7d80'
          },
          {
            'name': 'Abel',
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fabel.jpg?alt=media&token=740e83bc-029e-46de-910c-3c0402ce3880'
          },
        ]
      },
      {
        'title': 'Napkin sketches!',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 8, 15)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 8, 45)),
        'description':
            'Low-fidelity mockups to explore potential directions ahead of the design sprint.',
        'location': 'FlutterFlow HQ',
        'alert': 'No alerts set',
        'color': colors['personal'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          }
        ]
      },
      {
        'title': 'Abel <> Michael 1:1',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 13, 0)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 14, 0)),
        'description':
            '- Review next quarter OKRs\n- Roadmap updates\n- Maybe play ping pong',
        'location': 'FlutterFlow HQ',
        'alert': '10 minutes before',
        'color': colors['work'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Abel',
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fabel.jpg?alt=media&token=740e83bc-029e-46de-910c-3c0402ce3880'
          },
        ]
      },
      {
        'title': 'A-team sync up',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 11, 15)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 12, 05)),
        'description':
            'The three As discuss ongoing projects and international hiring policies.',
        'location': 'FlutterFlow HQ',
        'alert': '10 minutes before',
        'color': colors['work'],
        'guests': [
          {
            'name': 'Andrew',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fandrew.jpg?alt=media&token=b2841046-d7d7-45d5-99ab-71253255fe31'
          },
          {
            'name': 'Abel',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fabel.jpg?alt=media&token=740e83bc-029e-46de-910c-3c0402ce3880'
          },
          {
            'name': 'Alex',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Falex.jpg?alt=media&token=16b79ff2-9577-4666-8f68-03a77afd7d80'
          },
        ]
      },
      {
        'title': 'Lunch pick-up',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 12, 30)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 12, 50)),
        'description':
            'Order was already placed, just need to pick it up. Love that this is it`s own calendar event :)',
        'location': 'Doppio Zero',
        'alert': 'No alerts set',
        'color': colors['meals'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          }
        ]
      },
      {
        'title': 'Gretchen | Michael sync',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 14, 25)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 14, 55)),
        'description':
            'Chat about ways to optimize bi-weekly newsletter curation process. Virtual meeting.',
        'location': 'FlutterFlow HQ',
        'alert': '10 minutes before',
        'color': colors['meals'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Gretchen',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fgretchen.jpg?alt=media&token=06d1aa9b-9811-4bf7-a022-2afb4d0d2f55'
          },
        ]
      },
      {
        'title': 'Gym 💪',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 18, 0)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 18, 30)),
        'description':
            '- Dumbbell squats — 3x8\n- Standing shoulder press — 3x8\n- Dumbbell lunge — 2x10 (per leg)',
        'location': '24 Hour Fitness',
        'alert': '10 minutes before',
        'color': colors['health'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          }
        ]
      },
      {
        'title': 'FlutterFlow competition!',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 16, 0)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 19, 0)),
        'description':
            'To celebrate 2 years of FlutterFlow, FlutterFlow is hosting a design competition 🎉',
        'location': 'FlutterFlow HQ',
        'alert': '10 minutes before',
        'color': colors['personal'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          }
        ]
      },
      {
        'title': '🍜 Dinner!',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 19, 05)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 19, 35)),
        'description': 'Ramen tonight 😋 🍜',
        'location': 'IPPUDO, 18 Yerba Buena Ln.',
        'alert': 'No alerts set',
        'color': colors['meals'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          }
        ]
      },
// Tomorrow
      {
        'title': 'Inbox zero',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 7, 0)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 7, 45)),
        'description': 'Quick inbox scrub.',
        'location': 'Coupa Cafe - Ramona',
        'alert': 'No alerts set',
        'color': colors['personal'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
        ]
      },
      {
        'title': 'Bug smash',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 7, 15)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 8, 0)),
        'description':
            'Investigate deep linking behavior upon initial startup (use debug flag in URL params).',
        'location': 'Coupa Cafe - Ramona',
        'alert': 'No alerts set',
        'color': colors['meals'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          },
        ]
      },
      {
        'title': 'Timeline updates',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 7, 5)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 7, 55)),
        'description':
            'We`re actually running ahead of schedule this cycle 🥳 -- any tickets to pull from the backlog?',
        'location': 'Coupa Cafe - Ramona',
        'alert': 'No alerts set',
        'color': colors['meals'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
        ]
      },
      {
        'title': 'Alex <> Michael 1:1',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 45)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 11, 15)),
        'description':
            '- Understand growth trajectory\n- Discuss reliability KPMs\n- Walking meeting?',
        'location': 'FlutterFlow HQ',
        'alert': '10 minutes before',
        'color': colors['work'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Alex',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Falex.jpg?alt=media&token=16b79ff2-9577-4666-8f68-03a77afd7d80'
          },
        ]
      },
      {
        'title': 'Offsite! 🐳',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 12, 0)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 17, 0)),
        'description':
            'We`re headed to Santa Cruz for some whale watching! 7 different species of whales and Dolphin!',
        'location': 'Santa Cruz Whale Watching',
        'alert': '30 minutes before',
        'color': colors['personal'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          },
          {
            'name': 'Alex',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Falex.jpg?alt=media&token=16b79ff2-9577-4666-8f68-03a77afd7d80'
          },
          {
            'name': 'Andrew',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fandrew.jpg?alt=media&token=b2841046-d7d7-45d5-99ab-71253255fe31'
          },
          {
            'name': 'Abel',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fabel.jpg?alt=media&token=740e83bc-029e-46de-910c-3c0402ce3880'
          },
          {
            'name': 'Gretchen',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fgretchen.jpg?alt=media&token=06d1aa9b-9811-4bf7-a022-2afb4d0d2f55'
          },
        ]
      },
      {
        'title': 'M&M date night 🥂',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 18, 30)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 20, 30)),
        'description':
            'Reservation is at 6:45 and sunset is right around then. They might be able to seat us early.',
        'location': 'Top of the Mark',
        'alert': 'No alerts set',
        'color': colors['meals'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          },
        ]
      },
      {
        'title': 'Babysitter',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 18, 05)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 21, 00)),
        'description':
            'Lidia can watch JP from 6-9pm. She already has a new toy picked out to show him!',
        'location': 'Palo Alto',
        'alert': 'No alerts set',
        'color': colors['personal'],
        'guests': [
          {
            'name': 'JP',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fjp.jpg?alt=media&token=ce97b2fe-f4d8-4d92-8f1c-486049020c21'
          }
        ]
      },
// Next day
      {
        'title': '✈️ Flight to SF',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(nextDay.year, nextDay.month, nextDay.day, 6, 5)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(nextDay.year, nextDay.month, nextDay.day, 18, 35)),
        'description':
            'Lufthansa flight 44\nDeparting San Francisco SFO airport\nTerminal B; Gate 50',
        'location': 'SFO Airport',
        'alert': '2 hours before',
        'color': colors['travel'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          },
          {
            'name': 'JP',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fjp.jpg?alt=media&token=ce97b2fe-f4d8-4d92-8f1c-486049020c21'
          }
        ]
      }
    ] // END OF EVENTS
  };
  return events;
}

dynamic getHours() {
// return a JSON array of strings, each string being an hour of the day
  var hours = {
    'hours': [
      {'hour': '12:00', 'period': 'a.m.'},
      {'hour': '1:00', 'period': 'a.m.'},
      {'hour': '2:00', 'period': 'a.m.'},
      {'hour': '3:00', 'period': 'a.m.'},
      {'hour': '4:00', 'period': 'a.m.'},
      {'hour': '5:00', 'period': 'a.m.'},
      {'hour': '6:00', 'period': 'a.m.'},
      {'hour': '7:00', 'period': 'a.m.'},
      {'hour': '8:00', 'period': 'a.m.'},
      {'hour': '9:00', 'period': 'a.m.'},
      {'hour': '10:00', 'period': 'a.m.'},
      {'hour': '11:00', 'period': 'a.m.'},
      {'hour': '12:00', 'period': 'p.m.'},
      {'hour': '1:00', 'period': 'p.m.'},
      {'hour': '2:00', 'period': 'p.m.'},
      {'hour': '3:00', 'period': 'p.m.'},
      {'hour': '4:00', 'period': 'p.m.'},
      {'hour': '5:00', 'period': 'p.m.'},
      {'hour': '6:00', 'period': 'p.m.'},
      {'hour': '7:00', 'period': 'p.m.'},
      {'hour': '8:00', 'period': 'p.m.'},
      {'hour': '9:00', 'period': 'p.m.'},
      {'hour': '10:00', 'period': 'p.m.'},
      {'hour': '11:00', 'period': 'p.m.'},
    ]
  };
  return hours;
}

dynamic getEventsCopy() {
// return a JSON array of strings, each string being an hour of the day
  var today = DateTime.now();
  var yesterday = today.subtract(Duration(days: 1));
  var tomorrow = today.add(Duration(days: 1));
  var nextDay = today.add(Duration(days: 2));

  var colors = {
    'work': '#BAB4F9', // purple
    'health': '#BCF0EA', // green
    'personal': '#F7CAB6', // orange
    'meals': '#FFADB3', // pink
    'travel': '#D0D7DC', // grey
  };

  var events = {
    'events': [
      // Yesterday
      {
        'title': '✈️ Flight to SF',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 3, 0)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 15, 0)),
        'description':
            'Lufthansa flight 8621\nDeparting Munich MUC airport\nTerminal 2; Gate 21D',
        'location': 'MUC Airport',
        'alert': '2 hours before',
        'color': colors['travel'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          },
          {
            'name': 'JP',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fjp.jpg?alt=media&token=ce97b2fe-f4d8-4d92-8f1c-486049020c21'
          }
        ]
      },
      {
        'title': 'Watch Black Adam 🍿',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 6, 0)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 8, 0)),
        'description':
            'In ancient Kahndaq, Teth Adam was bestowed the almighty powers of the gods. After using these powers for vengeance, he was imprisoned, becoming Black Adam. Nearly 5,000 years have passed, and Black Adam has gone from man to myth to legend. Now free, his unique form of justice, born out of rage, is challenged by modern-day heroes who form the Justice Society: Hawkman, Dr. Fate, Atom Smasher and Cyclone.',
        'location': 'In-flight entertainment',
        'alert': 'No alerts set',
        'color': colors['personal'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          }
        ]
      },
      {
        'title': 'Uber to hotel',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 15, 30)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 16, 0)),
        'description':
            'For Terminals 1-3, UberX, UberPool, and Express Pool pickups take place on Level 5 of the Domestic Garage, while all other pickups at Terminals 1-3 are curbside on the Departures Level (2nd floor, domestic).',
        'location': 'SFO Arrivals (Level 5)',
        'alert': 'No alerts set',
        'color': colors['travel'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          }
        ]
      },
      {
        'title': 'Walk with JP 🚶',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 17, 45)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 18, 30)),
        'description':
            'Just an evening walk with the little guy. Make sure to check the weather forecast (but it`s definitely better than Munich lol). Time adjustment means he might already be asleep.',
        'location': 'Palo Alto, CA',
        'alert': 'No alerts set',
        'color': colors['personal'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'JP',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fjp.jpg?alt=media&token=ce97b2fe-f4d8-4d92-8f1c-486049020c21'
          }
        ]
      },
      {
        'title': 'Debug with Maggie',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 19, 0)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(yesterday.year, yesterday.month, yesterday.day, 20, 0)),
        'description':
            'Date night! But with laptops. We need to ensure the order confirmation email has all fields set correctly.',
        'location': 'Late Night Coffee, 54 Main Street',
        'alert': 'No alerts set',
        'color': colors['work'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          }
        ]
      },
// Today
      {
        'title': 'Coffee ☕️',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 7, 30)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 8, 00)),
        'description':
            'Quick trip to pick up the lifeblood that gets me through each day.',
        'location': 'Blue Bottle',
        'alert': 'No alerts set',
        'color': colors['meals'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          }
        ]
      },
      {
        'title': 'Design sprint 💎',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 8, 30)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 10, 30)),
        'description':
            'Brainstorming design and flow for Cloud Function marketplace within FlutterFlow with user-customizable features.',
        'location': 'FlutterFlow HQ',
        'alert': '10 minutes before',
        'color': colors['work'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          },
          {
            'name': 'Andrew',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fandrew.jpg?alt=media&token=b2841046-d7d7-45d5-99ab-71253255fe31'
          },
          {
            'name': 'Alex',
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Falex.jpg?alt=media&token=16b79ff2-9577-4666-8f68-03a77afd7d80'
          },
          {
            'name': 'Abel',
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fabel.jpg?alt=media&token=740e83bc-029e-46de-910c-3c0402ce3880'
          },
        ]
      },
      {
        'title': 'Napkin sketches!',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 8, 15)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 8, 45)),
        'description':
            'Low-fidelity mockups to explore potential directions ahead of the design sprint.',
        'location': 'FlutterFlow HQ',
        'alert': 'No alerts set',
        'color': colors['personal'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          }
        ]
      },
      {
        'title': 'Abel <> Michael 1:1',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 13, 0)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 14, 0)),
        'description':
            '- Review next quarter OKRs\n- Roadmap updates\n- Maybe play ping pong',
        'location': 'FlutterFlow HQ',
        'alert': '10 minutes before',
        'color': colors['work'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Abel',
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fabel.jpg?alt=media&token=740e83bc-029e-46de-910c-3c0402ce3880'
          },
        ]
      },
      {
        'title': 'A-team sync up',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 11, 15)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 12, 05)),
        'description':
            'The three As discuss ongoing projects and international hiring policies.',
        'location': 'FlutterFlow HQ',
        'alert': '10 minutes before',
        'color': colors['work'],
        'guests': [
          {
            'name': 'Andrew',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fandrew.jpg?alt=media&token=b2841046-d7d7-45d5-99ab-71253255fe31'
          },
          {
            'name': 'Abel',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fabel.jpg?alt=media&token=740e83bc-029e-46de-910c-3c0402ce3880'
          },
          {
            'name': 'Alex',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Falex.jpg?alt=media&token=16b79ff2-9577-4666-8f68-03a77afd7d80'
          },
        ]
      },
      {
        'title': 'Lunch pick-up',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 12, 30)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 12, 50)),
        'description':
            'Order was already placed, just need to pick it up. Love that this is it`s own calendar event :)',
        'location': 'Doppio Zero',
        'alert': 'No alerts set',
        'color': colors['meals'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          }
        ]
      },
      {
        'title': 'Gretchen | Michael sync',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 14, 25)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 14, 55)),
        'description':
            'Chat about ways to optimize bi-weekly newsletter curation process. Virtual meeting.',
        'location': 'FlutterFlow HQ',
        'alert': '10 minutes before',
        'color': colors['meals'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Gretchen',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fgretchen.jpg?alt=media&token=06d1aa9b-9811-4bf7-a022-2afb4d0d2f55'
          },
        ]
      },
      {
        'title': 'Gym 💪',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 18, 0)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 18, 30)),
        'description':
            '- Dumbbell squats — 3x8\n- Standing shoulder press — 3x8\n- Dumbbell lunge — 2x10 (per leg)',
        'location': '24 Hour Fitness',
        'alert': '10 minutes before',
        'color': colors['health'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          }
        ]
      },
      {
        'title': 'FlutterFlow competition!',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 16, 0)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 19, 0)),
        'description':
            'To celebrate 2 years of FlutterFlow, FlutterFlow is hosting a design competition 🎉',
        'location': 'FlutterFlow HQ',
        'alert': '10 minutes before',
        'color': colors['personal'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          }
        ]
      },
      {
        'title': '🍜 Dinner!',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 19, 05)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(today.year, today.month, today.day, 19, 35)),
        'description': 'Ramen tonight 😋 🍜',
        'location': 'IPPUDO, 18 Yerba Buena Ln.',
        'alert': 'No alerts set',
        'color': colors['meals'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          }
        ]
      },
// Tomorrow
      {
        'title': 'Inbox zero',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 7, 0)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 7, 45)),
        'description': 'Quick inbox scrub.',
        'location': 'Coupa Cafe - Ramona',
        'alert': 'No alerts set',
        'color': colors['personal'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
        ]
      },
      {
        'title': 'Bug smash',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 7, 15)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 8, 0)),
        'description':
            'Investigate deep linking behavior upon initial startup (use debug flag in URL params).',
        'location': 'Coupa Cafe - Ramona',
        'alert': 'No alerts set',
        'color': colors['meals'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          },
        ]
      },
      {
        'title': 'Timeline updates',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 7, 5)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 7, 55)),
        'description':
            'We`re actually running ahead of schedule this cycle 🥳 -- any tickets to pull from the backlog?',
        'location': 'Coupa Cafe - Ramona',
        'alert': 'No alerts set',
        'color': colors['meals'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
        ]
      },
      {
        'title': 'Alex <> Michael 1:1',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 10, 45)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 11, 15)),
        'description':
            '- Understand growth trajectory\n- Discuss reliability KPMs\n- Walking meeting?',
        'location': 'FlutterFlow HQ',
        'alert': '10 minutes before',
        'color': colors['work'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Alex',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Falex.jpg?alt=media&token=16b79ff2-9577-4666-8f68-03a77afd7d80'
          },
        ]
      },
      {
        'title': 'Offsite! 🐳',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 12, 0)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 17, 0)),
        'description':
            'We`re headed to Santa Cruz for some whale watching! 7 different species of whales and Dolphin!',
        'location': 'Santa Cruz Whale Watching',
        'alert': '30 minutes before',
        'color': colors['personal'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          },
          {
            'name': 'Alex',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Falex.jpg?alt=media&token=16b79ff2-9577-4666-8f68-03a77afd7d80'
          },
          {
            'name': 'Andrew',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fandrew.jpg?alt=media&token=b2841046-d7d7-45d5-99ab-71253255fe31'
          },
          {
            'name': 'Abel',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fabel.jpg?alt=media&token=740e83bc-029e-46de-910c-3c0402ce3880'
          },
          {
            'name': 'Gretchen',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fgretchen.jpg?alt=media&token=06d1aa9b-9811-4bf7-a022-2afb4d0d2f55'
          },
        ]
      },
      {
        'title': 'M&M date night 🥂',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 18, 30)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 20, 30)),
        'description':
            'Reservation is at 6:45 and sunset is right around then. They might be able to seat us early.',
        'location': 'Top of the Mark',
        'alert': 'No alerts set',
        'color': colors['meals'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          },
        ]
      },
      {
        'title': 'Babysitter',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 18, 05)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss").format(
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 21, 00)),
        'description':
            'Lidia can watch JP from 6-9pm. She already has a new toy picked out to show him!',
        'location': 'Palo Alto',
        'alert': 'No alerts set',
        'color': colors['personal'],
        'guests': [
          {
            'name': 'JP',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fjp.jpg?alt=media&token=ce97b2fe-f4d8-4d92-8f1c-486049020c21'
          }
        ]
      },
// Next day
      {
        'title': '✈️ Flight to SF',
        'visible': true,
        'start_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(nextDay.year, nextDay.month, nextDay.day, 6, 5)),
        'end_time': DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime(nextDay.year, nextDay.month, nextDay.day, 18, 35)),
        'description':
            'Lufthansa flight 44\nDeparting San Francisco SFO airport\nTerminal B; Gate 50',
        'location': 'SFO Airport',
        'alert': '2 hours before',
        'color': colors['travel'],
        'guests': [
          {
            'name': 'Michael',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmichael.jpg?alt=media&token=81bd1338-4ff5-44c0-b4c8-097d8dee8fc6'
          },
          {
            'name': 'Maggie',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fmaggie.jpg?alt=media&token=4296059b-6f1c-44f2-895e-87656c3854a9'
          },
          {
            'name': 'JP',
            'attending': true,
            'img':
                'https://firebasestorage.googleapis.com/v0/b/turo-deals-1599612493143.appspot.com/o/demo_images%2Fjp.jpg?alt=media&token=ce97b2fe-f4d8-4d92-8f1c-486049020c21'
          }
        ]
      }
    ] // END OF EVENTS
  };
  return events;
}

List<dynamic> insertBlankRows(
  List<dynamic> rowsJSON,
  DateTime selectedDay,
  int hourInitCalendar,
) {
// Add your function code here!

  List<dynamic> completeDay = [];
  //dynamic blankEvent = {
  //'title': 'Blank',
  //'visible': false,
  //'start_time': '2022-11-04 00:00:00Z',
  // 'end_time': '2022-11-04 03:17:00Z',
  //  'details': 'Event description here'
  //};
  //completeDay.add([blankEvent]);

  for (int i = 0; i < rowsJSON.length; i++) {
    //return (hourHeight * (end.difference(start).inSeconds ~/ 60) ~/ 60);

    if (i == 0) {
      // Beginning of the day
      DateTime min = DateTime(selectedDay.year, selectedDay.month,
          selectedDay.day, hourInitCalendar, 0);
      var dayBeginString = DateFormat("yyyy-MM-dd HH:mm:ss").format(min);

      // First event start
      List<DateTime> startTimes = [
        for (var event in rowsJSON[i]) DateTime.parse(event['start_time'])
      ];
      DateTime start = startTimes.reduce((a, b) => a.isBefore(b) ? a : b);
      var firstEventStartString =
          DateFormat("yyyy-MM-dd HH:mm:ss").format(start);
      completeDay.add([
        {
          'start_time': dayBeginString,
          'end_time': firstEventStartString,
          'visible': false
        }
      ]);
      completeDay.add(rowsJSON[i]);
    } else {
      // Not the first event of the day, so there will always be a preceeding event
      List<DateTime> precedingEventEndTimes = [
        for (var event in rowsJSON[i - 1]) DateTime.parse(event['end_time'])
      ];
      DateTime precedingEventEnd =
          precedingEventEndTimes.reduce((a, b) => a.isAfter(b) ? a : b);
      var precedingEventEndString =
          DateFormat("yyyy-MM-dd HH:mm:ss").format(precedingEventEnd);

      // And end with the start of the current event
      List<DateTime> currentStartTimes = [
        for (var event in rowsJSON[i]) DateTime.parse(event['start_time'])
      ];
      DateTime currentStart =
          currentStartTimes.reduce((a, b) => a.isBefore(b) ? a : b);
      var currentEventStartString =
          DateFormat("yyyy-MM-dd HH:mm:ss").format(currentStart);
      completeDay.add([
        {
          'start_time': precedingEventEndString,
          'end_time': currentEventStartString,
          'visible': false
        }
      ]);
      // Add the current row
      completeDay.add(rowsJSON[i]);
    }
    if (i == rowsJSON.length - 1) {
      // Begin new row when the last event of the day ends
      List<DateTime> endTimes = [
        for (var event in rowsJSON[i]) DateTime.parse(event['end_time'])
      ];
      DateTime end = endTimes.reduce((a, b) => a.isAfter(b) ? a : b);
      var lastEventEndString = DateFormat("yyyy-MM-dd HH:mm:ss").format(end);

      // End at the end of the day
      DateTime max = DateTime(
          selectedDay.year, selectedDay.month, selectedDay.day, 23, 59, 59);
      var dayEndString = DateFormat("yyyy-MM-dd HH:mm:ss").format(max);

      completeDay.add([
        {
          'start_time': lastEventEndString,
          'end_time': dayEndString,
          'visible': false
        }
      ]);
    }
  }
  return completeDay;
}

dynamic getHoursCopy2(List<RangesStruct> ranges) {
// return a JSON array of strings, each string being an hour of the day
  List<Map<String, String>> hoursList = [];
  print('ranges');
  print(ranges);
  for (var range in ranges) {
    // Parsea las horas de inicio y fin
    TimeOfDay startTime = TimeOfDay(
        hour: int.parse(range.startTime.split(':')[0]),
        minute: int.parse(range.startTime.split(':')[1]));
    TimeOfDay endTime = TimeOfDay(
        hour: int.parse(range.endTime.split(':')[0]) + 1,
        minute: int.parse(range.endTime.split(':')[1]));

    // Calcula la diferencia en horas y genera las horas intermedias
    int startMinutes = startTime.hour * 60 + startTime.minute;
    int endMinutes = endTime.hour * 60 + endTime.minute;

    for (int i = startMinutes; i < endMinutes; i += 60) {
      // Incrementa de hora en hora
      // Calcula la hora actual en el ciclo
      int currentHour = (i ~/ 60) %
          24; // Asegura que la hora sea válida dentro de un rango de 0 a 23
      int currentMinute = i % 60;
      String period = currentHour >= 12 && currentHour < 24 ? 'p.m.' : 'a.m.';
      // Ajusta el formato de la hora para am/pm
      String formattedHour =
          "${currentHour > 12 ? currentHour - 12 : currentHour == 0 ? 12 : currentHour}:${currentMinute == 0 ? '00' : currentMinute}";

      hoursList.add({
        'hour': formattedHour,
        'period': period,
      });
    }
  }
  print('horas');
  print(hoursList);
  var hours = {'hours': hoursList};
  return hours;
}

int multiply(
  int x1,
  int y1,
) {
  return (x1 * y1);
}

int nowHeight(int hourHeight) {
  print('hourHeight');
  print(hourHeight);
// Add your function code here!
  DateTime now = DateTime.now();
  DateTime dayBegins = DateTime(now.year, now.month, now.day);
  print(dayBegins);
  return (hourHeight * (now.difference(dayBegins).inSeconds ~/ 60) ~/ 60);
}

int overlappingDuration(
  dynamic overlappingEvents,
  int hourHeight,
) {
// given a list of maps with start and end timestamps as strings, return the total duration of time
  List<DateTime> startTimes = [
    for (var event in overlappingEvents) DateTime.parse(event['start_time'])
  ];
  List<DateTime> endTimes = [
    for (var event in overlappingEvents) DateTime.parse(event['end_time'])
  ];
  DateTime start = startTimes.reduce((a, b) => a.isBefore(b) ? a : b);
  DateTime end = endTimes.reduce((a, b) => a.isAfter(b) ? a : b);
  return (hourHeight * (end.difference(start).inSeconds ~/ 60) ~/ 60);
}

List<dynamic> rowsFromEvents(
  dynamic eventsJSON,
  DateTime selectedDay,
) {
// Add your function code here!
  var events = eventsJSON['events'];
  // Filter to selectedDay only
  List eventsToday = events
      .where((e) =>
          DateFormat("YYYYMMDD").format(DateTime.parse(e['start_time'])) ==
          DateFormat("YYYYMMDD").format(selectedDay))
      .toList();

  List<List<Map>> result = [];
  eventsToday.sort((a, b) => a['start_time'].compareTo(b['start_time']));
  for (int i = 0; i < eventsToday.length; i++) {
    if (i == 0) {
      result.add([eventsToday[i]]);
    } else {
      if (DateTime.parse(eventsToday[i]['start_time']).isBefore(DateTime.parse(
          result[result.length - 1][result[result.length - 1].length - 1]
              ['end_time']))) {
        result[result.length - 1].add(eventsToday[i]);
      } else {
        result.add([eventsToday[i]]);
      }
    }
  }
  return result;
}

int startOffset(
  dynamic overlappingEvents,
  int hourHeight,
  dynamic event,
) {
// given a list of maps with start and end timestamps as strings, return the total duration of time
  List<DateTime> startTimes = [
    for (var event in overlappingEvents) DateTime.parse(event['start_time'])
  ];
  DateTime blockStart = startTimes.reduce((a, b) => a.isBefore(b) ? a : b);
  DateTime eventStart = DateTime.parse(event['start_time']);
  return (hourHeight *
      (eventStart.difference(blockStart).inSeconds ~/ 60) ~/
      60);
}

DateTime timestampFromString(String timestampString) {
// Add your function code here!
  return DateTime.parse(timestampString);
}

String getDay(DateTime fecha) {
  // Lista de días de la semana en español, donde 1 = lunes, 7 = domingo
  List<String> dias = [
    'LUNES',
    'MARTES',
    'MIERCOLES',
    'JUEVES',
    'VIERNES',
    'SABADO',
    'DOMINGO'
  ];

  // `weekday` devuelve un int del 1 (lunes) al 7 (domingo)
  String diaEnEspanol = dias[fecha.weekday - 1];

  return diaEnEspanol;
}

String getRandomColor() {
  var colors = {
    'work': '#BAB4F9', // purple
    'health': '#BCF0EA', // green
    'personal': '#F7CAB6', // orange
    'meals': '#FFADB3', // pink
    'travel': '#D0D7DC', // grey
  };

  // Convertimos los valores del mapa a una lista para poder indexarlos
  var colorList = colors.values.toList();

  // Usamos el tiempo actual para obtener un índice aleatorio
  var time = DateTime.now().millisecondsSinceEpoch;
  // Aseguramos que el índice esté dentro del rango de la lista
  var index = time % colorList.length;

  // Devolvemos el color correspondiente al índice aleatorio
  return colorList[index];
}
