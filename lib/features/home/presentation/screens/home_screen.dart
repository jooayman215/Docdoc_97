import 'package:docdoc_app/core/helper/cache_helper.dart';
import 'package:docdoc_app/features/auth/login/presentation/screens/login_screen.dart';
import 'package:docdoc_app/features/home/logic/cubit.dart';
import 'package:docdoc_app/features/home/presentation/widget/doc_specialization_widget.dart';
import 'package:docdoc_app/features/home/presentation/widget/doctor_recommendation.dart';
import 'package:docdoc_app/features/home/presentation/widget/nearby_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/colors_manager.dart';
import '../../../../core/utils/txt_style.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit()..getHomeData();
  }

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  Future<void> _logout() async {
    await CacheHelper.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return BlocProvider.value(
      value: _homeCubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: _logout,
              icon: const Icon(Icons.logout, color: Colors.black),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenHeight * 0.03,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hi , ${widget.userName}!", style: TxtStyle.font18Weight700Black),
                        Text("How are you today?", style: TxtStyle.font11Weight400BlackGrey),
                      ],
                    ),
                    CircleAvatar(
                      radius: screenHeight * 0.032,
                      backgroundColor: ColorsManager.overWhite,
                      child: Icon(
                        Icons.notifications_outlined,
                        color: ColorsManager.black,
                        size: screenHeight * 0.033,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                const NearbyWidget(),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Doctor Speciality", style: TxtStyle.font18Weight600Black),
                    Text("See All", style: TxtStyle.font13Weight400Primary),
                  ],
                ),

                const SizedBox(height: 12),
                const DoctorSpeciality(),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Recommendation Doctor", style: TxtStyle.font18Weight600Black),
                    Text("See All", style: TxtStyle.font13Weight400Primary),
                  ],
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.45,
                  child: const RecommendationDoctor(),
                ),
              ],
            ),
          ),
        ),
    )
    );
  }
}
