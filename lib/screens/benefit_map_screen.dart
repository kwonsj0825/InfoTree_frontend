import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import '../models/benefit.dart';
import '../models/category.dart';
import 'benefit_detail_screen.dart';

class BenefitMapScreen extends StatefulWidget {
  final List<Benefit> benefits;

  const BenefitMapScreen({super.key, required this.benefits});

  @override
  State<BenefitMapScreen> createState() => _BenefitMapScreenState();
}

class _BenefitMapScreenState extends State<BenefitMapScreen> {
  final MapController _mapController = MapController();

  Benefit? _selectedBenefit;
  final Map<String, ui.Image> _categoryTextIcons = {};
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _generateCategoryIcons();
    _determinePosition();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _determinePosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return;
    }

    final position = await Geolocator.getCurrentPosition();
    final latLng = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentPosition = latLng;
    });

    // 현재 위치로 지도 이동
    _mapController.move(latLng, 15);
  }

  Future<void> _generateCategoryIcons() async {
    for (var category in categories) {
      if (!_categoryTextIcons.containsKey(category.id)) {
        final icon = await _createTextMarker(category.label);
        _categoryTextIcons[category.id] = icon;
      }
    }
    setState(() {});
  }

  Future<ui.Image> _createTextMarker(String text) async {
    const double width = 160;
    const double height = 80;

    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    final Paint paint = Paint()..color = Colors.white;
    final Rect rect = Rect.fromLTWH(0, 0, width, height);
    final RRect rrect = RRect.fromRectAndRadius(rect, const Radius.circular(40));
    canvas.drawRRect(rrect, paint);

    final Paint border = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(rrect, border);

    final TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );

    painter.layout(maxWidth: width);
    painter.paint(
      canvas,
      Offset((width - painter.width) / 2, (height - painter.height) / 2),
    );

    return await recorder.endRecording().toImage(width.toInt(), height.toInt());
  }

  Widget _buildCustomMarker(ui.Image img) {
    final bytesFuture = img.toByteData(format: ui.ImageByteFormat.png);
    return FutureBuilder<ByteData?>(
      future: bytesFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox();
        return Image.memory(Uint8List.view(snapshot.data!.buffer), width: 60, height: 60);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final validBenefits = widget.benefits.where((b) => b.latitude != null && b.longitude != null).toList();

    if (_categoryTextIcons.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final allMarkers = <Marker>[
      // 혜택 마커
      ...validBenefits.map((b) {
        final categoryId = b.categories.isNotEmpty ? b.categories.first : 'etc';
        final iconData = categories.firstWhere(
              (c) => c.id == categoryId,
          orElse: () => categories.last,
        ).icon;

        return Marker(
          point: LatLng(b.latitude!, b.longitude!),
          width: 45,
          height: 45,
          child: GestureDetector(
            onTap: () {
              setState(() => _selectedBenefit = b);
            },
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: const Color(0xFFB3926B), width: 1),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 1)],
              ),
              child: Center(
                child: Icon(
                  iconData,
                  color: const Color(0xFF62462B),
                  size: 20,
                ),
              ),
            ),
          ),
        );
      }),

      // 현재 위치 마커
      if (_currentPosition != null)
        Marker(
          point: _currentPosition!,
          width: 50,
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.8),
              border: Border.all(color: Color(0xFF62462B), width: 3),
            ),
            child: const Center(
              child: Icon(Icons.my_location, color: Color(0xFF62462B), size: 28),
            ),
          ),
        ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '혜택 위치 보기',
          style: TextStyle(color: Color(0xFF62462B), fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _currentPosition ??
                  (validBenefits.isNotEmpty
                      ? LatLng(validBenefits[0].latitude!, validBenefits[0].longitude!)
                      : LatLng(37.5665, 126.9780)),
              zoom: 13,
              onTap: (_, __) => setState(() => _selectedBenefit = null),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(markers: allMarkers),
            ],
          ),
          if (_selectedBenefit != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BenefitDetailScreen(benefit: _selectedBenefit!),
                    ),
                  );
                },
                child: Container(
                  height: 100.0,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F1E9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFB3926B)),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
                  ),
                  child: Row(
                    children: [
                      if (_selectedBenefit!.image != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            _selectedBenefit!.image!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedBenefit!.title,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF62462B)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _selectedBenefit!.description,
                              style: const TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Color(0xFF62462B)),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
