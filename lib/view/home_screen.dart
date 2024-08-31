import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvmbasic/custom_widgets/custom_button.dart';
import 'package:mvvmbasic/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../providers/local_providers/app_local_provider.dart';
import '../utils/theme/app.colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var avg = (height + width) / 2;

    return AppLocalProviders(
      child: (context, localProvider, snapshot) {
        return ChangeNotifierProvider(
          create: (_) => HomeProvider(),
          builder: (context, provider) => Consumer<HomeProvider>(
            builder: (context, provider, child) {
              return Container(
                color: AppColors.appHeaderBlue,
                child: SafeArea(
                  child: Scaffold(
                    backgroundColor: AppColors.appWhite,
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            provider.textResponseModel?.text??"Loading...",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
