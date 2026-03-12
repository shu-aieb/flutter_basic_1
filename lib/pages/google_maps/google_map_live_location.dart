import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapLiveLocation extends StatefulWidget {
  GoogleMapLiveLocation({super.key});

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  @override
  State<GoogleMapLiveLocation> createState() => _GoogleMapLiveLocationState();
}

class _GoogleMapLiveLocationState extends State<GoogleMapLiveLocation> {
  List<LatLng> polylineCoordinates = [];

  bool isLoadingPolyline = true; // Added for loading state
  String? polylineError;

  void getPolyPoints() async {
    setState(() {
      isLoadingPolyline = true;
      polylineError = null;
      polylineCoordinates.clear();
    });
    PolylinePoints polyPoints = PolylinePoints(
      apiKey: 'AIzaSyDO_va78vhAgJK7sSAIA3N_oYCzXkIuv4o',
    );

    try {
      PolylineResult result = await polyPoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
          origin: PointLatLng(
            GoogleMapLiveLocation.sourceLocation.latitude,
            GoogleMapLiveLocation.sourceLocation.longitude,
          ),
          destination: PointLatLng(
            GoogleMapLiveLocation.destination.latitude,
            GoogleMapLiveLocation.destination.longitude,
          ),
          mode: TravelMode.driving,
        ),
      );

      if (mounted) {
        if (result.points.isNotEmpty) {
          debugPrint(
            'Polyline API Success! Points received: ${result.points.length}',
          );
          for (var point in result.points) {
            polylineCoordinates.add(LatLng(point.latitude, point.longitude));
          }
          setState(() {
            isLoadingPolyline = false;
          });
        } else {
          String errorMsg =
              result.errorMessage ??
              'No polyline points found. Status : ${result.status}';
          debugPrint('Polyline API Failed! Error: $errorMsg');
          setState(() {
            isLoadingPolyline = false;
            polylineError = 'Failed to get route : $errorMsg';
          });
        }
      }
    } catch (e) {
      debugPrint('Polyline API Failed! Error: $e');
      if (mounted) {
        setState(() {
          isLoadingPolyline = false;
          polylineError = 'An error occurred : ${e.toString()}';
        });
      }
    }
  }

  @override
  void initState() {
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Track Location')),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: GoogleMapLiveLocation.sourceLocation,
              zoom: 13.5,
            ),
            polylines: {
              Polyline(
                polylineId: PolylineId('route'),
                points: polylineCoordinates,
                color: Colors.blue,
                width: 6,
              ),
            },
            markers: {
              Marker(
                markerId: MarkerId('source'),
                position: GoogleMapLiveLocation.sourceLocation,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure,
                ),
              ),
              Marker(
                markerId: MarkerId('destination'),
                position: GoogleMapLiveLocation.destination,
              ),
            },
          ),
          if (isLoadingPolyline)
            const Center(child: CircularProgressIndicator()),
          if (polylineError != null)
            Center(
              child: Card(
                color: Colors.red.withValues(alpha: 0.8),
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    polylineError!,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isLoadingPolyline ? null : getPolyPoints,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
