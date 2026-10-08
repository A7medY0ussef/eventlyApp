import 'package:firebase_auth/firebase_auth.dart';

class EventModel {
  String id;
  late String? userId;
  String categoryId;
  String title;
  String desc;
  String time;
  String date;
  List<String> usersFav;
  EventModel({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.date,
    required this.desc,
    required this.time,
    this.userId,
    this.usersFav = const[]
  });
  Map<String, dynamic> toJson() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return {
      "id": id,
      "categoryId": categoryId,
      "title": title,
      "desc": desc,
      "time": time,
      "date": date,
      'userId': userId,
      "userFav": usersFav
    };
  }
  factory EventModel.fromJson(Map<String, dynamic> json) {
    List fav = json['userFav'] ?? [];
    return EventModel(
      id: json['id'],
      title: json['title'],
      categoryId: json['categoryId'],
      date: json['date'],
      desc: json['desc'],
      time: json['time'],
      userId: json['userId'],
      usersFav: fav.map<String>((e) {
        return e.toString();
      }).toList()
    );
  }
}

