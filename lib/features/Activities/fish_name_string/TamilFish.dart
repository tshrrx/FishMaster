class TamilFish {
  final String localName;
  final String scientificName;
  final String imagePath;

  TamilFish(
      {required this.localName,
      required this.scientificName,
      required this.imagePath});
}

List<TamilFish> fishList = [
  TamilFish(
      localName: 'Sura Meen',
      scientificName: 'Carcharhinus amblyrhynchos',
      imagePath: 'assets/images/Carcharhinus amblyrhynchos.png'),
  TamilFish(
      localName: 'Kuthiparava Meen',
      scientificName: 'Katsuwonus pelamis',
      imagePath: 'assets/images/Katsuwonus pelamis.png'),
  TamilFish(
      localName: 'Kanangeluthi',
      scientificName: 'Rastrelliger kanagurta',
      imagePath: 'assets/images/Rastrelliger kanagurta.png'),
  TamilFish(
      localName: 'Mathi Meen',
      scientificName: 'Sardinella longiceps',
      imagePath: 'assets/images/Sardinella longiceps.png'),
  TamilFish(
      localName: 'Vanjaram Meen',
      scientificName: 'Scomberomorus commerson',
      imagePath: 'assets/images/Scomberomorus Commerson.png'),
  TamilFish(
      localName: 'Ooli Meen',
      scientificName: 'Sphyraena chrysotaenia',
      imagePath: 'assets/images/Sphyraena chrysotaenia.png'),
];

  // Add more fish here...
