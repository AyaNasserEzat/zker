import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:zker/core/utils/app_colors.dart';
import 'package:zker/feature/adan/presentation/views/prayer_times_view.dart';
import 'package:zker/feature/adan/presentation/views/widgets/prayer_time_body.dart';
import 'package:zker/feature/adhkar/presentation/views/adhkar_view.dart';
import 'package:zker/feature/home/presentation/views/home_view.dart';
import 'package:zker/feature/home/presentation/views/test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int selectedIndex = 0;

  final List<IconData> icons = [Icons.home, Icons.person,FlutterIslamicIcons.tasbih3,FlutterIslamicIcons.allah];
  final List<String> labels = ['Home', 'Profile',"ازكار","مواقيت الصلاه"];
  final List<Widget> screens = [HomeView(), Test(),AdhkarView(),PrayerTimesView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: screens[selectedIndex],
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(icons.length, (index) {
              bool isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 17.r,
                      backgroundColor: isSelected
                          ? AppColors.primaryColor
                          : AppColors.white,
                      child: Icon(
                        icons[index],
                        color: isSelected ? Colors.white : AppColors.grey,
                        size: 22,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      labels[index],
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
