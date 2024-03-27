class News {
  List<ResultNews>? resultNews;

  News({this.resultNews});

  News.fromJson(Map<String, dynamic> json) {
    if (json['result_news'] != null) {
      resultNews = <ResultNews>[];
      json['result_news'].forEach((v) {
        resultNews!.add(ResultNews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (resultNews != null) {
      data['result_news'] = resultNews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultNews {
  String? title;
  String? subtitle;
  String? image;

  ResultNews({this.title, this.subtitle, this.image});

  ResultNews.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['image'] = image;
    return data;
  }
}