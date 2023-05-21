import 'package:ergonomic_office_chair_manager/modules/home/domain/data_holders/device.dart';
import 'package:ergonomic_office_chair_manager/modules/home/presentation/blocs/connection_cubit/connection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/my_text.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class DevicesListView extends StatelessWidget {
  const DevicesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final devices = context.watch<List<Device>>();

    return ListView.separated(
      padding: const EdgeInsets.only(top: 24),
      itemCount: devices.length,
      separatorBuilder: (context, index) {
        return const Divider(
          color: AppColors.white,
        );
      },
      itemBuilder: (context, index) {
        final device = devices[index];
        return InkWell(
          onTap: () {
            context.read<ConnectionCubit>().connect(device);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                MyText(
                  device.name,
                  style: AppTextStyles.whiteTitleStyle,
                ),
                const SizedBox(height: 8),
                MyText(
                  device.id,
                  style: AppTextStyles.whiteSubTitleStyle,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
