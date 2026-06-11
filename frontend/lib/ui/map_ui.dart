import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OKO SAURONA - MAPA TAKTYCZNA', style: TextStyle(color: Colors.greenAccent, fontFamily: 'Courier')),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.greenAccent),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: const LatLng(52.2297, 21.0122), // Domyślnie Warszawa
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            // Działa offline jeśli pobrano kafelki, w przeciwnym razie OSM
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.okosaurona.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: const LatLng(52.2297, 21.0122),
                width: 80,
                height: 80,
                child: const Icon(Icons.location_searching, color: Colors.redAccent, size: 40),
              ),
              Marker(
                point: const LatLng(52.2350, 21.0150),
                width: 80,
                height: 80,
                child: const Icon(Icons.airplanemode_active, color: Colors.yellowAccent, size: 40),
              ),
            ],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: const [
                  LatLng(52.2297, 21.0122),
                  LatLng(52.2320, 21.0140),
                  LatLng(52.2350, 21.0150),
                ],
                strokeWidth: 4.0,
                color: Colors.redAccent.withOpacity(0.7),
              )
            ],
          )
        ],
      ),
    );
  }
}
