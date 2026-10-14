import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  static final firebase = FirebaseFirestore.instance;

  static Future<void> addEvent(EventModel event) async {
    var doc = firebase.collection('Events').doc();
    event.id = doc.id;
    await doc.set(event.toJson());
  }

  static Future<List<EventModel>> getEvents(String? categoryId) async {
    List<EventModel> events = [];
    Query<Map<String, dynamic>> query = firebase.collection('Events');

    if (categoryId != null) {
      query = query.where('categoryId', isEqualTo: categoryId);
    }

    var data = await query.get();

    for (var e in data.docs) {
      events.add(EventModel.fromJson(e.data()));
    }
    return events;
  }

  static Stream<List<EventModel>> getEventsStream(String? categoryId) {
    Query<Map<String, dynamic>> query = firebase.collection('Events');

    if (categoryId != null) {
      query = query.where('categoryId', isEqualTo: categoryId);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((e) => EventModel.fromJson(e.data())).toList();
    });
  }

  static Future<List<EventModel>> getFavEvents() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    List<EventModel> events = [];
    var data = await firebase
        .collection('Events')
        .where('userFav', arrayContains: userId)
        .get();
    for (var e in data.docs) {
      var event = EventModel.fromJson(e.data());
      events.add(event);
    }
    return events;
  }

  static Future<void> toggleFav(EventModel event) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    if (event.usersFav.contains(userId)) {
      event.usersFav.remove(userId);
    } else {
      event.usersFav.add(userId);
    }
    await firebase.collection('Events').doc(event.id).update(event.toJson());
  }

  static Future<void> deleteEvent(String eventId) async {
    await firebase.collection('Events').doc(eventId).delete();
  }

  static Future<void> updateEvent(EventModel event) async {
    await firebase.collection('Events').doc(event.id).update({
      'title': event.title,
      'desc': event.desc,
      'categoryId': event.categoryId,
      'date': event.date,
      'time': event.time,
    });
  }
}
