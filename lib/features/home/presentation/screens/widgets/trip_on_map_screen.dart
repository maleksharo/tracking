import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking/features/home/presentation/screens/widgets/tile_providers.dart';

import '../../../../../app/core/widgets/error_view.dart';
import '../../../../../app/di/injection.dart';
import '../../../../../app/resources/color_manager.dart';
import '../../../../../app/resources/strings_manager.g.dart';
import '../../cubit/home_cubit.dart';

@RoutePage()
class TripOnMapScreen extends StatefulWidget {
  const TripOnMapScreen({super.key});

  @override
  State<TripOnMapScreen> createState() => _TripOnMapScreenState();
}

class _TripOnMapScreenState extends State<TripOnMapScreen> {
  final mapController = MapController();
  final homeCubit = getIt<HomeCubit>();
  List<dynamic> flagList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeCubit.getVehicleRoutesBetweenTwoTimes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.tripReport.tr()),
      ),
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
                // Navigator.pop(context);
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
                      11);
                } else {
                  Fluttertoast.showToast(msg: LocaleKeys.noRouteFound.tr());
                }
              }

              if (state is MoveToCarLocation) {
                mapController.move(
                  state.latLng,
                  11,
                );
              }
            },
            builder: (BuildContext context, Object? state) {
              if (state is GetTripInfoFailedState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ErrorView(
                    onRetry: () {
                    },
                    errorMsg: state.message,
                  ),
                );
              } else if (state is GetTripInfoLoadingState) {
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
                    markers: flagList
                        .map((e) => homeCubit.buildFlagMarker(
                      entity: e,
                      isStart: flagList.first.latitude == e.latitude && flagList.first.longitude == e.longitude,
                      context: context,
                    ))
                        .toList(),
                  ),
                  MarkerLayer(markers: homeCubit.generateDirectionMarkers(),),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
