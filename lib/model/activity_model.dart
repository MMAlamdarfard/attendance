class Activity {
  List<ActivityResults>? results;

  Activity({this.results});

  Activity.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <ActivityResults>[];
      json['results'].forEach((v) {
        results!.add(ActivityResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActivityResults {
  String? color;
  String? className;
  int? totalAbbsent;
  int? totalClass;
  String? cause;
  bool? isPresent;

 ActivityResults(
      {this.color,
      this.className,
      this.totalAbbsent,
      this.totalClass,
      this.cause,
      this.isPresent});

  ActivityResults.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    className = json['className'];
    totalAbbsent = json['totalAbbsent'];
    totalClass = json['totalClass'];
    cause = json['cause'];
    isPresent = json['is_present'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    data['className'] = className;
    data['totalAbbsent'] = totalAbbsent;
    data['totalClass'] = totalClass;
    data['cause'] = cause;
    data['is_present'] = isPresent;
    return data;
  }
}