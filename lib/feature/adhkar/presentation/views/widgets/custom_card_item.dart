import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zker/core/functions/helper_functions.dart';
import 'package:zker/core/utils/app_colors.dart';

import 'package:zker/feature/adhkar/data/models/adhkar_item.dart';
import 'package:zker/feature/adhkar/presentation/view_model/audio_player_cubit/audio_player_cubit.dart';
import 'package:zker/feature/adhkar/presentation/view_model/audio_player_cubit/audio_player_cubit_state.dart';

class CustomCardItem extends StatefulWidget {
  const CustomCardItem({super.key, required this.item});
final AdhkarItem item;

  @override
  State<CustomCardItem> createState() => _CustomCardItemState();
}

class _CustomCardItemState extends State<CustomCardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 10,
                  children: [
                    Row(
                      children: [
                        Text(
                         widget.item.id.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(width: 265),
                        IconButton(onPressed: () => copyText(context, widget.item.text), icon:                         Icon(Icons.copy, size: 20),),

                        BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
                          builder: (contex, state) {
                            bool isPlaying = false;
      
                            if (state is AudioPlayerPlaying &&
                                state.audioPath == widget.item.audio) {
                              isPlaying = true;
                            }
                            return IconButton(
                              onPressed: () {
                                if (isPlaying) {
                                  context.read<AudioPlayerCubit>().pause();
                                } else {
                                  context.read<AudioPlayerCubit>().play(
                                   widget.item.audio,
                                  );
                                }
                              },
                              icon: Icon(
                                isPlaying == false
                                    ? Icons.play_arrow_outlined
                                    : Icons.pause,
                                size: 30,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Text(widget.item.text),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${widget.item.currentcount}/${widget.item.count}"),
                        GestureDetector(
                          onTap: () {
         setState(() {
          if(  widget.item.currentcount<  widget.item.count){
                  widget.item.currentcount+=1;
           
          }
         });
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xffecfdf5),
                            child: Text(
                              "+1",
                              style: TextStyle(color: AppColors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
  }
}