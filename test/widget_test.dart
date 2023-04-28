// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:catcine_es/media.dart';
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
