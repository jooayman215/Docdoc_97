import 'package:docdoc_app/features/home/logic/cubit.dart';
import 'package:docdoc_app/features/home/logic/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/txt_style.dart';

class RecommendationDoctor extends StatelessWidget {
  const RecommendationDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeSuccessState) {
          final allDocs = state.homeData.expand((s) => s.doctors ?? []).toList();

          if (allDocs.isEmpty) {
            return const Center(child: Text("No doctors found"));
          }

          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
            itemCount: allDocs.length,
            separatorBuilder: (_, __) => SizedBox(height: screenHeight * 0.014),
            itemBuilder: (context, index) {
              final doc = allDocs[index];

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "assets/images/home_doctor.png",
                      width: 92,
                      height: 92,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc.name ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TxtStyle.font18Weight700Black,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          doc.specialization?.name ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TxtStyle.font12Weight500Grey,
                        ),
                        const SizedBox(height: 6),

                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.yellow, size: 18),
                            const SizedBox(width: 5),
                            Text("4.8", style: TxtStyle.font12Weight500Grey),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                "(4,279 reviews)",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TxtStyle.font12Weight500Grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
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
