import '/features/comics_app/domain/entities/comics.dart';

class ComicsModel extends Comics {
  ComicsModel(
      {required int code,
      required String status,
      required String copyright,
      required String attributionText,
      required String attributionHtml,
      required String etag,
      required Data data})
      : super(
            code: code,
            status: status,
            copyright: copyright,
            attributionText: attributionText,
            attributionHtml: attributionHtml,
            etag: etag,
            data: data);

  factory ComicsModel.fromJson(Map<String, dynamic> json) => ComicsModel(
        code: json["code"],
        status: json["status"],
        copyright: json["copyright"],
        attributionText: json["attributionText"],
        attributionHtml: json["attributionHTML"],
        etag: json["etag"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "copyright": copyright,
        "attributionText": attributionText,
        "attributionHTML": attributionHtml,
        "etag": etag,
        "data": data.toJson(),
      };
}
