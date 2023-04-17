

class Media {
  String? id;
  String? mediaName;
  int mediaDate;
  int mediaTime;
  double score;
  String? coverUrl;
  String? description;

  Media(
      this.id,
      this.mediaName,
      this.mediaDate,
      this.mediaTime,
      this.score,
      this.coverUrl,
      this.description);

  Media.api({
    this.id,
    this.mediaName,
    this.mediaDate=0,
    this.mediaTime=0,
    this.score = 0.0,
    this.coverUrl,
    this.description});

  factory Media.fromJson(Map<String,dynamic> json){
    int year = json['year'] ?? 0;
    return Media.api(
          id: json['id'] as String,
          mediaName: json['title'] as String,
          mediaDate: year,
          //score: json['score_average'],
          //mediaTime:
          //coverUrl:
          //description:
      );
  }

  toJson(){
    return {
      "Id": id,
      "Name": mediaName,
      "Date": mediaDate,
      //"Duration": mediaTime,
      //"Score": score,
    };
  }

}