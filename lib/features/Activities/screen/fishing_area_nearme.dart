import 'dart:convert';
import 'dart:math';
import 'package:fishmaster/features/Activities/fish_name_string/tamilfish.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class FishingAreaNearby extends StatefulWidget {
  final String selectedGear;
  final String selectedFishes;

  FishingAreaNearby({required this.selectedGear, required this.selectedFishes});

  @override
  _FishingAreaNearbyState createState() => _FishingAreaNearbyState();
}

class _FishingAreaNearbyState extends State<FishingAreaNearby> {
  GoogleMapController? _mapController;
  final Set<Circle> _circles = {};
  final Set<Marker> _markers = {}; // Markers set for fish occurrences
  final Random _random = Random();
  bool _isLoading = true;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(13.1039, 80.2901),
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _loadFishingEffortData();
    // Start fetching occurrences after converting local names to scientific names.
    fetchAllOccurrences();
  }

  // Convert the selectedFishes string (local names) into a list of scientific names
  List<String> getScientificNames(String selectedFishes) {
    // Split by comma and trim spaces
    List<String> localNames =
        selectedFishes.split(',').map((s) => s.trim()).toList();
    List<String> scientificNames = [];

    for (String local in localNames) {
      // Filter fishList for the matching fish (ignoring case)
      final matches = fishList
          .where((fish) => fish.localName.toLowerCase() == local.toLowerCase());
      if (matches.isNotEmpty) {
        scientificNames.add(matches.first.scientificName);
      }
    }
    return scientificNames;
  }

  // Fetch occurrence data for one species from GBIF API and add markers
  // Helper function to get local name from scientific name
  String getLocalName(String scientificName) {
    final matches = fishList.where(
      (fish) =>
          fish.scientificName.toLowerCase() == scientificName.toLowerCase(),
    );
    if (matches.isNotEmpty) {
      return matches.first.localName;
    }
    return scientificName; // Fallback if no match found
  }

  Future<void> fetchOccurrencesForSpecies(String species) async {
    final url =
        'https://api.gbif.org/v1/occurrence/search?scientificName=$species&limit=100000000';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        int counter = 0;
        for (var record in results) {
          if (record.containsKey('decimalLatitude') &&
              record.containsKey('decimalLongitude')) {
            double lat = (record['decimalLatitude'] as num).toDouble();
            double lon = (record['decimalLongitude'] as num).toDouble();
            Marker marker = Marker(
              markerId: MarkerId('$species-$counter'),
              position: LatLng(lat, lon),
              infoWindow: InfoWindow(title: getLocalName(species)),
            );
            setState(() {
              _markers.add(marker);
            });
            counter++;
          }
        }
      } else {
        debugPrint(
            'Error fetching occurrences for $species: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Exception fetching occurrences for $species: $e');
    }
  }

  // Loop through all scientific names and fetch their occurrence data
  Future<void> fetchAllOccurrences() async {
    List<String> scientificNames = getScientificNames(widget.selectedFishes);
    for (String species in scientificNames) {
      await fetchOccurrencesForSpecies(species);
    }
  }

  Future<void> _loadFishingEffortData() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/response4.json');
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      final List<dynamic> entries = jsonData['entries'];
      final List<dynamic> fishingData =
          entries[0]['public-global-fishing-effort:v3.0'];

      Set<Circle> circles = {};

      for (var item in fishingData) {
        double lat = (item['lat'] as num).toDouble();
        double lon = (item['lon'] as num).toDouble();
        double hours = (item['hours'] as num).toDouble();

        // Slight random offset for visual variety
        lat += _random.nextDouble() * 0.002 - 0.001;
        lon += _random.nextDouble() * 0.002 - 0.001;

        Color baseColor;
        if (hours < 6) {
          baseColor = Colors.red;
        } else if (hours >= 6 && hours <= 20) {
          baseColor = Colors.yellow;
        } else {
          baseColor = Colors.green;
        }

        // Create multiple circles per fishing effort record for a heatmap effect
        for (int i = 0; i < 3; i++) {
          double factor = (i + 1) * 1.5;
          double opacity = (0.3 - (i * 0.1)).clamp(0.1, 0.3);

          circles.add(
            Circle(
              circleId: CircleId('$lat,$lon-$i'),
              center: LatLng(lat, lon),
              radius: (500 + (hours * 40)) * factor,
              fillColor: baseColor.withOpacity(opacity),
              strokeColor: Colors.transparent,
            ),
          );
        }
      }

      setState(() {
        _circles.addAll(circles);
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading fishing effort data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // The rest of your code for recommendations, UI, etc. remains unchanged.
  Map<String, dynamic> getFishingRecommendation(String gear) {
    // ... (existing code remains here)
    switch (gear) {
      case "Hook & Line":
        return {
          "High Effort Area": "Not recommended",
          "Medium Effort Area": "6 hours",
          "Low Effort Area": "12 hours",
          "icon": FontAwesomeIcons.fish,
          "color": Colors.green,
        };
      case "Gillnets":
        return {
          "High Effort Area": "3 hours",
          "Medium Effort Area": "7 hours",
          "Low Effort Area": "10 hours",
          "icon": FontAwesomeIcons.fish,
          "color": Colors.yellow,
        };
      case "Longlines":
        return {
          "High Effort Area": "4 hours",
          "Medium Effort Area": "8 hours",
          "Low Effort Area": "10 hours",
          "icon": FontAwesomeIcons.fish,
          "color": Colors.orange,
        };
      case "Purse Seining":
        return {
          "High Effort Area": "5 hours",
          "Medium Effort Area": "7 hours",
          "Low Effort Area": "8 hours",
          "icon": FontAwesomeIcons.fish,
          "color": Colors.deepOrange,
        };
      case "Trawling":
        return {
          "High Effort Area": "2 hours",
          "Medium Effort Area": "5 hours",
          "Low Effort Area": "7 hours",
          "icon": FontAwesomeIcons.fish,
          "color": Colors.red,
        };
      default:
        return {
          "High Effort Area": "",
          "Medium Effort Area": "",
          "Low Effort Area": "",
          "icon": FontAwesomeIcons.fish,
          "color": Colors.blueGrey,
          "message": "Select a Gear to see fishing time recommendations."
        };
    }
  }

  Widget buildRecommendationMessage(Map<String, dynamic> recommendation) {
    if (recommendation.containsKey("message")) {
      return Text(
        recommendation["message"],
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      );
    }

    return RichText(
      text: TextSpan(
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87),
        children: [
          TextSpan(
            text: "High Effort Zone 🟢: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: recommendation["High Effort Area"] + "\n\n"),
          TextSpan(
            text: "Medium Effort Zone 🟡: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: recommendation["Medium Effort Area"] + "\n\n"),
          TextSpan(
            text: "Low Effort Zone 🔴: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: recommendation["Low Effort Area"]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recommendation = getFishingRecommendation(widget.selectedGear);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logos/fisher.png',
          height: 50,
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: _initialPosition,
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  circles: _circles,
                  markers: _markers, // Display the fish occurrence markers here
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                ),
                if (_isLoading) Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                    children: [
                      TextSpan(
                        text: "Fishing Gear: ",
                        style:
                            TextStyle(color: Color.fromRGBO(51, 108, 138, 1)),
                      ),
                      TextSpan(
                        text: widget.selectedGear,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "Allowed Fishing hours as per zones ",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87),
                ),
                SizedBox(height: 5),
                ListTile(
                  leading: FaIcon(
                    recommendation["icon"],
                    color: recommendation["color"],
                    size: 40,
                  ),
                  title: buildRecommendationMessage(recommendation),
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your "Start Fishing" action here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(51, 108, 138, 1),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Start Fishing",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          LocationPermission permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied ||
              permission == LocationPermission.deniedForever) {
            permission = await Geolocator.requestPermission();
          }
          if (permission == LocationPermission.whileInUse ||
              permission == LocationPermission.always) {
            Position position = await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high);
            _mapController?.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(position.latitude, position.longitude),
              ),
            );
          }
        },
        backgroundColor: Color.fromRGBO(51, 108, 138, 1),
        child: Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }
}
