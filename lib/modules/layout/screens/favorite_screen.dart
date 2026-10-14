import 'package:flutter/material.dart';

import '../../../core/models/event_model.dart';
import '../../../core/services/database_service.dart';
import '../widgets/home_widgets/card_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FutureBuilder(
              future: DatabaseService.getFavEvents(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  List<EventModel> events = snapshot.data ?? [];
                  return Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return CardWidget(
                          event: events[index],
                          onTapFav: () async {
                            await DatabaseService.toggleFav(events[index]);
                            setState(() {});
                          },
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 8),
                      itemCount: events.length,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
