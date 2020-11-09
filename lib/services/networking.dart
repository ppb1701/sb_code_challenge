import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {

NetworkHelper(this.url);

final String url;

//Attempt to take the helper's url and get the JSON data response.
Future getData() async {
  http.Response response = await http.get(
      url);
  String data;
  if (response.statusCode == 200) {
    data = response.body;
    return jsonDecode(data);
  } else {
    print(response.statusCode);
  }
}

}