import 'package:http/http.dart' as http;
import 'package:photoapp/model/fetch_photo_model.dart';

class PhotoService {
  static const String _baseUrl = 'https://picsum.photos/v2/list';

  Future<List<Fetchphotomodel>> fetchPhotos() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      return fetchphotomodelFromJson(response.body);
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
