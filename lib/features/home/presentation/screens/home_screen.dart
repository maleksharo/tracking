import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking/app/core/refresh_cubit/refresh_cubit.dart';
import 'package:tracking/app/core/widgets/error_view.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/features/home/domain/entities/cars_data_entity.dart';
import 'package:tracking/features/home/presentation/cubit/home_cubit.dart';
import 'package:tracking/features/home/presentation/screens/widgets/home_drawer.dart';
import 'package:tracking/features/home/presentation/screens/widgets/tile_providers.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeCubit = getIt<HomeCubit>();
  final refreshCubit = getIt<RefreshCubit>();
  final mapController = MapController();
  List<CarsDataEntity> carsList = [];

  @override
  void initState() {
    super.initState();
    homeCubit.getVehiclesData(firstTime: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.home.tr()),
      ),
      drawer: HomeDrawer(),
      body: FlutterMap(
        mapController: mapController,
        options: const MapOptions(
          initialCenter: LatLng(51.5, -0.09),
          initialZoom: 5,
          initialRotation: 0,
          // onTap: (_, p) => setState(() => customMarkers.add(buildPin(p))),
          interactionOptions: InteractionOptions(
            flags: ~InteractiveFlag.doubleTapDragZoom,
          ),
        ),
        children: [
          openStreetMapTileLayer,
          BlocConsumer(
            bloc: homeCubit,
            listener: (context,  state) {
              if (state is GetCarsDataFailedState) {
                Fluttertoast.showToast(msg: state.message);
              }
              if(state is GetCarLocationFailedState){
                Fluttertoast.showToast(msg: state.message);
              }
              if(state is GetCarLocationSuccessState){
                context.router.pop();
                if (state.recordsCarLocationEntity.carLocations.isEmpty) {
                  Fluttertoast.showToast(msg: LocaleKeys.noRouteFound.tr());
                }
              }
              if (state is GetCarsDataSuccessState) {
                carsList.clear();
                carsList.addAll(state.carsDataEntity.carsList);
                if (state.firstTime) {
                  mapController.move(homeCubit.initCamera(carsList: state.carsDataEntity.carsList), 2);
                }
                if (state.homeSource) {
                  homeCubit.updateData();
                }
              }
              if (state is MoveToCarLocation) {
                mapController.move(
                  state.latLng,
                  12,
                );
              }
            },
            builder: (BuildContext context, Object? state) {
              if (state is GetCarsDataFailedState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ErrorView(
                    onRetry: () {
                      homeCubit.getVehiclesData();
                    },
                    errorMsg: state.message,
                  ),
                );
              } else if (state is GetCarsDataLoadingState && state.firstTime) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0.h),
                  child: LinearProgressIndicator(
                    backgroundColor: ColorManager.darkGrey,
                  ),
                );
              }

              return Stack(
                children: [
                  PolylineLayer(
                    polylines: [
                      Polyline(
                          points: homeCubit.carLocationsRoute
                              .map(
                                (e) => LatLng(e.latitude, e.longitude),
                              )
                              .toList(),
                          strokeWidth: 4,
                          color: ColorManager.primary)
                    ],
                  ),
                  MarkerLayer(
                    markers: carsList
                        .map((e) => homeCubit.buildPin(
                              entity: e,
                              context: context,
                            ))
                        .toList(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
