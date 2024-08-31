import 'package:flutter/cupertino.dart';
import 'package:localization/localization.dart';

import 'error_widget.dart';


class GlobalWidgetBuilder extends StatelessWidget {
  final bool isError;
  final bool isNoDataFound;
  final bool isLoading;
  final Widget child;
  final Widget loadingChild;
  final Function() reload;

  const GlobalWidgetBuilder(
      {Key? key,
      required this.isError,
      required this.isNoDataFound,
      required this.isLoading,
      required this.child,
      required this.loadingChild,
      required this.reload})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return IndividualError(
        errorTitle: 'something_went_wrong_please_try_again'.i18n(),
        reload: reload,
      );
    } else if (isNoDataFound) {
      return const SizedBox();
    } else if (isLoading) {
      return loadingChild;
    } else {
      return child;
    }
  }
}
