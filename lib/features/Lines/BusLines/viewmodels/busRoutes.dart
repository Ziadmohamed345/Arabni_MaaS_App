import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:maasapp/features/Lines/BusLines/viewmodels/busStops.dart';

class BusRoutes extends StatefulWidget {
  @override
  _BusRoutesState createState() => _BusRoutesState();
}

class _BusRoutesState extends State<BusRoutes> {
  final DatabaseReference _ref = FirebaseDatabase.instance.ref();
  List<Map<dynamic, dynamic>> _allRoutes = [];
  List<Map<dynamic, dynamic>> _filteredRoutes = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchRoutes();
    _searchController.addListener(_filterRoutes);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterRoutes);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchRoutes() async {
    final snapshot = await _ref.once();
    final data = snapshot.snapshot.value as List<dynamic>;
    setState(() {
      _allRoutes = data.cast<Map<dynamic, dynamic>>();
      _filteredRoutes = _allRoutes;
    });
  }

  void _filterRoutes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRoutes = _allRoutes
          .where((routeData) =>
              routeData['Route'].toString().toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Routes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Routes',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _buildRoutesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutesList() {
    if (_allRoutes.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    if (_filteredRoutes.isEmpty) {
      return Center(child: Text('No routes found'));
    }

    return ListView.builder(
      itemCount: _filteredRoutes.length,
      itemBuilder: (context, index) {
        final routeData = _filteredRoutes[index];
        final route = routeData['Route'];
        final stops = routeData['Stops'] as List<dynamic>;
        return ListTile(
          title: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RouteStops(
                    route: route,
                    stops: List<String>.from(stops),
                  ),
                ),
              );
            },
            child: Text(route),
          ),
        );
      },
    );
  }
}
