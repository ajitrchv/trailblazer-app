import 'package:http/http.dart' as http;
import 'dart:convert';
const MAPBOX_API_KEY = 'pk.eyJ1IjoiYWppdHJjaHYiLCJhIjoiY2t2N3VveGY5MXB2MzJ0bzA1eTVrZ3c2byJ9.7gg20W4bg0_wzZdFfWUmbg';
const MAPBOX_API_KEY_II = 'pk.eyJ1IjoiYWppdHJjaHYiLCJhIjoiY2t2N3V2Y2dmMGZ3bjJwbWdhYTU3b2J2byJ9.LzpoqpQL5p0ghDUBfldgJQ';
const MAPQUEST_API ='VzGsbBTzA1mnjOdx7qNHBLzEF3AXkYjU';

class LocationHelper {
  static String generateLocationPreviewImage({required double? latitude,required double? longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$MAPBOX_API_KEY_II';
  }

  static Future<String> getPlaceAddress(double? lat, double? lng)  async{
    final urll = Uri.parse('https://us1.locationiq.com/v1/reverse.php?key=pk.c7c1c0f6b7358053b11d7e55a0be1538&lat=$lat&lon=$lng&format=json');
    final response =  await http.get(urll);
    print(json.decode(response.body));
    return json.decode(response.body)['display_name'];
    
  }
}