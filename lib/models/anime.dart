class Anime {
    Anime({
       this.malId,
       this.rank,
       this.title,
       this.url,
       required this.imageUrl,
       this.type,
       this.episodes,
       this.startDate,
       this.endDate,
      this.members,
       this.score,
    });

    int? malId;
    int? rank;
    String? title;
    String? url;
    String imageUrl;
    String? type;
    int? episodes;
    String? startDate;
    String? endDate;
    int? members;
    double? score;

    factory Anime.fromMap(Map<String, dynamic> json) => Anime(
        malId: json["mal_id"],
        rank: json["rank"],
        title: json["title"],
        url: json["url"],
        imageUrl: json["image_url"],
        type: json["type"],
        episodes: json["episodes"] == null ? null : json["episodes"],
        startDate: json["start_date"],
        endDate: json["end_date"] == null ? null : json["end_date"],
        members: json["members"],
        score: json["score"].toDouble(),
    );

    Map<String, dynamic> toMap() => {
        "mal_id": malId,
        "rank": rank,
        "title": title,
        "url": url,
        "image_url": imageUrl,
        "type": type,
        "episodes": episodes == null ? null : episodes,
        "start_date": startDate,
        "end_date": endDate == null ? null : endDate,
        "members": members,
        "score": score,
    };
}

