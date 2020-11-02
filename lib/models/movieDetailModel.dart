
class Welcome {
  bool adult;
  String backdropPath;

  int budget;
  List<Genre> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;

  DateTime releaseDate;
  int revenue;
  int runtime;

  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  List<ProductionCompany> productionCompanies;
  Welcome(
      {this.adult,
      this.backdropPath,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.productionCompanies});

  factory Welcome.fromJson(Map<String, dynamic> json) {
    
    return Welcome(
      id: json['id'],
      title: json['title'],
      backdropPath: json['backdrop_path'],
      adult: json['adult'],
      budget: json["budget"],
      genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"].toDouble(),
      voteAverage: json["vote_average"].toDouble(),
      status: json["status"],
      tagline: json["tagline"],
      releaseDate: DateTime.parse(json["release_date"]),
      productionCompanies: List<ProductionCompany>.from(
          json["production_companies"]
              .map((x) => ProductionCompany.fromJson(x))),
    );
  }
}

class Genre {
  Genre({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class ProductionCompany {
  ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  int id;
  String logoPath;
  String name;
  String originCountry;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
      };
}
