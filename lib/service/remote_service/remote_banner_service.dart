// ignore_for_file: depend_on_referenced_packages

import 'package:http/http.dart' as http;
import 'package:flutter_ecommerce_app/const.dart';

class RemoteBannerService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/banners';

  Future<dynamic> get() async {
    var response = await client.get(
      Uri.parse('$remoteUrl?populate=image')
    );
    return response;
  }
}