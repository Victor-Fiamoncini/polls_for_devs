import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:polls_for_devs/data/http/http_client.dart';
import 'package:polls_for_devs/infra/http/http_adapter.dart';

HttpClient makeHttpAdapter() {
  final client = Client();

  return HttpAdapter(client);
}
