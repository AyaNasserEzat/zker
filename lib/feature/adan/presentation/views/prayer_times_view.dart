// import 'package:flutter/material.dart';
// import 'package:zker/feature/adan/presentation/views/widgets/adan_view_body.dart';

// class AdanView extends StatelessWidget {
//   const AdanView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const AdanViewBody();
//   }
// }
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:adhan/adhan.dart';
import 'package:intl/intl.dart';


class PrayerTimesScreen extends StatefulWidget {
  @override
  _PrayerTimesScreenState createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  Map<String, String> prayerTimes = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPrayerTimes();
  }

  Future<void> loadPrayerTimes() async {
    var permission = await Permission.location.request();
    if (!permission.isGranted) {
      setState(() {
        isLoading = false;
        prayerTimes = {"خطأ": "صلاحية الموقع غير مفعّلة"};
      });
      return;
    }

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final coordinates = Coordinates(position.latitude, position.longitude);
    final params = CalculationMethod.egyptian.getParameters();
    params.madhab = Madhab.shafi;

    final date = DateComponents.from(DateTime.now());
    final prayerTimesData = PrayerTimes(coordinates, date, params);
    final formatter = DateFormat.jm();

    setState(() {
      prayerTimes = {
        "الفجر": formatter.format(prayerTimesData.fajr),
        "الشروق": formatter.format(prayerTimesData.sunrise),
        "الظهر": formatter.format(prayerTimesData.dhuhr),
        "العصر": formatter.format(prayerTimesData.asr),
        "المغرب": formatter.format(prayerTimesData.maghrib),
        "العشاء": formatter.format(prayerTimesData.isha),
      };
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مواقيت الصلاة'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : prayerTimes.isEmpty
              ? Center(child: Text("لا توجد بيانات"))
              : ListView.builder(
                  itemCount: prayerTimes.length,
                  itemBuilder: (context, index) {
                    String prayer = prayerTimes.keys.elementAt(index);
                    String time = prayerTimes[prayer]!;
                    return ListTile(
                      title: Text(
                        prayer,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        time,
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
    );
  }
}
