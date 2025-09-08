import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zker/feature/sapha/data/models/ziker_model/ziker_model.dart';
import 'package:zker/feature/sapha/presentation/view_model/cubits/add_ziker_cubit/add_ziker_cubit.dart';
import 'package:zker/feature/sapha/presentation/view_model/cubits/add_ziker_cubit/add_ziker_state.dart';

class SaphaItemDetails extends StatelessWidget {
  const SaphaItemDetails({super.key, required this.zikerModel});
final ZikerModel zikerModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AddZikerCubit(),
      child:  Scaffold(
        body: SingleChildScrollView(
          child: BlocConsumer<AddZikerCubit,AddZikerStates>(
            builder: (context,state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                   zikerModel.name,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "33/${zikerModel.curCount} ",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${zikerModel.totalCount} عدد المرات الاجمالي ",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }, listener: (BuildContext context, state) {  },
          ),
        ),
      ),
    );
  }
}
