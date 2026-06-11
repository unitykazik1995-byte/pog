import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'settings_ui.dart';
import 'map_ui.dart';

class TacticalScreen extends ConsumerWidget {
  const TacticalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.black87,
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Text('OKO SAURONA', style: TextStyle(color: Colors.greenAccent, fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.greenAccent),
              title: const Text('Ustawienia', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.map, color: Colors.greenAccent),
              title: const Text('Mapa Taktyczna', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const MapScreen()));
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // 1. Live Video Feed Background
          Container(
            color: Colors.black87,
            child: const Center(
              child: Text("LIVE VIDEO FEED INITIALIZING...",
                  style: TextStyle(color: Colors.greenAccent, fontFamily: 'Courier', letterSpacing: 2.0)),
            ),
          ),
          
          // 2. Tracking Overlay (Bounding boxes, segmentations)
          const TrackingOverlay(),

          // 3. Tactical HUD Elements
          Positioned(
            top: 40,
            left: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.greenAccent, size: 30),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                const SizedBox(width: 10),
                _buildSystemStatus(),
              ],
            ),
          ),
          
          Positioned(
            top: 40,
            right: 20,
            child: _buildTelemetryOverlay(),
          ),

          Positioned(
            bottom: 20,
            left: 20,
            child: _buildTargetList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSystemStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("OKO SAURONA v1.0", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
        Text("AI ENGINE: ACTIVE", style: TextStyle(color: Colors.greenAccent)),
        Text("MODELS: YOLO26 + ByteTrack", style: TextStyle(color: Colors.cyanAccent)),
        Text("BACKEND: NPU (Hexagon)", style: TextStyle(color: Colors.yellowAccent)),
      ],
    );
  }

  Widget _buildTelemetryOverlay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: const [
        Text("FPS: 60", style: TextStyle(color: Colors.white)),
        Text("LATENCY: 12ms", style: TextStyle(color: Colors.white)),
        Text("POWER: PERFORMANCE", style: TextStyle(color: Colors.redAccent)),
      ],
    );
  }

  Widget _buildTargetList() {
    return Container(
      width: 250,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.greenAccent.withOpacity(0.5)),
        color: Colors.black54,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.greenAccent.withOpacity(0.3),
            padding: const EdgeInsets.all(4.0),
            child: const Text("ACTIVE TARGETS", style: TextStyle(color: Colors.greenAccent)),
          ),
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  dense: true,
                  title: Text("TRK-001: UNKNOWN OBJECT", style: TextStyle(color: Colors.yellowAccent)),
                  subtitle: Text("SPD: 12km/h HDG: 045°"),
                ),
                ListTile(
                  dense: true,
                  title: Text("TRK-002: DRONE", style: TextStyle(color: Colors.redAccent)),
                  subtitle: Text("SPD: 45km/h HDG: 180°"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TrackingOverlay extends StatelessWidget {
  const TrackingOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CustomPainter to draw bounding boxes and masks from state
    return CustomPaint(
      painter: BoundingBoxPainter(),
      child: Container(),
    );
  }
}

class BoundingBoxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Example mock target
    final rect = Rect.fromLTWH(100, 150, 80, 120);
    canvas.drawRect(rect, paint);
    
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'TRK-002: DRONE (98%)',
        style: TextStyle(color: Colors.redAccent, backgroundColor: Colors.black87),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, const Offset(100, 130));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
