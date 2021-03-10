import 'dart:convert';

import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:polls_for_devs/data/http/http_client.dart';
import 'package:polls_for_devs/data/http/http_error.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<Map> request({
    @required String url,
    @required String method,
    Map body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };

    final jsonBody = body != null ? jsonEncode(body) : null;

    var response = Response('', 500);

    if (method == 'post') {
      response = await client.post(
        Uri.tryParse(url),
        headers: headers,
        body: jsonBody,
      );
    }

    return _handleResponse(response);
  }

  Map _handleResponse(Response response) {
    final statusCodeHandler = {
      200: () {
        return response.body.isEmpty ? null : jsonDecode(response.body) as Map;
      },
      204: () {
        return null;
      },
      400: () {
        throw HttpError.badRequest;
      },
      401: () {
        throw HttpError.unauthorized;
      },
      403: () {
        throw HttpError.forbidden;
      },
      404: () {
        throw HttpError.notFound;
      },
      500: () {
        throw HttpError.serverError;
      },
    };

    return statusCodeHandler[response.statusCode]();
  }
}
