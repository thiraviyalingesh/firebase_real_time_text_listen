import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class MyHttpClient {
  http.Client? _myClient;

  http.Client? get myClient => _myClient;

  // MyHttpClient() {
  // globalContext;
  // getSSLPinningClient();
  // }

  Future<SecurityContext> get globalContext async {
    SecurityContext securityContext = SecurityContext(
      withTrustedRoots: true,
    );
    // List<String> certPaths = [
    //   'assets/cert/cts_staging.pem',
    //   'assets/cert/cts_live.pem',
    // ];
    //
    // certPaths.forEach((e) async {
    //   final sslCert = await rootBundle.load(e);
    //   securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    // });

    return securityContext;
  }

  Future<http.Client> getSSLPinningClient() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = CustomIOClient(client);
    _myClient = ioClient;

    return ioClient;
  }
}

class CustomIOClient extends IOClient {
  CustomIOClient(HttpClient super.httpClient);

  @override
  Future<IOStreamedResponse> send(http.BaseRequest request) async {
    request.headers['User-Agent'] = "";

    return super.send(request);
  }
}
