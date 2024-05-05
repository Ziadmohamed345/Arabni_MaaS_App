import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart' as mapbox;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Mapbox Example',
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final String accessToken =
      'pk.eyJ1IjoidG9rYWVsYWRseSIsImEiOiJjbHZ0em83czgwaWI1Mmltamd5OTg0YjRqIn0.1uYtYa-_SxHmyR8KthDLbA'; // Replace with your access token

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: Center(
        child: mapbox.MapboxMap(
          accessToken: accessToken,
          onMapCreated: _onMapCreated,
          initialCameraPosition: mapbox.CameraPosition(
            target: mapbox.LatLng(
                37.7749, -122.4194), // Example initial location (San Francisco)
            zoom: 11.0,
          ),
        ),
      ),
    );
  }

  void _onMapCreated(mapbox.MapboxMapController controller) {
    // Add map controller initialization here if needed
  }
}
