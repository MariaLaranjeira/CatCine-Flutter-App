import 'package:catcine_es/Model/media.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';



void main() {

  final instance = FakeFirebaseFirestore();

  test("Insert and read movie data from database" , () async {
    Media? media;
    String id = "idTest";
    String title = "titleTest";
    int year = 0;

    await instance.collection('media').doc('test').set ({
      'id' : id,
      'title': title,
      'year': year
    });

    final snapshot = await instance.collection('media').doc('test').get();

    var x = snapshot.data() as Map<String, dynamic>;

    media = Media.api(id: x['id'],mediaName: x['title'], releaseDate: x['year']);

    expect(media.id, equals(id));
    expect(media.mediaName, equals(title));
    expect(media.releaseDate, equals(year));

  });

}
