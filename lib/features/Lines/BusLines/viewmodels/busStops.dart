import 'package:flutter/material.dart';

class RouteStops extends StatefulWidget {
  final String route;
  final List<String> stops;

  const RouteStops({
    required this.route,
    required this.stops,
  });

  @override
  _RouteStopsState createState() => _RouteStopsState();
}

class _RouteStopsState extends State<RouteStops> {
  late List<String> _filteredStops;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredStops = widget.stops;
    _searchController.addListener(_filterStops);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterStops);
    _searchController.dispose();
    super.dispose();
  }

  void _filterStops() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredStops = widget.stops
          .where((stop) => stop.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stops for Route: ${widget.route}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Stops',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _buildStopsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStopsList() {
    if (_filteredStops.isEmpty) {
      return Center(child: Text('No stops found'));
    }

    return ListView.builder(
      itemCount: _filteredStops.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_filteredStops[index]),
        );
      },
    );
  }
}
