import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';
import 'dart:async';

class FlaggedEventsPage extends StatefulWidget {
  @override
  _FlaggedEventsPageState createState() => _FlaggedEventsPageState();
}

class _FlaggedEventsPageState extends State<FlaggedEventsPage> {
  late DatabaseReference _databaseReference;
  List<FlaggedEvent> flaggedEvents = [];

  Stream<String> dataStream() async* {
    await for (String result in fetch_data()) {
      yield result;
    }
  }
  @override
  void initState() {
    super.initState();
    _databaseReference =
        FirebaseDatabase.instance.ref().child('flagged').child("1");
    _databaseReference.onValue.listen((event) {
      setState(() {
        flaggedEvents.clear();
        if (event.snapshot.value != null) {
          Map<dynamic, dynamic>? values = event.snapshot.value as Map<
              dynamic,
              dynamic>?;
          if (values != null) {
            values.forEach((key, value) {
              ;
              String location = values['location'];
              String date = values['date'];
              String time = values['time'];
              String suspected = values['suspected'];
              double latitude = (values['latitude']);
              double longitude = (values['longitude']);

              FlaggedEvent flaggedEvent = FlaggedEvent(
                location: location,
                date: date,
                time: time,
                suspectedActivity: suspected,
                latitude: latitude,
                longitude: longitude,
              );
              flaggedEvents.clear();
              flaggedEvents.add(flaggedEvent);
            }
            );
            setState(() {
              // Update the flaggedEvents list
              flaggedEvents = flaggedEvents;
            });
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flagged Cases",
          style: GoogleFonts.questrial(fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const MyHomePage(
                      title: "Home Page",
                    );
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const Offset begin = Offset(-1.0, 0.0);
                    const Offset end = Offset.zero;
                    const curve = Curves.ease;

                    final tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Image.asset(
                'images/LOGO.png',
                width: 34,
                height: 34,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: size.height * 0.8,
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: flaggedEvents.length,
          reverse: true,
          itemBuilder: (context, index) {
            final flaggedEvent = flaggedEvents[index];
            return buildFlaggedEventCard(flaggedEvent, size);
          },
        ),
      ),
    );
  }

  Widget buildFlaggedEventCard(FlaggedEvent flaggedEvent, Size size) {
    print("ok");
    return Container(
      width: 420,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                color: Colors.grey[200],
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        flaggedEvent.latitude, flaggedEvent.longitude),
                    zoom: 15.0,
                  ),
                  markers: <Marker>{
                    Marker(
                      markerId: const MarkerId('flaggedEventLocation'),
                      position: LatLng(
                          flaggedEvent.latitude, flaggedEvent.longitude),
                    ),
                  },
                ),
              ),
              const SizedBox(height: 30.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Location : ",
                    style: GoogleFonts.questrial(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      flaggedEvent.location,
                      style: GoogleFonts.questrial(
                        fontSize: 22.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Text(
                    "Time : ",
                    style: GoogleFonts.questrial(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    flaggedEvent.time,
                    style: GoogleFonts.questrial(
                      fontSize: 22.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                children: [
                  Text(
                    "Date : ",
                    style: GoogleFonts.questrial(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    flaggedEvent.date,
                    style: GoogleFonts.questrial(
                      fontSize: 22.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Suspicion : ",
                    style: GoogleFonts.questrial(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Flexible(
                  child:Text(
                    'Your child may be facing potential ABUSE.',
                    style: GoogleFonts.questrial(
                        fontSize: 25.0,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  ),
                  /*
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder<String>(
                          stream: dataStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              print('ok');
                              // Loading state
                              return CircularProgressIndicator();
                            } else {
                              print(snapshot.data);
                              // Data received
                              if (snapshot.data == 'warning') {
                                // Display warning text in red
                                return Text(
                                  'Your child may be facing potential ABUSE.',
                                  style: GoogleFonts.questrial(
                                      fontSize: 24.0,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                );
                              } else {
                                return Text(
                                  'Your child is safe. No need to worry about.',
                                  style: GoogleFonts.questrial(
                                      fontSize: 24.0,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stream<String> fetch_data() {
    Completer<String> completer = Completer<String>();
    DatabaseReference reference = FirebaseDatabase.instance.ref().child('test2').child('values');
    StreamController<String> controller = StreamController<String>();
    reference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> rawData = event.snapshot.value as Map<dynamic, dynamic>;
        print(rawData);
        // Process data for each sensor
        rawData.forEach((key, value) {
            String dataString = value;
            List<String> valueStrings = dataString.split(',');

            // Remove the first empty element in the list
            valueStrings.removeAt(0);

            List<double> data = valueStrings.map<double>((value) =>
                double.parse(value)).toList();

            print('Sensor key: $key');
            print('Data: $data');
            print(data.length);

            List<double> means = [];
            List<double> stdDeviations = [];

            for (int i = 0; i < data.length - 4; i++) {
              List<double> subset = data.sublist(i, i + 5);
              means.add(calculateMean(subset));
              stdDeviations.add(calculateStandardDeviation(subset));
            }
            print('3');
            List<int> excludedIndices = removeRegions(means);

            List<double> filteredNumbers = [];
            for (int i = 0; i < 220; i++) {
              if (i < means.length && !excludedIndices.contains(i)) {
                filteredNumbers.add(means[i]);
                print('4');
              }
            }

            List<double> filteredStd = [0];
            for (int i = 0; i < stdDeviations.length; i++) {
              if (!excludedIndices.contains(i)) {
                filteredStd.add(stdDeviations[i]);
                print('1');
              }
            }
            double std = calculateMean(filteredStd);

            if (std > 7 && filteredStd.length > 250) {
              controller.add('warning');
              return;
            }

            List<int> includedIndices = [];
            int a = means.length;
            for (int i = 0; i < a; i++) {
              if (!excludedIndices.contains(i)) {
                includedIndices.add(i);
              }
            }

            List<List<int>> peaks = separateListAtBreakPoints(includedIndices);

            List<List<double>> std2 = peaks.map((sublist) =>
                sublist.map((i) => stdDeviations[i]).toList()).toList();
            List<List<double>> peaks2 = peaks.map((sublist) =>
                sublist.map((i) => means[i]).toList()).toList();

            List<double> std2max = std2.map((lst) => lst.reduce(max)).toList();
            List<double> peaks2max = peaks2.map((lst) => lst.reduce(max))
                .toList();

            int count = 0;
            for (int i = 0; i < peaks2max.length; i++) {
              double currentValue = peaks2max[i];
              double stdValue = std2max[i];

              if (currentValue > 500 || stdValue > 300) {
                controller.add('warning');
                print('ok1');
                break;
              } else {
                if (currentValue > 300) {
                  count++;
                }
                if (currentValue > 150 && currentValue < 300 &&
                    stdValue > 200) {
                  count++;
                }
              }
            }

            if (count >= 5) {
              controller.add('warning');
              print('ok2');
            }
            else {
              controller.add('No warning');
              print('ok3');
            }
          }
        );
      }
      else {
        print('No data available in the snapshot.');
      }
    });
    if (!controller.hasListener) {
      return controller.stream;
    }
    return Stream<String>.empty();
  }

  double calculateMean(List<double> numbers) {
    double sum = numbers.reduce((a, b) => a + b);
    return sum / numbers.length;
  }

  double calculateStandardDeviation(List<double> numbers) {
    double mean = calculateMean(numbers);
    double sum = 0;

    for (double number in numbers) {
      double diff = number - mean;
      sum += diff * diff;
    }

    double variance = sum / numbers.length;
    return sqrt(variance);
  }

  List<int> removeRegions(List<double> numbers) {
    List<int> excludedIndices = [];
    int? startIndex;
    int count = 0;

    for (int i = 0; i < numbers.length; i++) {
      double num = numbers[i];
      if (num < 40) {
        startIndex ??= i;
        count++;
      } else {
        if (count >= 20) {
          excludedIndices.addAll(
              List<int>.generate(count, (index) => startIndex! + index));
        }
        startIndex = null;
        count = 0;
      }
    }

    if (count >= 20) {
      excludedIndices.addAll(
          List<int>.generate(count, (index) => startIndex! + index));
    }

    return excludedIndices;
  }

  List<List<int>> separateListAtBreakPoints(List<int> lst) {
    List<List<int>> result = [];
    List<int> sublist = [];

    for (int num in lst) {
      if (sublist.isEmpty || num == sublist.last + 1) {
        sublist.add(num);
      } else {
        result.add(sublist);
        sublist = [num];
      }
    }

    if (sublist.isNotEmpty) {
      result.add(sublist);
    }
    return result;
  }
}

class FlaggedEvent {
  final String location;
  final String time;
  final String date;
  final String suspectedActivity;
  final double latitude;
  final double longitude;

  FlaggedEvent({
    required this.location,
    required this.time,
    required this.date,
    required this.suspectedActivity,
    required this.latitude,
    required this.longitude,
  });

  factory FlaggedEvent.fromMap(Map<dynamic, dynamic> map) {
    return FlaggedEvent(
      location: map['location'],
      time: map['time'],
      date: map['date'],
      suspectedActivity: map['suspected'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}



