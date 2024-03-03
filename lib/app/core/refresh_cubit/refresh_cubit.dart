import 'package:flutter_bloc/flutter_bloc.dart';



class RefreshCubit extends Cubit<RefreshState> {
  RefreshCubit() : super(RefreshState());

  void refresh() {
    emit(RefreshState());
  }
}

class RefreshState {}
