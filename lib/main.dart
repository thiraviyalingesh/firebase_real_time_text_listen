import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import 'package:mvvmbasic/providers/local_providers/app_provider.dart';
import 'package:mvvmbasic/providers/local_providers/local_provider.dart';
import 'package:mvvmbasic/services/firebase_helper.dart';
import 'package:mvvmbasic/utils/global_variables.dart';
import 'package:mvvmbasic/utils/routes.dart';
import 'package:mvvmbasic/utils/theme/app.colors.dart';
import 'package:mvvmbasic/utils/theme/app.typography.dart';
import 'package:provider/provider.dart';
import 'data_services/api_helper.dart';
import 'firebase_options.dart';

//wrap all class with LocaleProvider inorder use localizations
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.appHeaderBlue,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.appWhite,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  Get.lazyPut(
    () => ApiHelper(),
  );
  Get.lazyPut(
    () => FirebaseHelper(),
  );

  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_outlined,
                color: Colors.red,
                size: 100,
              ),
              Text(
                kReleaseMode
                    ? 'Oops... something went wrong'
                    : errorDetails.exception.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  };

  runApp(
    const AppProviders(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    context.read<LocaleProvider>().context = context;

    super.initState();
    callSetFun();
  }

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['lib/utils/i18n/'];
    return Consumer<LocaleProvider>(
      builder: (context, provider, snapshot) {
        Get.lazyPut<LocaleProvider>(() => provider);
        return MyMaterialApp(context, provider, snapshot);
      },
    );
  }

  void callSetFun() async {
    context.read<LocaleProvider>().init(context);
  }
}

class MyMaterialApp extends StatelessWidget {
  final LocaleProvider provider;
  final BuildContext context;
  final Widget? snapshot;

  const MyMaterialApp(this.context, this.provider, this.snapshot, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        textTheme: TextTheme(
                titleMedium: AppTypography.appBarTitle
                    .copyWith(color: AppColors.appWhite))
            .apply(fontFamily: "Horas"),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.appPrimary,
          primary: AppColors.appPrimary,
          secondary: AppColors.appPrimary,
        ),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: AppColors.appPrimary),
        ),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splashScreen.name,
      routes: routes,
    );
  }
}
