import 'package:http/http.dart';

final String pasteBinURL = "https://pastebin.com/raw/eDzY0LSq";

Future<String> getIP() async {
  final response = await get(pasteBinURL);
  return response.body;
}
