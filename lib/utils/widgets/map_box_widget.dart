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

class _MapBoxWidgetState extends State<MapBoxWidget> {
  GoogleMapController? _mapController;
  late final CameraPosition _initialCameraPosition;
  StreamSubscription? _locationUpdateSubscription;
  StreamSubscription? _serviceStoppedSubscription;

  Marker? _carmarker;

  @override
  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(
      target: LatLng(widget.initialLat, widget.initialLng),
      zoom: widget.initialZoom ?? 15,
    );

    _locationUpdateSubscription = FlutterBackgroundService().on(AppConstants.onLocationUpdate).listen((
      data,
    ) async {
      if (data != null && data['lat'] != null && data['lng'] != null) {
        double lat = data['lat'];
        double lng = data['lng'];
        double heading = (data['heading'] ?? 0) + .0;
        double accuracy = (data['accuracy'] ?? 0) + .0;

        if (widget.onLocationUpdated != null) {
          widget.onLocationUpdated!(lat: lat, lng: lng, accuracy: accuracy, heading: heading);
        }

        _carmarker = await getCarMarker(lat: lat, lng: lng, heading: heading);
        _animateCameraToPosition(target: LatLng(lat, lng), zoom: 17);
        setState(() {});
      }
    });
    _serviceStoppedSubscription = FlutterBackgroundService().on(AppConstants.onLocationServiceStopped).listen((
      data,
    ) {
      widget.onLocationServiceStopped?.call();
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
    _mapController?.dispose();
    super.dispose();
  }
}
