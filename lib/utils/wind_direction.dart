class WindDirectionUtil {
  static String getCardinalDirection(double degrees) {
    List<String> directions = [
      "N",
      "NNE",
      "NE",
      "ENE",
      "E",
      "ESE",
      "SE",
      "SSE",
      "S",
      "SSW",
      "SW",
      "WSW",
      "W",
      "WNW",
      "NW",
      "NNW",
      "N"
    ];
    int index = ((degrees + 11.25) ~/ 22.5).toInt();
    return directions[index % 16];
  }
}
