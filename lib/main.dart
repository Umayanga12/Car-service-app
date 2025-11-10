import 'package:car_service/Notification/notification.dart';
import 'package:car_service/profile/profile.dart';
import 'package:car_service/profile/vehical.dart';
import 'package:car_service/services/service.dart';
import 'package:car_service/start/login.dart';
import 'package:car_service/start/signup.dart';
import 'package:car_service/start/start.dart';
import 'package:flutter/material.dart';

import 'appointment/Appointment.dart';
import 'home/home.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Service',
      initialRoute: "/",
      routes: {
        '/': (context) => StartUpScreen(),
        '/home' : (context) => HomeScreen(),
        '/service': (context) => ServicesScreen(),
        '/login':(context) => LoginScreen(),
        '/signup' : (context) => WelcomeScreen(),
        '/appointment': (context) => AppointmentScreen(),
        '/profile' : (context) => ProfileScreen(),
        '/notification' : (context) => NotificationScreen(),
        '/vehicaldata': (context) => VehicleDetailsScreen(),
      },
    )
  );
}
