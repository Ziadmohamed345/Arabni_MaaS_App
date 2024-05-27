import 'package:flutter/material.dart';
import 'package:maasapp/features/Lines/BusLines/viewmodels/busRoutes.dart';

class LinesScreen extends StatefulWidget {
  @override
  _LinesScreenState createState() => _LinesScreenState();
}

class _LinesScreenState extends State<LinesScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _allLines = ['Cairo Lines'];
  List<String> _filteredLines = [];

  @override
  void initState() {
    super.initState();
    _filteredLines = _allLines;
    _searchController.addListener(_filterLines);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterLines);
    _searchController.dispose();
    super.dispose();
  }

  void _filterLines() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredLines = _allLines
          .where((line) => line.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lines'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Lines',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _buildLinesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLinesList() {
    if (_filteredLines.isEmpty) {
      return Center(child: Text('No lines found'));
    }

    return ListView.builder(
      itemCount: _filteredLines.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusRoutes(),
                ),
              );
            },
            child: Text(_filteredLines[index]),
          ),
        );
      },
    );
  }
}
