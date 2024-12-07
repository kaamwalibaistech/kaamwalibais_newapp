import 'package:bloc/bloc.dart';
import 'package:kaamwalijobs_new/Client/homepage_api.dart';
import 'package:kaamwalijobs_new/bloc/homepage_event.dart';
import 'package:kaamwalijobs_new/bloc/homepage_state.dart';
import 'package:kaamwalijobs_new/models/homepage_model.dart';

class HomepageBloc extends Bloc<HomePageEvent, HomepageState> {
  HomepageBloc() : super(HomePageInitialState()) {
    on<GetHomePageCategoriesEvents>(_getHomePageCategories);
  }

  void _getHomePageCategories(
      GetHomePageCategoriesEvents event, Emitter<HomepageState> emit) async {
    try {
      Homepagemodel homepagemodel = await Repositiory().getHomePageData();
      emit(HomePageLoadedState(homepagemodel: homepagemodel));
    } on Exception catch (e) {
      (e.toString());
    }
  }
}
