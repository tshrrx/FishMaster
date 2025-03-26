import 'package:fishmaster/controllers/global_contoller.dart';
import 'package:fishmaster/models/Marine/finalmarineData/marine_data.dart';
import 'package:fishmaster/models/WeatherGeneral/finalweatherData/weather_data.dart';
import 'package:fishmaster/utils/constants/day_date.dart';
import 'package:fishmaster/utils/wind_direction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MarinePage extends StatefulWidget {
  const MarinePage({super.key});

  @override
  MarinePageState createState() => MarinePageState();
}

class MarinePageState extends State<MarinePage> {
  final GlobalController globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    WeatherData weather = globalController.getData();
    MarineWeatherData marineWeather = globalController.getMarineData();
    int timestamp = DateUtil.getCurrentTimestamp();
    String formattedDate = DateUtil.formatTimestamp(timestamp);
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Weather',style: TextStyle(color: Colors.black,fontSize: 18)),
          backgroundColor: Colors.grey[100],
        ),
        body: SafeArea(
            child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            SizedBox(height: 10),
            _buildWeatherTemp("${weather.current?.current.temp!.toInt()}°"),
            _buildWeatherHeader("Nagpur", formattedDate),
            _buildWeatherCurrent(
                "${(weather.current?.current.windSpeed)} m/s",
                "${marineWeather.current?.current.windWaveDirection}",
                "${marineWeather.current?.current.seaSurfaceTemperature}°C"),
            _buildTitle("Hourly Marine Weather"),
            _buildWeatherHourly(marineWeather),
            _buildTitle("Tide Pattern"),
            _buildTidePatternChart(marineWeather),
            _buildTitle("Ocean Current Velocity"),
            _buildOceanCurrentChart(marineWeather),
            _buildTitle("Wave Height"),
            _buildWaveChart(marineWeather),
            _buildTitle("Sea Surface Temperature (SST)"),
            _buildTemperatureChart(marineWeather),
            SizedBox(height: 10),
          ],
        )));
  }
}

Widget _buildTitle(String title) {
  return Container(
    margin: const EdgeInsets.only(left: 0, right: 0, bottom: 15, top: 20),
    alignment: Alignment.topCenter,
    child: Text(
      title,
      style: TextStyle(fontSize: 20, color: Colors.grey[700]),
    ),
  );
}

Widget _buildWeatherHeader(String city, String formatedDate) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: const EdgeInsets.only(left: 0, right: 20),
        alignment: Alignment.topLeft,
        child: Text(
          city,
          style: const TextStyle(fontSize: 35, height: 0),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 0, right: 20, bottom: 20),
        alignment: Alignment.topLeft,
        child: Text(
          formatedDate,
          style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5),
        ),
      ),
    ],
  );
}

Widget _buildWeatherTemp(String temperature) {
  return Row(
    children: [
      Container(
        margin: const EdgeInsets.only(left: 0, right: 20, bottom: 20, top: 10),
        alignment: Alignment.topLeft,
        child: Text(
          temperature,
          style:
              TextStyle(fontSize: 65, height: 0.5, fontWeight: FontWeight.w300),
        ),
      ),
    ],
  );
}

Widget _buildWeatherCurrent(String windSpeed, String windDeg, String seasurfaceTemperature) {
  String direction =
      WindDirectionUtil.getCardinalDirection(double.parse(windDeg));
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logos/googleLogo.png', // Replace with your image path
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 7),
                Text(
                  windSpeed,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logos/googleLogo.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 7),
                Text(
                  direction,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logos/googleLogo.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 7),
                Text(
                  seasurfaceTemperature,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logos/googleLogo.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 7),
                Text(
                  direction,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      )
    ],
  );
}

Widget _buildWeatherHourly(MarineWeatherData marineWeather) {
  final RxInt cardIndex = 0.obs;
  String currentHour = DateFormat("HH:00").format(DateTime.now());
  int startIndex = (marineWeather.hourly?.hourly.time ?? []).indexWhere((time) {
    return time.split("T")[1].startsWith(currentHour);
  });

  if (startIndex == -1) startIndex = 0;
  int endIndex = startIndex + 12;
  List<String> timeList = (marineWeather.hourly?.hourly.time ?? []).sublist(
      startIndex,
      endIndex.clamp(0, (marineWeather.hourly?.hourly.time ?? []).length));

  return Container(
    height: 160,
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(15), // Add border radius
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: timeList.length,
        itemBuilder: (context, index) {
          String fullTime = timeList[index];
          String timeOnly =
              DateFormat("hh:mm a").format(DateTime.parse(fullTime));

          return Obx(() => GestureDetector(
                onTap: () {
                  cardIndex.value = index;
                },
                child: Container(
                  width: 80,
                  margin: const EdgeInsets.only(left: 0, right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0.5, 0),
                        blurRadius: 30,
                        color: Colors.grey.withAlpha(100),
                      )
                    ],
                    gradient: cardIndex.value == index
                        ? const LinearGradient(colors: [
                            Color(0xFF00A2E8),
                            Color(0xFF0070C0),
                          ])
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          timeOnly,
                          style: TextStyle(
                            fontSize: 12,
                            color: cardIndex.value == index
                                ? Colors.white
                                : Colors.grey[600],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Image.asset('assets/logos/googleLogo.png',
                            height: 40, width: 40),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "${marineWeather.hourly?.hourly.waveHeight?[startIndex + index] ?? 0} m",
                          style: TextStyle(
                            fontSize: 14,
                            color: cardIndex.value == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    ),
  );
}

Widget _buildWaveChart(MarineWeatherData marineWeather) {
  List<num> waveHeights = marineWeather.hourly?.hourly.waveHeight ?? [];
  List<String> timeList = marineWeather.hourly?.hourly.time ?? [];

  if (waveHeights.isEmpty || timeList.isEmpty) {
    return const Center(child: Text("No wave height data available"));
  }

  List<DateTime> parsedTimes = timeList.map((t) => DateTime.parse(t)).toList();
  DateTime now = DateTime.now();
  DateTime startTime = now.subtract(const Duration(hours: 3));
  DateTime endTime = now.add(const Duration(hours: 12));

  List<num> filteredWaveHeights = [];
  List<String> filteredTimeList = [];

  for (int i = 0; i < parsedTimes.length; i++) {
    if (parsedTimes[i].isAfter(startTime) && parsedTimes[i].isBefore(endTime)) {
      filteredWaveHeights.add(waveHeights[i]);
      filteredTimeList.add(timeList[i]);
    }
  }
  if (filteredWaveHeights.isEmpty || filteredTimeList.isEmpty) {
    return const Center(
        child: Text("No wave height data available in this time range"));
  }

  double minWaveHeight =
      filteredWaveHeights.reduce((a, b) => a < b ? a : b).toDouble();
  double maxWaveHeight =
      filteredWaveHeights.reduce((a, b) => a > b ? a : b).toDouble();

  double yMin = (minWaveHeight - 0.3).clamp(0.0, double.infinity);
  double yMax = maxWaveHeight + 0.3;

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      height: 220,
      width: filteredWaveHeights.length * 50,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: LineChart(
        LineChartData(
          minY: yMin,
          maxY: yMax,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withAlpha(76),
                strokeWidth: 1,
                dashArray: [4, 4],
              );
            },
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                interval: (yMax - yMin) / 4,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      "${value.toStringAsFixed(1)} m",
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: (filteredTimeList.length / 6).ceilToDouble(),
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < filteredTimeList.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        DateFormat("h a")
                            .format(DateTime.parse(filteredTimeList[index])),
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black, height: 2),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              left: BorderSide(color: Colors.black, width: 1),
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(filteredWaveHeights.length, (index) {
                return FlSpot(
                    index.toDouble(), filteredWaveHeights[index].toDouble());
              }),
              isCurved: true,
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlueAccent],
              ),
              barWidth: 4,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent.withAlpha(76),
                    Colors.transparent
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildTemperatureChart(MarineWeatherData marineWeather) {
  List<num> temperatures =
      marineWeather.hourly?.hourly.seaSurfaceTemperature ?? [];
  List<String> timeList = marineWeather.hourly?.hourly.time ?? [];

  if (temperatures.isEmpty || timeList.isEmpty) {
    return const Center(child: Text("No temperature data available"));
  }

  List<DateTime> parsedTimes = timeList.map((t) => DateTime.parse(t)).toList();
  DateTime now = DateTime.now();
  DateTime startTime = now.subtract(const Duration(hours: 3));
  DateTime endTime = now.add(const Duration(hours: 12));

  List<num> filteredTemperatures = [];
  List<String> filteredTimeList = [];

  for (int i = 0; i < parsedTimes.length; i++) {
    if (parsedTimes[i].isAfter(startTime) && parsedTimes[i].isBefore(endTime)) {
      filteredTemperatures.add(temperatures[i]);
      filteredTimeList.add(timeList[i]);
    }
  }

  if (filteredTemperatures.isEmpty || filteredTimeList.isEmpty) {
    return const Center(
        child: Text("No temperature data available in this time range"));
  }

  double minTemp =
      filteredTemperatures.reduce((a, b) => a < b ? a : b).toDouble();
  double maxTemp =
      filteredTemperatures.reduce((a, b) => a > b ? a : b).toDouble();

  double yMin = (minTemp - 0.8)
      .clamp(minTemp - 1, double.infinity);
  double yMax = maxTemp + 1.5;

  double yInterval = ((yMax - yMin) / 5).clamp(0.5, 2.0);

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      height: 220,
      width: filteredTemperatures.length * 50,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: LineChart(
        LineChartData(
          minY: yMin,
          maxY: yMax,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withAlpha(76),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                interval: yInterval,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      "${value.toStringAsFixed(1)}°C",
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: (filteredTimeList.length / 6).ceilToDouble(),
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < filteredTimeList.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        DateFormat("h a")
                            .format(DateTime.parse(filteredTimeList[index])),
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black, height: 2),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              left: BorderSide(color: Colors.black, width: 1),
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(filteredTemperatures.length, (index) {
                return FlSpot(
                    index.toDouble(), filteredTemperatures[index].toDouble());
              }),
              isCurved: true,
              gradient: LinearGradient(
                colors: [Colors.orangeAccent, Colors.deepOrangeAccent],
              ),
              barWidth: 4,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.orangeAccent.withAlpha(76),
                    Colors.transparent
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildTidePatternChart(MarineWeatherData marineWeather) {
  List<num>? seaLevelHeight = marineWeather.hourly?.hourly.seaLevelHeightMsl;
  List<String>? timeList = marineWeather.hourly?.hourly.time;

  if (seaLevelHeight == null || timeList == null || seaLevelHeight.isEmpty || timeList.isEmpty) {
    return const Center(child: Text("No tide data available"));
  }

  List<DateTime> parsedTimes = timeList.map((t) => DateTime.parse(t)).toList();
  DateTime now = DateTime.now();
  DateTime startTime = now.subtract(const Duration(hours: 3));
  DateTime endTime = now.add(const Duration(hours: 16));

  List<num> filteredTideHeights = [];
  List<String> filteredTimeList = [];
  for (int i = 0; i < parsedTimes.length; i++) {
    if (parsedTimes[i].isAfter(startTime) && parsedTimes[i].isBefore(endTime)) {
      filteredTideHeights.add(seaLevelHeight[i]);
      filteredTimeList.add(timeList[i]);
    }
  }

  if (filteredTideHeights.isEmpty || filteredTimeList.isEmpty) {
    return const Center(child: Text("No tide data available in this time range"));
  }

  double minTide = filteredTideHeights.reduce((a, b) => a < b ? a : b).toDouble();
  double maxTide = filteredTideHeights.reduce((a, b) => a > b ? a : b).toDouble();


  double yMin = (minTide - 0.2).clamp(0.0, double.infinity);
  double yMax = maxTide + 0.2;

  double yInterval = ((yMax - yMin) / 5).clamp(0.1, 0.5);

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      height: 220,
      width: filteredTideHeights.length * 50,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white),
      child: LineChart(
        LineChartData(
          minY: yMin,
          maxY: yMax,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.grey.withAlpha(76),
              strokeWidth: 1,
              dashArray: [4, 4],
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 60,
                interval: yInterval,
                getTitlesWidget: (value, meta) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text("${value.toStringAsFixed(2)} m",
                      style: const TextStyle(fontSize: 12, color: Colors.black)),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: (filteredTimeList.length / 8).ceilToDouble(),
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < filteredTimeList.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        DateFormat("h a").format(DateTime.parse(filteredTimeList[index])),
                        style: const TextStyle(fontSize: 12, color: Colors.black, height: 2),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              left: BorderSide(color: Colors.black, width: 1),
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(filteredTideHeights.length, (index) =>
                  FlSpot(index.toDouble(), filteredTideHeights[index].toDouble())),
              isCurved: true,
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.blue],
              ),
              barWidth: 4,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [Colors.blueAccent.withAlpha(76), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildOceanCurrentChart(MarineWeatherData marineWeather) {
  List<num>? oceanCurrentVelocity = marineWeather.hourly?.hourly.oceanCurrentVelocity;
  List<String>? timeList = marineWeather.hourly?.hourly.time;

  if (oceanCurrentVelocity == null || timeList == null || oceanCurrentVelocity.isEmpty || timeList.isEmpty) {
    return const Center(child: Text("No ocean current data available"));
  }
  List<DateTime> parsedTimes = timeList.map((t) => DateTime.parse(t)).toList();
  DateTime now = DateTime.now();
  DateTime startTime = now.subtract(const Duration(hours: 3));
  DateTime endTime = now.add(const Duration(hours: 16));

  List<num> filteredVelocities = [];
  List<String> filteredTimeList = [];
  for (int i = 0; i < parsedTimes.length; i++) {
    if (parsedTimes[i].isAfter(startTime) && parsedTimes[i].isBefore(endTime)) {
      filteredVelocities.add(oceanCurrentVelocity[i]);
      filteredTimeList.add(timeList[i]);
    }
  }

  if (filteredVelocities.isEmpty || filteredTimeList.isEmpty) {
    return const Center(child: Text("No ocean current data available in this time range"));
  }

  double minVelocity = filteredVelocities.reduce((a, b) => a < b ? a : b).toDouble();
  double maxVelocity = filteredVelocities.reduce((a, b) => a > b ? a : b).toDouble();

  double yMin = (minVelocity - 0.2).clamp(minVelocity-0.2, maxVelocity+0.2);
  double yMax = maxVelocity + 0.3;

  double yInterval = ((yMax - yMin) / 5).clamp(0.1, 0.5);

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      height: 220,
      width: filteredVelocities.length * 50,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white),
      child: LineChart(
        LineChartData(
          minY: yMin,
          maxY: yMax,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.grey.withAlpha(76),
              strokeWidth: 1,
              dashArray: [4, 4],
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 60,
                interval: yInterval,
                getTitlesWidget: (value, meta) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text("${value.toStringAsFixed(2)} m/s",
                      style: const TextStyle(fontSize: 12, color: Colors.black)),
                ),
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: (filteredTimeList.length / 8).ceilToDouble(),
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < filteredTimeList.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        DateFormat("h a").format(DateTime.parse(filteredTimeList[index])),
                        style: const TextStyle(fontSize: 12, color: Colors.black, height: 2),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              left: BorderSide(color: Colors.black, width: 1),
              bottom: BorderSide(color: Colors.black, width: 1),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(filteredVelocities.length, (index) =>
                  FlSpot(index.toDouble(), filteredVelocities[index].toDouble())),
              isCurved: true,
              gradient: LinearGradient(
                colors: [Colors.greenAccent, Colors.green],
              ),
              barWidth: 4,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [Colors.greenAccent.withAlpha(76), Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
