import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'screenUI.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
    // Firebase database reference
  final start = TextEditingController();
  final end = TextEditingController();

  
  bool isVisible = false;
  List<LatLng> routpoints = [const LatLng(52.05884, -1.345583)];
  String selectedMode = 'driving-car';
  Map<String, String> modeNames = {
    'driving-car': 'Car',
    'cycling-regular': 'Bike',
    'foot-walking': 'Walking'
  };
  Map<String, int> travelTimes = {
    'driving-car': 0,
    'cycling-regular': 0,
    'foot-walking': 0
  };
  int? distance;
  LatLng? startMarker;
  LatLng? endMarker;

  // Icons for each mode
  Map<String, IconData> modeIcons = {
    'driving-car': Icons.directions_car,
    'cycling-regular': Icons.directions_bike,
    'foot-walking': Icons.directions_walk,
  };

  Future<void> _setCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Location permissions are permanently denied.')),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    if (position.latitude != 0 && position.longitude != 0) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          setState(() {
            start.text = "${place.name}, ${place.locality}, ${place.country}";
          });
        }
      } catch (e) {
        print('Error retrieving placemarks: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to get placemark')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get current location')),
      );
    }
  }

  Future<void> _getRoute() async {
    try {
      List<Location> startLocation = await locationFromAddress(start.text);
      List<Location> endLocation = await locationFromAddress(end.text);

      if (startLocation.isNotEmpty && endLocation.isNotEmpty) {
        var startLat = startLocation[0].latitude;
        var startLng = startLocation[0].longitude;
        var endLat = endLocation[0].latitude;
        var endLng = endLocation[0].longitude;

        print('Start coordinates: $startLat, $startLng');
        print('End coordinates: $endLat, $endLng');

        var url = Uri.parse(
            'https://api.openrouteservice.org/v2/directions/$selectedMode'
            '?api_key=5b3ce3597851110001cf624824ee2084bbf44bb2b4e345cf2d72f072'
            '&start=$startLng,$startLat'
            '&end=$endLng,$endLat');

        var response = await http.get(url);

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          var coordinates = data['features'][0]['geometry']['coordinates'];
          var duration = data['features'][0]['properties']['segments'][0]['duration'];
          var dist = data['features'][0]['properties']['segments'][0]['distance'];
          setState(() {
            routpoints = coordinates
                .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
                .toList();
            travelTimes[selectedMode] = (duration / 60).round(); // convert seconds to minutes and round
            distance = (dist / 1000).round(); // convert meters to kilometers and round
            isVisible = true;
            startMarker = LatLng(startLat, startLng);
            endMarker = LatLng(endLat, endLng);
          });
        } else {
          print('Failed to load route: ${response.reasonPhrase}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Failed to load route: ${response.reasonPhrase}')),
          );
        }
      }
    } catch (e) {
      print('Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get location: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Iternary Plan',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color.fromARGB(255, 75, 2, 6)),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Get screen width
            double screenWidth = constraints.maxWidth;
            
            // Define layout properties based on screen size
            bool isLargeScreen = screenWidth > 800;
            double iconSize = isLargeScreen ? 40 : 20;
            double padding = isLargeScreen ? 16 : 8;
            double fontSize = isLargeScreen ? 16 : 10;

            return Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: [
                  Column(
  children: [
    Container(
      color: Color(0xFFFC486E), // Change color to FC486E
      padding: const EdgeInsets.all(8.0), // Add some padding if needed
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 280, // Set your desired width here
                child: Container(
                  height: 30, // Set your desired height here
                  child: TextField(
                    controller: start,
                    style: TextStyle(color: Colors.white), // Set font color to white
                    decoration: InputDecoration(
                      hintText: 'Enter location',
                      hintStyle: TextStyle(color: Colors.white), // Set hint color to white
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0), // Curved edges
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Adjust content padding
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.my_location),
                onPressed: _setCurrentLocation,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: 280, // Set your desired width here
                child: Container(
                  height: 30, // Set your desired height here
                  child: TextField(
                    controller: end,
                    style: TextStyle(color: Colors.white), // Set font color to white
                    decoration: InputDecoration(
                      hintText: 'Enter destination',
                      hintStyle: TextStyle(color: Colors.white), // Set hint color to white
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0), // Curved edges
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Adjust content padding
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ],
),
                  /*
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(234, 255, 255, 255),
                        ),
                        onPressed: _getRoute,
                        child: const Text('Directions'),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: modeNames.keys.map((mode) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedMode = mode;
                            });
                            _getRoute();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedMode == mode
                                ? Colors.blueAccent
                                : Colors.blueAccent,
                          ),
                          child: Row(
                            children: [
                              Icon(modeIcons[mode], color: Colors.white, size: iconSize),
                              const SizedBox(width: 5),
                              Text(
                                modeNames[mode]!,
                                style: TextStyle(color: Colors.white, fontSize: fontSize),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
              Expanded(
                child: Visibility(
                  visible: isVisible,
                  child: FlutterMap(
                    options: MapOptions(
                      center: routpoints[0],
                      zoom: 13,
                    ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        PolylineLayer(
                          polylineCulling: false,
                          polylines: [
                            Polyline(
                                points: routpoints,
                                color: Colors.blue,
                                strokeWidth: 9)
                          ],
                        ),
                        if (startMarker != null && endMarker != null)
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 80.0,
                                height: 80.0,
                                point: endMarker!,
                               child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.location_on),
                          color: Colors.red,
                          iconSize: 45,
                                ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isVisible,
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Text('Estimated time ${modeNames[selectedMode]}: ${travelTimes[selectedMode]!.toStringAsFixed(2)} minutes'),
                      Text('Distance: ${distance?.toStringAsFixed(2)} km'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
          },
      ),
    ),
    );
  }
}


