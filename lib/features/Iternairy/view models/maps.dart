import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // ignore: unused_field
  late MapboxMapController _controller;
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print('Error getting current location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              child: MapboxMap(
                accessToken:
                    'pk.eyJ1IjoidG9rYWVsYWRseSIsImEiOiJjbHZ0em83czgwaWI1Mmltamd5OTg0YjRqIn0.1uYtYa-_SxHmyR8KthDLbA',
                onMapCreated: (controller) {
                  setState(() {
                    _controller = controller;
                  });
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    _currentPosition.latitude,
                    _currentPosition.longitude,
                  ),
                  zoom: 10.0,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Current Location: ${_currentPosition.latitude}, ${_currentPosition.longitude}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Destination: Your Destination',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality to navigate to transportation options screen
              },
              child: Text('Select Transportation'),
            ),
          ],
        ),
      ),
    );
  }
}
