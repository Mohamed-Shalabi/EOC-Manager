import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/my_text.dart';
import '../../../../../core/functions/media_query_utils.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../blocs/connection_stream_cubit/connection_stream_cubit.dart';

class ConnectionStatusWidget extends StatelessWidget {
  const ConnectionStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionStreamCubit, ConnectionStates>(
      builder: (BuildContext context, ConnectionStates state) {
        final isConnected = state is ConnectionConnectedState;
        return Container(
          width: context.screenWidth * 0.4,
          height: 36,
          decoration: BoxDecoration(
            color: isConnected
                ? AppColors.green
                : AppColors.red,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: MyText(
              isConnected
                  ? AppStrings.connected
                  : AppStrings.notConnected,
              style: AppTextStyles.titleStyle,
            ),
          ),
        );
      },
    );
  }
}
