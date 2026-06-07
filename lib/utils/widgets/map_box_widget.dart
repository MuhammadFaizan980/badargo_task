import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBoxWidget extends StatefulWidget {
  final double initialLat;
  final double initialLng;
  final double? userLat;
  final double? userLng;
  final double? initialZoom;
  final bool scrollable;
  final Set<Marker> markers;
  final Function(LatLng) onMapTapped;

  const MapBoxWidget({
    super.key,
    required this.initialLat,
    required this.initialLng,
    required this.userLat,
    required this.userLng,
    this.initialZoom,
    this.scrollable = true,
    required this.markers,
    required this.onMapTapped,
  });

  @override
  State<MapBoxWidget> createState() => _MapBoxWidgetState();
}

class _MapBoxWidgetState extends State<MapBoxWidget> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  late final CameraPosition _initialCameraPosition;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(
      target: LatLng(widget.initialLat, widget.initialLng),
      zoom: widget.initialZoom ?? 15,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _initialCameraPosition,
      markers: widget.markers,
      scrollGesturesEnabled: widget.scrollable,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      zoomGesturesEnabled: false,
      zoomControlsEnabled: false,
      onTap: widget.onMapTapped,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
