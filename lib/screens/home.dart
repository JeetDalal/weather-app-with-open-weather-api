import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_with_api/services/api_services.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final city = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: FutureBuilder(
        future: ApiServices().getCityDataByCityName(city),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'images/morning.jpeg',
                  ),
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'weather.io',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2 - 300,
                    ),
                    Column(
                      children: [
                        Text(
                          '${snapshot.data.name}',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w200,
                            color: Colors.white,
                            fontSize: 50,
                          ),
                        ),
                        Text(
                          DateFormat('DD MMMM,yyyy').format(DateTime.now()),
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          '${(snapshot.data.main.temp - 273.15).toStringAsFixed(1)} °C',
                          style: GoogleFonts.oswald(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 80,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 130,
                          ),
                          child: Divider(
                            thickness: 2,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Feels like ${(snapshot.data.main.feelsLike - 273.15).toStringAsFixed(1)} °C',
                          style: GoogleFonts.oswald(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          '${snapshot.data.weather[0].description}',
                          style: GoogleFonts.oswald(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.wind_power,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${snapshot.data.wind.speed} km/h',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.line_weight,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${(snapshot.data.main.pressure / 1000).toInt()} atm',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.surround_sound,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${(snapshot.data.main.humidity / 100).toDouble()} oz/m3',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'images/morning.jpeg',
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
