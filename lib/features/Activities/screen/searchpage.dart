import 'package:flutter/material.dart';
import 'mappage.dart';
import 'package:fishmaster/features/Activities/fish_name_string/TamilFish.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<TamilFish> filteredFishList = fishList; // Initialize with full list

  void _filterFish(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredFishList = fishList;
      } else {
        filteredFishList = fishList
            .where((fish) =>
                fish.localName.toLowerCase().contains(query.toLowerCase()) ||
                fish.scientificName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _selectFish(TamilFish fish) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPage(fishSpecies: fish.scientificName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Fish'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter Fish Species',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    String species = _searchController.text.trim();
                    if (species.isNotEmpty) {
                      _selectFish(filteredFishList.firstWhere(
                        (fish) =>
                            fish.localName.toLowerCase() ==
                                species.toLowerCase() ||
                            fish.scientificName.toLowerCase() ==
                                species.toLowerCase(),
                        orElse: () => TamilFish(
                            localName: species,
                            scientificName: species,
                            imagePath: ''),
                      ));
                    }
                  },
                ),
              ),
              onChanged: _filterFish,
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  childAspectRatio: 1.8, // Adjust this to make boxes shorter
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: filteredFishList.length,
                itemBuilder: (context, index) {
                  TamilFish fish = filteredFishList[index];
                  return GestureDetector(
                    onTap: () => _selectFish(fish), // Navigate on tap
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height:
                                100, // Fixed height to keep images consistent
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              image: DecorationImage(
                                image: AssetImage(fish.imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              fish.localName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
