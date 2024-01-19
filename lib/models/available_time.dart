class AvailableTime {
  String date;
  List<Time> times;

  AvailableTime({required this.date, required this.times});

  factory AvailableTime.fromJson(Map<String, dynamic> json) {
    var results = json['times'] as List;
    List<Time> times = results.map((e) => Time.fromJson(e)).toList();

    return AvailableTime(date: json['date'], times: times);
  }
}

class Time {
  int? id;
  String start;
  String end;

  Time({required this.end, required this.start, this.id});

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(id: json['id'], end: json['end'], start: json['start']);
  }
}
