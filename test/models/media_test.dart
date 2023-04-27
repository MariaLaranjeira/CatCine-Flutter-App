import 'package:catcine_es/media.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Media model tests', ()
  {
    test('Media model can be instantiated', () {
      var media = Media(
          'tt343324',
          'Random Movie',
          1985,
          86,
          0,
          'coverURL',
          'description',
          'tt343324',
          0,
          0,
          true,
          13,
          'trailerUrl',
          'backdropUrl');

      expect(media.id, 'tt343324');
      expect(media.mediaName, 'Random Movie');
      expect(media.releaseDate, 1985);
      expect(media.runtime, 86);
      expect(media.score, 0);
      expect(media.movie, true);
      expect(media.id, media.imdbId);
    });

    final media = Media(
        'tt343324',
        'Random Movie',
        1985,
        86,
        0,
        'coverURL',
        'description',
        'tt343324',
        0,
        0,
        true,
        13,
        'trailerUrl',
        'backdropUrl');

    test('fromJson method works as expected', () {
      final Map<String, dynamic> jsonMap = {
        'id': 'tt343324',
        'title': 'Random Movie',
        'year': 1985,
        'score_average': 0,
        'runtime': 86,
        'poster': 'coverURL',
        'description': 'description.jpg',
        'imdbid': 'tt343324',
        'traktid': 0,
        'tmdbid': 0,
        'type': 'movie',
        'age_rating': 13,
        'trailer': 'trailerUrl',
        'backdrop': 'backdropUrl',
      };

      final result = Media.fromJson(jsonMap);

      expect(result.id, 'tt343324');
      expect(result.mediaName, 'Random Movie');
      expect(result.releaseDate, 1985);
      expect(result.runtime, 86);
      expect(result.score, 0);
      expect(result.movie, true);
      expect(result.id, result.imdbId);
    });


    test('toJson method works as expected', () {
      final result = media.toJson();

      final Map<String, dynamic> expectedJsonMap = {
        'id': 'tt343324',
        'title': 'Random Movie',
        'year': 1985,
      };

      expect(result, expectedJsonMap);
    });
  });
}
