class Comics {
  int code;
  String status;
  String copyright;
  String attributionText;
  String attributionHtml;
  String etag;
  Data data;

  Comics({
    required this.code,
    required this.status,
    required this.copyright,
    required this.attributionText,
    required this.attributionHtml,
    required this.etag,
    required this.data,
  });
}

class Data {
  int offset;
  int limit;
  int total;
  int count;
  List<Result> results;

  Data({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.results,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        offset: json["offset"],
        limit: json["limit"],
        total: json["total"],
        count: json["count"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "limit": limit,
        "total": total,
        "count": count,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  int id;
  int digitalId;
  String title;
  dynamic issueNumber;
  String variantDescription;
  dynamic description;
  String modified;
  String isbn;
  String upc;
  String diamondCode;
  String ean;
  String issn;
  String format;
  int pageCount;
  List<dynamic> textObjects;
  String resourceUri;
  List<Url> urls;
  Series series;
  List<Series> variants;
  List<dynamic> collections;
  List<dynamic> collectedIssues;
  List<Date> dates;
  List<Price> prices;
  Thumbnail thumbnail;
  List<Thumbnail> images;
  Characters creators;
  Characters characters;
  Characters stories;
  Characters events;

  Result({
    required this.id,
    required this.digitalId,
    required this.title,
    required this.issueNumber,
    required this.variantDescription,
    this.description,
    required this.modified,
    required this.isbn,
    required this.upc,
    required this.diamondCode,
    required this.ean,
    required this.issn,
    required this.format,
    required this.pageCount,
    required this.textObjects,
    required this.resourceUri,
    required this.urls,
    required this.series,
    required this.variants,
    required this.collections,
    required this.collectedIssues,
    required this.dates,
    required this.prices,
    required this.thumbnail,
    required this.images,
    required this.creators,
    required this.characters,
    required this.stories,
    required this.events,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        digitalId: json["digitalId"],
        title: json["title"],
        issueNumber: json["issueNumber"],
        variantDescription: json["variantDescription"],
        description: json["description"],
        modified: json["modified"],
        isbn: json["isbn"],
        upc: json["upc"],
        diamondCode: json["diamondCode"],
        ean: json["ean"],
        issn: json["issn"],
        format: json["format"],
        pageCount: json["pageCount"],
        textObjects: List<dynamic>.from(json["textObjects"].map((x) => x)),
        resourceUri: json["resourceURI"],
        urls: List<Url>.from(json["urls"].map((x) => Url.fromJson(x))),
        series: Series.fromJson(json["series"]),
        variants:
            List<Series>.from(json["variants"].map((x) => Series.fromJson(x))),
        collections: List<dynamic>.from(json["collections"].map((x) => x)),
        collectedIssues:
            List<dynamic>.from(json["collectedIssues"].map((x) => x)),
        dates: List<Date>.from(json["dates"].map((x) => Date.fromJson(x))),
        prices: List<Price>.from(json["prices"].map((x) => Price.fromJson(x))),
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        images: List<Thumbnail>.from(
            json["images"].map((x) => Thumbnail.fromJson(x))),
        creators: Characters.fromJson(json["creators"]),
        characters: Characters.fromJson(json["characters"]),
        stories: Characters.fromJson(json["stories"]),
        events: Characters.fromJson(json["events"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "digitalId": digitalId,
        "title": title,
        "issueNumber": issueNumber,
        "variantDescription": variantDescription,
        "description": description,
        "modified": modified,
        "isbn": isbn,
        "upc": upc,
        "diamondCode": diamondCode,
        "ean": ean,
        "issn": issn,
        "format": format,
        "pageCount": pageCount,
        "textObjects": List<dynamic>.from(textObjects.map((x) => x)),
        "resourceURI": resourceUri,
        "urls": List<dynamic>.from(urls.map((x) => x.toJson())),
        "series": series.toJson(),
        "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
        "collections": List<dynamic>.from(collections.map((x) => x)),
        "collectedIssues": List<dynamic>.from(collectedIssues.map((x) => x)),
        "dates": List<dynamic>.from(dates.map((x) => x.toJson())),
        "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
        "thumbnail": thumbnail.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "creators": creators.toJson(),
        "characters": characters.toJson(),
        "stories": stories.toJson(),
        "events": events.toJson(),
      };
}

class Characters {
  int available;
  String collectionUri;
  List<Item> items;
  int returned;

  Characters({
    required this.available,
    required this.collectionUri,
    required this.items,
    required this.returned,
  });

  factory Characters.fromJson(Map<String, dynamic> json) => Characters(
        available: json["available"],
        collectionUri: json["collectionURI"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        returned: json["returned"],
      );

  Map<String, dynamic> toJson() => {
        "available": available,
        "collectionURI": collectionUri,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "returned": returned,
      };
}

class Item {
  String resourceUri;
  String name;
  String? role;
  String? type;

  Item({
    required this.resourceUri,
    required this.name,
    this.role,
    this.type,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        resourceUri: json["resourceURI"],
        name: json["name"],
        role: json["role"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
        "role": role,
        "type": type,
      };
}

class Date {
  String type;
  String date;

  Date({
    required this.type,
    required this.date,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        type: json["type"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "date": date,
      };
}

class Thumbnail {
  String path;
  String extension;

  Thumbnail({
    required this.path,
    required this.extension,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        path: json["path"],
        extension: json["extension"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
        "extension": extension,
      };
}

class Price {
  String type;
  double price;

  Price({
    required this.type,
    required this.price,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        type: json["type"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "price": price,
      };
}

class Series {
  String resourceUri;
  String name;

  Series({
    required this.resourceUri,
    required this.name,
  });

  factory Series.fromJson(Map<String, dynamic> json) => Series(
        resourceUri: json["resourceURI"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "resourceURI": resourceUri,
        "name": name,
      };
}

class Url {
  String type;
  String url;

  Url({
    required this.type,
    required this.url,
  });

  factory Url.fromJson(Map<String, dynamic> json) => Url(
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "url": url,
      };
}
