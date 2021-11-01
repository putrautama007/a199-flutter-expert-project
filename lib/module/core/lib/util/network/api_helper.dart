import 'dart:io';

import 'package:core/core.dart';
import 'package:libraries/libraries.dart';

abstract class ApiHelper {
  Future<dynamic> get({required String url});
}

class ApiHelperImpl extends ApiHelper {
  @override
  Future get({required String url}) async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    return await ioClient.get(Uri.parse(url));
  }
}
