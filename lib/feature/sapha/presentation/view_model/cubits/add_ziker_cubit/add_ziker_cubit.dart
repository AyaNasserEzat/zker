import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:zker/core/utils/hive_box.dart';
import 'package:zker/feature/sapha/data/models/ziker_model/ziker_model.dart';
import 'package:zker/feature/sapha/presentation/view_model/cubits/add_ziker_cubit/add_ziker_state.dart';

class AddZikerCubit extends Cubit<AddZikerStates> {

  AddZikerCubit():super(AddZikerInitial());

  TextEditingController name=TextEditingController();
  TextEditingController maxCount=TextEditingController();
  List<ZikerModel> zikerList=[];
  add(ZikerModel zikerModel){
    emit(AddZikerLoading());
   try {
  var zikerBox= Hive.box<ZikerModel>(HiveBoxes.ziker);
  zikerBox.add(zikerModel);
  emit(AddZikerSuccess());
  fetchallZiker();
}  catch (e) {
emit(AddZikerError(e.toString()));
}

  }

   fetchallZiker(){
  var zikerBox= Hive.box<ZikerModel>(HiveBoxes.ziker);
  zikerList=zikerBox.values.toList();
  emit(FetchAllZikerSuccess());
 }
 
}