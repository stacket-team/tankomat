import 'package:flutter/material.dart';

const PRIMARY_COLOR = Color(0xFFFF7643);
const PRIMARY_LIGHT_COLOR = Color(0xFFFFECDF);
const PRIMARY_GRADIENT = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const SECONDARY_COLOR = Color(0xFF979797);
const TEXT_COLOR = Color(0xFF757575);

const API_KEY = "AIzaSyBbwYoP_4GbmZ8bloCmOX1xiQr40nmIeU0";
const AUTH_DOMAIN = "stacket-tankomat.firebaseapp.com";
const DATABASE_URL = "https://stacket-tankomat.firebaseio.com";
const PROJECT_ID = "stacket-tankomat";
const STORAGE_BUCKET = "stacket-tankomat.appspot.com";
const MESSAGING_SENDER_ID = "269865634170";
const APP_ID = "1:269865634170:web:b32b56dc9eee0b43892ec3";
const MEASUREMENT_ID = "G-HP10DX6CHP";

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final String emailNullError = "Wprowadź swój email";
final String invalidEmailError = "Adres e-mail jest nie poprawny";
final String passwordNullError = "Wprowadź swoje hasło";
final String shortPasswordError = "Hasło jest za krótkie";
final String matchPasswordError = "Hasła się nie zgadzają";
final String nameNullError = "Wprowadź swoje imię";
