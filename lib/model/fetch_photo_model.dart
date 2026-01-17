// To parse this JSON data, do
//
//     final fetchphotomodel = fetchphotomodelFromJson(jsonString);

import 'dart:convert';

List<Fetchphotomodel> fetchphotomodelFromJson(String str) => List<Fetchphotomodel>.from(json.decode(str).map((x) => Fetchphotomodel.fromJson(x)));

String fetchphotomodelToJson(List<Fetchphotomodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Fetchphotomodel {
    String? id;
    String? author;
    int? width;
    int? height;
    String? url;
    String? downloadUrl;

    Fetchphotomodel({
        this.id,
        this.author,
        this.width,
        this.height,
        this.url,
        this.downloadUrl,
    });

    factory Fetchphotomodel.fromJson(Map<String, dynamic> json) => Fetchphotomodel(
        id: json["id"],
        author: json["author"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        downloadUrl: json["download_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "width": width,
        "height": height,
        "url": url,
        "download_url": downloadUrl,
    };
}
