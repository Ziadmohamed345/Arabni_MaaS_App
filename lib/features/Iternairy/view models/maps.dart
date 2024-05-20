// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'screenUI.dart';


class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Raw coordinates got from  OpenRouteService
  List listOfPoints = [];

  // Conversion of listOfPoints into LatLng(Latitude, Longitude) list of points
  List<LatLng> points = [];

  // Method to consume the OpenRouteService API
  getCoordinates() async {
    // Requesting for openrouteservice api
    var response = await http.get(getRouteUrl("1.243344,6.145332",
        '1.2160116523406839,6.125231015668568') as Uri);
    setState(() {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        listOfPoints = data['features'][0]['geometry']['coordinates'];
        points = listOfPoints
            .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: const MapOptions(
          zoom: 12,
          center: LatLng(6.131015, 1.223898)
        ),
        children: [
          // Layer that adds the map
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          // Layer that adds points the map
          MarkerLayer(
            markers: [
              // First Marker
              Marker(
  point: const LatLng(6.145332, 1.243344),
  width: 80,
  height: 80,
  child: IconButton(
    onPressed: () {},
    icon: const Icon(Icons.location_on),
    color: Colors.green,
    iconSize: 45,
  ),
),
              // Second Marker
              Marker(
  point: const LatLng(6.125231015668568, 1.2160116523406839),
  width: 80,
  height: 80,
  child: IconButton(
    onPressed: () {},
    icon: const Icon(Icons.location_on),
    color: Colors.red,
    iconSize: 45,
  ),
),
            ],
          ),

         if (points.isNotEmpty)
            PolylineLayer(
              polylineCulling: false,
              polylines: [
                Polyline(points: points, color: Colors.black, strokeWidth: 5),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () => getCoordinates(),
        child: const Icon( Icons.route,
          color: Colors.white,
        ),
      ),
    );
  }
}


