import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

class FirebaseHelper {

  ///<---------------Firebase checkIn variables--------------------->

  DatabaseReference? userDatabase;
  StreamSubscription<DatabaseEvent>? fbListener;
  var isFirstChecked = false;

  JsonCodec codec = const JsonCodec();
}
