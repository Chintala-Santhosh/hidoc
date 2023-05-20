import 'package:bloc/bloc.dart';
import 'package:hidoc/modules/home/screens/home_event.dart';
import 'package:hidoc/modules/utils/base_state.dart';

import '../models/home_page_response.dart';
import 'home_repository.dart';

class HomeBloc extends Bloc<HomeEvent,BaseState>{
    final HomeRepository _repository = const HomeRepository();
  HomeBloc({required BaseState initialState}) : super(initialState){
    on <GetHomePageDetails>(_onGetHomePageDetails);
  }

    Future<void> _onGetHomePageDetails(event ,Emitter<BaseState>emit) async {
      emit (Loading());
      try {
        final response = await _repository.getHomePageDetails(event.sId,event.uuId,event.userId) ;
        emit (DataLoaded(event: "GetHomePageDetails",data: response));
      } catch (error, stack) {
          emit (BaseError(error.toString()));

      }
    }

}