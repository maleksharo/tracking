import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking/app/core/widgets/error_view.dart';
import 'package:tracking/app/di/injection.dart';
import 'package:tracking/app/resources/color_manager.dart';
import 'package:tracking/app/resources/strings_manager.g.dart';
import 'package:tracking/features/home/domain/entities/cars_data_entity.dart';
import 'package:tracking/features/home/presentation/cubit/home_cubit.dart';
import 'package:tracking/features/home/presentation/screens/widgets/home_drawer.dart';
import 'package:tracking/features/home/presentation/screens/widgets/tile_providers.dart';
import 'package:tracking/features/home/presentation/screens/widgets/vehicles_actions_sheet.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final homeCubit = getIt<HomeCubit>();
  TextEditingController searchKeyController = TextEditingController();
  final mapController = MapController();
  List<CarsDataEntity> carsList = [];
  List<dynamic> flagList = [];

  @override
  void initState() {
    homeCubit.getVehiclesData(firstTime: true, homeSource: false);

    homeCubit.getVehiclesData(firstTime: true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: VehiclesActionsSheet(
        carsList: carsList,
        onCarSelected: (latLang) {
          mapController.move(latLang, 18);
        },
        onShowRoutePressed: (entity) {
          homeCubit.getVehicleLastOneHourRoute(tracCarDeviceId: entity.deviceId);
        },
      ),
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
              if (state is GetTripInfoSuccessState) {
                Navigator.pop(context);
                if (state.recordsVehicleRoutesEntity.vehicleRoutes.isNotEmpty) {
                  flagList.addAll([
                    state.recordsVehicleRoutesEntity.vehicleRoutes.first,
                    state.recordsVehicleRoutesEntity.vehicleRoutes.last,
                  ]);
                  mapController.move(
                      LatLng(
                        state.recordsVehicleRoutesEntity.vehicleRoutes.first.latitude,
                        state.recordsVehicleRoutesEntity.vehicleRoutes.first.longitude,
                      ),
                      18);
                } else {
                  Fluttertoast.showToast(msg: LocaleKeys.noRouteFound.tr());
                }
              }
              if (state is GetCarsDataFailedState) {
                Fluttertoast.showToast(msg: state.message);
              }
              if (state is GetCarLocationFailedState) {
                Fluttertoast.showToast(msg: state.message);
              }
              if (state is GetCarLocationSuccessState) {
                context.router.pop();
                flagList.clear();
                if (state.recordsCarLocationEntity.carLocations.isNotEmpty) {
                  flagList.addAll([
                    state.recordsCarLocationEntity.carLocations.first,
                    state.recordsCarLocationEntity.carLocations.last,
                  ]);
                  mapController.move(homeCubit.initCamera(carsList: state.recordsCarLocationEntity.carLocations), 13);
                  mapController.move(
                      LatLng(state.recordsCarLocationEntity.carLocations.first.latitude,
                          state.recordsCarLocationEntity.carLocations.first.longitude),
                      13);
                } else {
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
                  18,
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
                        strokeWidth: 3,
                        color: ColorManager.blueSwatch[700]!,
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: carsList
                        .map((e) => homeCubit.buildCarMarker(
                      entity: e,
                      context: context,
                    ))
                        .toList(),
                  ),
                  MarkerLayer(
                    markers: flagList
                        .map((e) => homeCubit.buildFlagMarker(
                              entity: e,
                              isStart: flagList.first.latitude == e.latitude && flagList.first.longitude == e.longitude,
                              context: context,
                            ))
                        .toList(),
                  ),
                  MarkerLayer(markers: generateDirectionMarkers()),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  List<Marker> generateDirectionMarkers() {
    List<Marker> markers = [];

    int stepSize = (homeCubit.carLocationsRoute.length / 5).ceil();

    for (int i = 0; i < homeCubit.carLocationsRoute.length - 1; i += stepSize) {
      LatLng p1 = LatLng(homeCubit.carLocationsRoute[i].latitude, homeCubit.carLocationsRoute[i].longitude);
      LatLng p2 = LatLng(
          homeCubit.carLocationsRoute[min(i + stepSize, homeCubit.carLocationsRoute.length - 1)].latitude,
          homeCubit.carLocationsRoute[min(i + stepSize, homeCubit.carLocationsRoute.length - 1)].longitude);

      double angle = atan2(p2.latitude - p1.latitude, p2.longitude - p1.longitude);

      markers.add(
        Marker(
          width: 40.0.w,
          height: 40.0.w,
          point: p1,
          child: Transform.rotate(
            angle: -angle,
            child: const Icon(
              Icons.arrow_forward,
              color: ColorManager.primaryOil,
            ),
          ),
        ),
      );
    }

    return markers;
  }
}
