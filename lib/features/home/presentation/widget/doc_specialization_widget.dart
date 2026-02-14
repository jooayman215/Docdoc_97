import 'package:docdoc_app/features/home/logic/cubit.dart';
import 'package:docdoc_app/features/home/logic/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/txt_style.dart';

class DoctorSpeciality extends StatelessWidget {
  const DoctorSpeciality({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeSuccessState) {
          final list = state.homeData;

          if (list.isEmpty) return const SizedBox.shrink();

          return SizedBox(
            height: 92,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final item = list[index];

                return SizedBox(
                  width: 78,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFF6F7FB),
                        ),
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/logos/general_icon.png",
                          width: 26,
                          height: 26,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.name ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TxtStyle.font12Weight400BMoreBlack,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is HomeErrorState) {
          return Center(
            child: Text(state.errorMessage, style: TxtStyle.font13Weight400Primary),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
