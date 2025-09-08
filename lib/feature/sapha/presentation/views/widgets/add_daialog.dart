import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zker/core/utils/app_colors.dart';
import 'package:zker/feature/sapha/data/models/ziker_model/ziker_model.dart';
import 'package:zker/feature/sapha/presentation/view_model/cubits/add_ziker_cubit/add_ziker_cubit.dart';
import 'package:zker/feature/sapha/presentation/view_model/cubits/add_ziker_cubit/add_ziker_state.dart';
import 'package:zker/feature/sapha/presentation/views/widgets/add_btn.dart';
import 'package:zker/feature/sapha/presentation/views/widgets/custom_text_filed.dart';

class AddDaialog extends StatelessWidget {
  const AddDaialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          height: 300,
          width: 200,
          child: BlocConsumer<AddZikerCubit, AddZikerStates>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  Text(
                    "اضافه زكر للمسبحه",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  CustomTextFiled(
                    hintText: "اضافه زكر",
                    controller: BlocProvider.of<AddZikerCubit>(context).name,
                  ),
                  CustomTextFiled(
                    hintText: "العدد",
                    controller:
                        BlocProvider.of<AddZikerCubit>(context).maxCount,
                  ),
                  AddBtn(
                    onPressed: () {
                      var zikerModel = ZikerModel(
                        name: BlocProvider.of<AddZikerCubit>(context).name.text,
                        maxCount: int.parse(
                          BlocProvider.of<AddZikerCubit>(context).maxCount.text,
                        ),
                      );
                      BlocProvider.of<AddZikerCubit>(context).add(zikerModel);
                          // تفريغ الحقول
    BlocProvider.of<AddZikerCubit>(context).name.clear();
    BlocProvider.of<AddZikerCubit>(context).maxCount.clear();

    // قفل الديالوج
    Navigator.pop(context);

                    },
                  ),
                ],
              );
            },
            listener: (BuildContext context, Object? state) {
              if (state is AddZikerSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("تم اضافه الزكر بنجاح"),
                    duration: Duration(seconds: 2),
                  ),
                  
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
