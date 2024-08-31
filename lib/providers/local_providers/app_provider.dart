import 'package:flutter/material.dart';
import 'package:mvvmbasic/utils/global_variables.dart';
import 'package:provider/provider.dart';

import 'local_provider.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => LocaleProvider(),
      ),
    ], builder: (context, provider) => child);
  }
}
