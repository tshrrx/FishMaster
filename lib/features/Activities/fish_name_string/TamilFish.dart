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
      localName: 'Vilai Meen',
      scientificName: 'Lutjanus campechanus',
      imagePath: 'assets/images/Salmon.png'),
  TamilFish(
      localName: 'Vanjaram',
      scientificName: 'Scomberomorus guttatus',
      imagePath: 'assets/images/Tuna.png'),
  // Add more fish here...
];
