import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/home_animations_cubit/home_animations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';

import '../../../../../core/utils/app_colors.dart';

class BluetoothCircleAvatar extends StatelessWidget {
  const BluetoothCircleAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation =
        context.readObject<HomeAnimationsCubit>().selectDeviceButtonAnimation;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Opacity(
        opacity: animation.value,
        child: child,
      ),
      child: const CircleAvatar(
        radius: 48,
        backgroundColor: AppColors.white,
        child: CircleAvatar(
          radius: 46,
          child: Icon(
            Icons.bluetooth,
            color: AppColors.white,
            size: 36,
          ),
        ),
      ),
    );
  }
}
