import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/functions/media_query_utils.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../blocs/home_animations_cubit/home_animations_cubit.dart';

class AnimatedMonitorIcon extends StatelessWidget {
  const AnimatedMonitorIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation = context.read<HomeAnimationsCubit>().monitorAnimation;

    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: animation.value,
          child: child,
        );
      },
      child: Icon(
        Icons.desktop_windows_sharp,
        color: AppColors.purple,
        size: context.screenHeight * 0.1,
      ),
    );
  }
}
