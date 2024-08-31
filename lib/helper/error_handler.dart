import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:localization/localization.dart';
import '../data_services/app_exception.dart';
import '../utils/snakBarHelper.dart';

Future<dynamic> errorHandler(Future multiMethod,
    {bool isShowError = true, bool needReturn = false}) async {
  try {
    var data = await multiMethod;
    if (data["status"] != null) {
      bool status = data["status"];
      if (status) {
        return data;
      } else {
        isShowError ? customErrorMessageGetter(data, true) : null;
        return needReturn ? data : null;
      }
    }

    return data;
  } on BadRequestException catch (e) {
    if (kDebugMode) {
      print('BadRequestException');
    }
    isShowError ? customErrorMessageGetter(e.messages, true) : null;

    // GlobalFunctions.showToast("$e", false);
    if (kDebugMode) {
      print(e.messages.runtimeType);
    }
    return needReturn ? needErrorReturn(e.messages) : null;
  } on UnauthorisedException catch (e) {
    if (kDebugMode) {
      print('UnauthorisedException');
    }
    isShowError ? customErrorMessageGetter(e.messages, true) : null;
    // GlobalFunctions.showToast("$e", false);
    return needReturn ? needErrorReturn(e) : null;
  } on SocketException catch (e) {
    if (kDebugMode) {
      print('SocketException');
    }
    isShowError ? customErrorMessageGetter(e.message, true) : null;
    // GlobalFunctions.showToast(e.message, false);
    return needReturn ? needErrorReturn(e.message) : null;
  } on TokenExpiredException catch (e) {
    if (kDebugMode) {
      print("DataToken  ExpiredException token is :$e");
    }
  } on InternalServerDataException catch (e) {
    if (kDebugMode) {
      print('Internal server error $e');
    }
    isShowError ? customErrorMessageGetter(e.messages, true) : null;
    return needReturn ? needErrorReturn(e.messages) : null;
  } catch (e) {
    if (kDebugMode) {
      print('unknown $e');
    }
    isShowError
        ? SnackBarHelper().showToast("apiError".i18n(), false,)
        : null;
  }
  return null;
}

dynamic modelErrorHandler(dynamic method) {
  try {
    return method();
  } catch (e) {
    if (kDebugMode) {
      rethrow;
    }
    SnackBarHelper().showToast("modelError".i18n(["$e"]), false,);
    if (kDebugMode) {
      rethrow;
    }
  }
}

showErrorToast(dynamic message, bool hasShowToast) {
  hasShowToast ? SnackBarHelper().showToast("$message", false,) : null;
}

needErrorReturn(dynamic errorMessage) {
  return errorMessage;
}

customErrorMessageGetter(dynamic errorRes, bool isError) {
  var showToast = "Unknown Error";
  if (kDebugMode) {
    print("error res......$errorRes");
  }

  try {
    if (errorRes.runtimeType == String) {
      showToast = errorRes;
    } else if (errorRes != null && errorRes["message"] != null) {
      showToast = errorRes["message"];
    } else if (errorRes != null && errorRes["errors"] != null) {
      if (errorRes["errors"]["message"] != null) {
        showToast = errorRes["errors"]["message"];
      } else {
        showToast = errorRes["errors"];
      }
    } else {
      if (errorRes != null) {
        errorRes.forEach(
              (key, value) {
            if (value.runtimeType == List) {
              if ((value as List).isNotEmpty) {
                showToast = value[0];
              }
            }
            if (value.runtimeType == String) {
              showToast = value;
            }

            if (value.runtimeType.toString() == '_Map<String, dynamic>') {
              value.forEach((key, value) {
                if (value.runtimeType == List) {
                  showToast = value[0];
                }
                if (value.runtimeType == String) {
                  showToast = value;
                }
              });
            }
          },
        );
      }
    }
  } catch (e) {
    if (kDebugMode) {
      SnackBarHelper().showToast("$e", !isError,);
      rethrow;
    }
  }

  SnackBarHelper().showToast(showToast, !isError,);
}
