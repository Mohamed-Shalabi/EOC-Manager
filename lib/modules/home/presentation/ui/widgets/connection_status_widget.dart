import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/my_text.dart';
import '../../../../../core/functions/media_query_utils.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../blocs/connection_cubit/connection_cubit.dart';
import '../../blocs/home_animations_cubit/home_animations_cubit.dart';

class AnimatedConnectionStatusBanner extends StatelessWidget {
  const AnimatedConnectionStatusBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animation =
        context.read<HomeAnimationsCubit>().connectionStatusBannerAnimation;

    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            0,
            60 - 60 * animation.value,
            0,
            0,
          ),
          child: Opacity(
            opacity: animation.value,
            child: child,
          ),
        );
      },
      child: const ConnectionStatusWidget(),
    );
  }
}

class ConnectionStatusWidget extends StatelessWidget {
  const ConnectionStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionCubit, ConnectionStates>(
      builder: (BuildContext context, ConnectionStates state) {
        final isConnected = state.isConnected;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeInCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: _ConnectionStatusHolderWidget(
            isConnected: isConnected,
            key: ValueKey(isConnected),
          ),
        );
      },
    );
  }
}

class _ConnectionStatusHolderWidget extends StatelessWidget {
  const _ConnectionStatusHolderWidget({
    Key? key,
    required this.isConnected,
  }) : super(key: key);

  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth * 0.4,
      height: 36,
      decoration: BoxDecoration(
        color: isConnected ? AppColors.green : AppColors.red,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: MyText(
          isConnected ? AppStrings.connected : AppStrings.notConnected,
          style: isConnected
              ? AppTextStyles.blackTitleStyle
              : AppTextStyles.whiteTitleStyle,
        ),
      ),
    );
  }
}
