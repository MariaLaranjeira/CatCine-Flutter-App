

class Media {
  String? imdbId;
  String? mediaName;
  int mediaDate;
  int mediaTime; // para séries como é que isto fica?
  String? coverUrl;
  String? description;

  Media(
      this.imdbId,
      this.mediaName,
      this.mediaDate,
      this.mediaTime,
      this.coverUrl,
      this.description);

  Media.api({
    this.imdbId,
    this.mediaName,
    this.mediaDate=0,
    this.mediaTime=0,
    this.coverUrl,
    this.description});

  factory Media.fromJson(Map<String,dynamic> json){
      return Media.api(
          imdbId: json['id'] as String,
          mediaName: json['title'] as String,
          mediaDate: json['year'] as int,
          //mediaTime:
          //coverUrl:
          //description:
      );
  }

}