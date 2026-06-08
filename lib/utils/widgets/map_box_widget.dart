import 'dart:async';

import 'package:badargo_task/data/constants/app_constants.dart';
import 'package:badargo_task/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBoxWidget extends StatefulWidget {
  final double initialLat;
  final double initialLng;
  final double? userLat;
  final double? userLng;
  final double? initialZoom;
  final bool scrollable;
  final Function(LatLng)? onMapTapped;
  final Function()? onLocationServiceStopped;
  final Function({required double lat, required double lng, required double accuracy, required double heading})?
  onLocationUpdated;

  const MapBoxWidget({
    super.key,
    required this.initialLat,
    required this.initialLng,
    required this.userLat,
    required this.userLng,
    this.initialZoom,
    this.scrollable = true,
    this.onMapTapped,
    this.onLocationServiceStopped,
    this.onLocationUpdated,
  });

  @override
  State<MapBoxWidget> createState() => _MapBoxWidgetState();
}

class _MapBoxWidgetState extends State<MapBoxWidget> with TickerProviderStateMixin {
  GoogleMapController? _mapController;
  late final CameraPosition _initialCameraPosition;
  StreamSubscription? _locationUpdateSubscription;
  StreamSubscription? _serviceStoppedSubscription;

  Marker? _carmarker;

  AnimationController? _animationController;
  LatLng _startLocation = const LatLng(0, 0);
  LatLng _endLocation = const LatLng(0, 0);
  double _startBearing = 0.0;
  double _endBearing = 0.0;
  bool _isFirstLocation = true;
  BitmapDescriptor? _cachedCarIcon;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(
      target: LatLng(widget.initialLat, widget.initialLng),
      zoom: widget.initialZoom ?? 15,
    );

    // 3. Initialize the 2.5-second animation driver timeline
    _animationController = AnimationController(duration: const Duration(milliseconds: 5000), vsync: this);
    _animationController!.addListener(_onAnimationTick);

    _locationUpdateSubscription = FlutterBackgroundService().on(AppConstants.onLocationUpdate).listen((
      data,
    ) async {
      if (data != null && data['lat'] != null && data['lng'] != null) {
        double lat = (data['lat'] as num).toDouble();
        double lng = (data['lng'] as num).toDouble();
        double heading = (data['heading'] ?? 0.0).toDouble();
        double accuracy = (data['accuracy'] ?? 0.0).toDouble();

        if (widget.onLocationUpdated != null) {
          widget.onLocationUpdated!(lat: lat, lng: lng, accuracy: accuracy, heading: heading);
        }

        if (_cachedCarIcon == null) {
          final tempMarker = await getCarMarker(lat: lat, lng: lng, heading: heading);
          _cachedCarIcon = tempMarker.icon;
        }

        _processNewCoordinates(lat, lng, heading);
      }
    });

    _serviceStoppedSubscription = FlutterBackgroundService().on(AppConstants.onLocationServiceStopped).listen((
      data,
    ) {
      widget.onLocationServiceStopped?.call();
    });
  }

  void _processNewCoordinates(double lat, double lng, double bearing) {
    final LatLng nextLatLng = LatLng(lat, lng);

    // If it's the very first coordinate package packet, snap instantly without any slide transitions
    if (_isFirstLocation) {
      _startLocation = nextLatLng;
      _endLocation = nextLatLng;
      _startBearing = bearing;
      _endBearing = bearing;
      _isFirstLocation = false;
      _updateMarkerUI(nextLatLng, bearing);
      _animateCameraToPosition(target: nextLatLng, zoom: 17);
      return;
    }

    _animationController!.stop();

    _startLocation = _endLocation;
    _startBearing = _endBearing;

    _endLocation = nextLatLng;
    _endBearing = bearing;

    _animationController!.forward(from: 0.0);
    _animateCameraToPosition(target: nextLatLng, zoom: 17);
  }

  void _onAnimationTick() {
    if (_animationController == null) return;
    final double fraction = _animationController!.value;

    double currentLat = (_endLocation.latitude - _startLocation.latitude) * fraction + _startLocation.latitude;
    double currentLng = (_endLocation.longitude - _startLocation.longitude) * fraction + _startLocation.longitude;
    final LatLng interpolatedPosition = LatLng(currentLat, currentLng);

    double difference = _endBearing - _startBearing;
    while (difference < -180) {
      difference += 360;
    }
    while (difference > 180) {
      difference -= 360;
    }
    final double interpolatedRotation = _startBearing + difference * fraction;

    _updateMarkerUI(interpolatedPosition, interpolatedRotation);
  }

  void _updateMarkerUI(LatLng position, double rotation) {
    if (!mounted) return;
    setState(() {
      _carmarker = Marker(
        markerId: const MarkerId('smooth_uber_car'),
        position: position,
        icon: _cachedCarIcon ?? BitmapDescriptor.defaultMarker,
        rotation: rotation,
        anchor: const Offset(0.5, 0.5),
        flat: true,
      );
    });
  }

  void _animateCameraToPosition({required LatLng target, double? zoom}) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: target, zoom: zoom ?? 15)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _initialCameraPosition,
      markers: _carmarker != null ? {_carmarker!} : {},
      scrollGesturesEnabled: widget.scrollable,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      onTap: widget.onMapTapped,
      onMapCreated: (GoogleMapController controller) async {
        _mapController = controller;
      },
    );
  }

  @override
  void dispose() {
    _locationUpdateSubscription?.cancel();
    _serviceStoppedSubscription?.cancel();
    _animationController?.removeListener(_onAnimationTick);
    _animationController?.dispose();
    _mapController?.dispose();
    super.dispose();
  }
}
