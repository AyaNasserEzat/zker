import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zker/feature/home/data/repositorys/home_repo_impl.dart';
import 'package:zker/feature/home/presentation/view_model/ayah_cubit/ayah_cubit.dart' show AyahListCubit;
import 'package:zker/feature/home/presentation/view_model/ayah_cubit/ayah_state.dart';
import 'package:zker/services/api_service.dart';

class AyahView extends StatefulWidget {
  const AyahView({super.key, required this.surahNumber});
  final int surahNumber;

  @override
  State<AyahView> createState() => _AyahViewState();
}

class _AyahViewState extends State<AyahView> {
  String displayMode = 'moshaf'; // default mode

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AyahListCubit(HomeRepoImpl(ApiService(Dio())))
        ..getAyahsBySurahNumber(surahNumber: widget.surahNumber),
      child: Scaffold(
        appBar: AppBar(
          title: Text("القرآن الكريم"),
          actions: [
            IconButton(
              icon: Icon(Icons.view_list),
              onPressed: () {
                _showDisplayModeSelector(context);
              },
            )
          ],
        ),
        body: BlocBuilder<AyahListCubit, AyahListState>(
          builder: (context, state) {
            if (state is AyahListLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is AyahListError) {
              return Center(child: Text(state.message));
            }
            if (state is AyahListLoaded) {
              final ayahs = state.ayahs;

              if (displayMode == 'moshaf') {
                // ✅ عرض مصحفي (نص كامل مع أرقام الآيات)
                return SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text.rich(
                      TextSpan(
                        children: ayahs.map((ayah) {
                          return TextSpan(
                            children: [
                              TextSpan(
                                text: ayah.text + " ",
                                style: TextStyle(fontSize: 24),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    ayah.numberInSurah.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green[900],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              } else {
                // ✅ عرض قائمة ListView
                return ListView.separated(
                  itemCount: ayahs.length,
                  separatorBuilder: (context, _) => Divider(),
                  itemBuilder: (_, index) {
                    final surah = ayahs[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text("${surah.numberInSurah}"),
                      ),
                      title: Text(
                        surah.text,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: Icon(Icons.bookmark_border),
                     
                    );
                  },
                );
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _showDisplayModeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.menu_book),
              title: Text('عرض مصحفي'),
              onTap: () {
                setState(() {
                  displayMode = 'moshaf';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('عرض قائمة'),
              onTap: () {
                setState(() {
                  displayMode = 'list';
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
