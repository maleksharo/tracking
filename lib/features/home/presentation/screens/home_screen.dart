import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:tracking/app/core/refresh_cubit/refresh_cubit.dart';
import 'package:tracking/app/core/widgets/custom_text_field.dart';
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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final homeCubit = getIt<HomeCubit>();
  final refreshCubit = getIt<RefreshCubit>();
  final mapController = MapController();
  TextEditingController searchKeyController = TextEditingController();
  List<CarsDataEntity> carsList = [];
  List<dynamic> flagList = [];
  late AnimationController controller;

  @override
  void initState() {
    homeCubit.getVehiclesData(firstTime: true, homeSource: false);

    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(seconds: 1);
    controller.reverseDuration = const Duration(seconds: 1);
    controller.drive(CurveTween(curve: Curves.easeIn));
    homeCubit.getVehiclesData(firstTime: true);
    super.initState();
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
              if (state is GetTripInfoSuccessState) {
                Navigator.pop(context);
                Navigator.pop(context);
                if (state.recordsVehicleRoutesEntity.vehicleRoutes.isNotEmpty) {
                  flagList.addAll([
                    state.recordsVehicleRoutesEntity.vehicleRoutes.first,
                    state.recordsVehicleRoutesEntity.vehicleRoutes.last,
                  ]);
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
                if (state.recordsCarLocationEntity.carLocations.isNotEmpty) {
                  flagList.addAll([
                    state.recordsCarLocationEntity.carLocations.first,
                    state.recordsCarLocationEntity.carLocations.last,
                  ]);
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
                  15,
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
                              controller: controller,
                            ))
                        .toList(),
                  ),
                  MarkerLayer(
                    markers: flagList
                        .map((e) => homeCubit.buildFlagMarker(
                              entity: e,
                              isStart: flagList.first.latitude == e.latitude && flagList.first.longitude == e.longitude,
                              context: context,
                              controller: controller,
                            ))
                        .toList(),
                  ),
                  //
                  // MarkerLayer(
                  //   markers: generateDirectionMarkers()
                  // ),
                  searchField(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget searchField() {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: TypeAheadField<CarsDataEntity>(
        controller: searchKeyController,
        suggestionsCallback: (search) {
          List<CarsDataEntity> temp = [];
          if (search.isNotEmpty) {
            for (var item in carsList) {
              if (item.deviceName.toLowerCase().contains(search.toLowerCase()) ||
                  item.driverEntity.name.toLowerCase().contains(search.toLowerCase())) {
                temp.add(item);
              }
            }
          }
          return temp.isEmpty ? carsList : temp;
        },
        builder: (context, controller, focusNode) {
          return CustomTextField(
            controller: searchKeyController,
            focusNode: focusNode,
            hint: "Search for a car",
          );
        },
        itemBuilder: (context, car) {
          return Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: ListTile(
              title: Text(car.deviceName),
              subtitle: Text(car.driverEntity.name),
            ),
          );
        },
        onSelected: (car) {
          searchKeyController.text = car.deviceName;
          mapController.move(
            LatLng(
              car.locationEntity.latitude,
              car.locationEntity.longitude,
            ),
            12,
          );
          refreshCubit.refresh();
        },
      ),
    );
  }
// List<Marker> generateDirectionMarkers() {
//   List<Marker> markers = [];
//
//   for (int i = 0; i < homeCubit.carLocationsRoute.length - 1; i++) {
//     LatLng p1 = LatLng(homeCubit.carLocationsRoute[i].latitude, homeCubit.carLocationsRoute[i].longitude);
//     LatLng p2 = LatLng(homeCubit.carLocationsRoute[i + 1].latitude, homeCubit.carLocationsRoute[i + 1].longitude);
//
//
//     double angle = atan2(p2.latitude - p1.latitude, p2.longitude - p1.longitude);
//
//     markers.add(
//       Marker(
//         width: 40.0,
//         height: 40.0,
//         point: p1,
//        child: Transform.rotate(
//          angle: 0,
//          child: const Icon(
//            Icons.arrow_forward,
//            color: Colors.red,
//          ),
//        ),
//       ),
//     );
//   }
//
//   return markers;
// }
}
