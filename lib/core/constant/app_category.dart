import 'package:flutter/material.dart';

class AppCategory {
  String id;
  String name;
  String image;
  IconData iconData;
  AppCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.iconData,
  });
  static List<AppCategory> categories = [
    AppCategory(
      id: 'sport',
      name: 'Sport',
      image: 'assets/category/Sport.png',
      iconData: Icons.sports,
    ),
    AppCategory(
      id: 'birthday',
      name: 'Birthday',
      image: 'assets/category/Birthday.png',
      iconData: Icons.baby_changing_station,
    ),
    AppCategory(
      id: 'book_club',
      name: 'Book Club',
      image: 'assets/category/Book Club.png',
      iconData: Icons.book,
    ),
    AppCategory(
      id: 'exhibition',
      name: 'Exhibition',
      image: 'assets/category/Exhibition.png',
      iconData: Icons.meeting_room,
    ),
    AppCategory(
      id: 'meeting',
      name: 'Meeting',
      image: 'assets/category/Meeting.png',
      iconData: Icons.edit_outlined,
    ),
  ];
}
