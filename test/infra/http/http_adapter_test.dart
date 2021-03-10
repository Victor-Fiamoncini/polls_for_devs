import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:polls_for_devs/data/http/http_client.dart';
import 'package:test/test.dart';

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

    final response = await client.post(
      Uri.tryParse(url),
      headers: headers,
      body: jsonBody,
    );

    return jsonDecode(response.body) as Map;
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  HttpAdapter sut;
  ClientSpy client;
  String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });

  group('POST', () {
    test('Should call POST with correct values', () async {
      when(
        client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => Response('{"any_key":"any_value"}', 200),
      );

      await sut.request(
        url: url,
        method: 'post',
        body: {'any_key': 'any_value'},
      );

      verify(client.post(
        Uri.tryParse(url),
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
        body: '{"any_key":"any_value"}',
      ));
    });

    test('Should call POST without body', () async {
      when(
        client.post(
          any,
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => Response('{"any_key":"any_value"}', 200),
      );

      await sut.request(url: url, method: 'post');

      verify(client.post(
        any,
        headers: anyNamed('headers'),
      ));
    });

    test('Should return data if POST return 200', () async {
      when(
        client.post(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => Response('{"any_key":"any_value"}', 200),
      );

      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });
  });
}
