

import '../api.dart';
import 'media.dart';

class SearchesBackEnd {
  static Future<List<Media>> updateList(String title) async{
    if (title.isEmpty) {
      return [];
    }

    List<Media> mediaList = await Media.searchTitle(title);
    await API.storeMedia();
    API.updateRemoteList(mediaList);

    return mediaList;
  }
}