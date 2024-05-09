import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class BusStops extends StatefulWidget {
  final String route;

  BusStops({required this.route});

  @override
  _BusStopsState createState() => _BusStopsState();
}

class _BusStopsState extends State<BusStops> {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Stops - ${widget.route}'),
      ),
      body: FutureBuilder<DataSnapshot>(
        future: _ref.once().then((DatabaseEvent event) {
          return event.snapshot;
        }),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final dataList = snapshot.data!.value as List<dynamic>?;
          if (dataList == null || dataList.isEmpty) {
            return Center(child: Text('No data available'));
          }
          final List<String> stops = [];
          dataList.forEach((value) {
            if (value is Map && value.containsKey('Route')) {
              stops.add(value['Route']);
            }
          });
          return ListView.builder(
            itemCount: stops.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(stops[index]),
              );
            },
          );
        },
      ),
    );
  }
}
