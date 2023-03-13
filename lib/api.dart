import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> main() async { // Make the main function asynchronous
  final client = http.Client();
  final query = "The Good Place"; // Replace with your desired query string

  final request = http.Request('GET',
      Uri.parse('https://mdblist.p.rapidapi.com/?s=$query'))
    ..headers.addAll({
      'X-RapidAPI-Key': 'd681c42be1msha8325a6eba62bd0p10fe15jsn10d36805b704',
      'X-RapidAPI-Host': 'mdblist.p.rapidapi.com'
    });

  final streamedResponse = await client.send(request);
  final response = await http.Response.fromStream(streamedResponse);

  print(response.body);
}

