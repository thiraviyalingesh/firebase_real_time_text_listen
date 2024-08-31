import 'package:flutter/material.dart';

import '../../utils/app_assets.dart';

class CustomErrorWidget extends StatelessWidget {
  final Function() reload;
  final String errorTitle;
  final bool showReloadButton;

  const CustomErrorWidget(
      {super.key,
      required this.reload,
      required this.errorTitle,
      this.showReloadButton = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.appLogoPath),
        Text(errorTitle),
        showReloadButton
            ? IconButton(onPressed: reload, icon: const Icon(Icons.refresh))
            : const SizedBox()
      ],
    );
  }
}

class IndividualError extends StatelessWidget {
  final String errorTitle;
  final Function() reload;
  final double? height;
  final double? width;

  const IndividualError(
      {super.key,
      required this.errorTitle,
      required this.reload,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: reload,
      child: Card(
        // height:height?? MediaQuery.of(context).size.height*0.20,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width * 0.10,
                  AppAssets.appLogoPath,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(errorTitle),
              ],
            ),
            IconButton(onPressed: reload, icon: const Icon(Icons.refresh))
          ],
        ),
      ),
    );
  }
}
