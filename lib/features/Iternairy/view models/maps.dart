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
        backgroundColor: const Color.fromARGB(255, 203, 199, 199),
      ),
      backgroundColor: const Color.fromARGB(255, 203, 199, 199),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: myInput(
                        controler: start, hint: 'Enter location'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.my_location),
                    onPressed: _setCurrentLocation,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              myInput(controler: end, hint: 'Enter destination'),
              const SizedBox(
                height: 15,
              ),
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var mode in modeNames.keys)
                    DropdownButton<String>(
                      value: selectedMode,
                      items: modeNames.keys.map((String mode) {
                        return DropdownMenuItem<String>(
                          value: mode,
                          child: Row(
                            children: [
                              Icon(modeIcons[mode]),
                              SizedBox(width: 5),
                              Text(modeNames[mode]!),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedMode = newValue!;
                        });
                        _getRoute();
                      },
                    ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Visibility(
                  visible: isVisible,
                  child: FlutterMap(
                    options: MapOptions(
                      center: routpoints[0],
                      zoom: 10,
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
                  color: Colors.white,
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
        ),
      ),
    );
  }
}