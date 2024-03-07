import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tracking/app/core/refresh_cubit/refresh_cubit.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/features/home/presentation/cubit/home_cubit.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeCubit = getIt<HomeCubit>();
  final refreshCubit = getIt<RefreshCubit>();

  @override
  void initState() {
    super.initState();
    homeCubit.getCarsData();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
