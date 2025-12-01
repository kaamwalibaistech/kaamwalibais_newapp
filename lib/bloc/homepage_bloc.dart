import 'package:bloc/bloc.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:kaamwalijobs_new/Client/homepage_api.dart';
import 'package:kaamwalijobs_new/bloc/homepage_event.dart';
import 'package:kaamwalijobs_new/bloc/homepage_state.dart';
import 'package:kaamwalijobs_new/models/homepage_model.dart';

import '../features/auth/network/auth_repository.dart';
import '../models/categorylist.dart';

class HomepageBloc extends Bloc<HomePageEvent, HomepageState> {
  HomepageBloc() : super(HomePageInitialState()) {
    on<GetHomePageCategoriesEvents>(_getHomePageCategories);
  }

  void _getHomePageCategories(
      GetHomePageCategoriesEvents event, Emitter<HomepageState> emitter) async {
    try {
      Repositiory repositiory = Repositiory();

      Homepagemodel? homepagemodel = await repositiory.getHomePageData();
      emitter(HomePageLoadedState(homepagemodel: homepagemodel));
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<Categorylistmodel> loadCategoryUpload() async {
    return await AuthRepository().getcategorynameid();
  }

  selectCategoryDropdown(
      BuildContext context,
      Categorylistmodel categorylistModel,
      Function(String selectedName, String selectedId) onValueSelected) {
    List<SelectedListItem> dropdownData = categorylistModel.data
        .map((categorylistModel) => SelectedListItem(
            name: categorylistModel.categoryName,
            value: categorylistModel.categoryId))
        .toList();
    return DropDownState(
      dropDown: DropDown(
        // isSearchVisible: false,
        data: dropdownData,
        onSelected: (List<dynamic> selectedList) {
          if (selectedList.isNotEmpty &&
              selectedList.first is SelectedListItem) {
            SelectedListItem selectedItem =
                selectedList.first as SelectedListItem;
            onValueSelected(selectedItem.name, selectedItem.value!);
          }
        },
      ),
    ).showModal(context);
  }
}
