import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import '../providers/local_providers/local_provider.dart';

var appName = "app-name".i18n();

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

var providers = [
  ChangeNotifierProvider(
    create: (_) => LocaleProvider(),
  ),
];