import 'dart:isolate';

import 'package:flutter/services.dart';

Future<dynamic> computeIsolate(
  Future Function(IsolateData isolateData) function, {
  dynamic extraData,
  ReceivePort? receivePortM,
}) async {
  final receivePort = ReceivePort();
  var rootToken = RootIsolateToken.instance!;
  await Isolate.spawn<IsolateData>(
    _isolateEntry,
    IsolateData(
      token: rootToken,
      function: function,
      answerPort: receivePort.sendPort,
      extraData: extraData,
    ),
  );
  var result = await receivePort.first;
  receivePort.close();

  return result;
}

void _isolateEntry(IsolateData isolateData) async {
  BackgroundIsolateBinaryMessenger.ensureInitialized(isolateData.token);

  try {
    await isolateData.function(isolateData);
    isolateData.answerPort.send("true");
  } catch (e) {
    isolateData.answerPort.send(e.toString());
  } finally {}
}

class IsolateData {
  final RootIsolateToken token;
  final Function function;
  final SendPort answerPort;
  final dynamic extraData;

  IsolateData({
    required this.token,
    required this.function,
    required this.answerPort,
    required this.extraData,
  });
}

easyIsolate(Function callBack) async {
  var message = await computeIsolate(
    (IsolateData isolateData) async {
      callBack(isolateData);
    },
  );
}
