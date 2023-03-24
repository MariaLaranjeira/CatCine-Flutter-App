

class Media {
  String? id;
  String? mediaName;
  int mediaDate;
  int mediaTime;
  String? coverUrl;
  String? description;

  Media(
      this.id,
      this.mediaName,
      this.mediaDate,
      this.mediaTime,
      this.coverUrl,
      this.description);

  Media.api({
    this.id,
    this.mediaName,
    this.mediaDate=0,
    this.mediaTime=0,
    this.coverUrl,
    this.description});

  factory Media.fromJson(Map<String,dynamic> json){
    int year = json['year'] ?? 0;
    return Media.api(
          id: json['id'] as String,
          mediaName: json['title'] as String,
          mediaDate: year,
          //mediaTime:
          //coverUrl:
          //description:
      );
  }

}