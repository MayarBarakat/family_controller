
import 'package:bloc/bloc.dart';
import 'package:family_controller/models/row_of_team_model.dart';
import 'package:family_controller/models/team_model.dart';
import 'package:family_controller/shared/components/components.dart';
import 'package:family_controller/shared/network/end_points.dart';
import 'package:family_controller/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:meta/meta.dart';

import '../../models/all_meets.dart';
import '../../models/one_meet_model.dart';
import '../../module/menu_screen/menu_screen.dart';

part 'family_controller_state.dart';

class FamilyControllerCubit extends Cubit<FamilyControllerState> {
  FamilyControllerCubit() : super(FamilyControllerInitial());
  static FamilyControllerCubit get(context)=> BlocProvider.of(context);
  MenuItem currentItem = MenuItems.add;
  String selectedDate = "";

  Team mayarTeam = Team("Mayar Team", [RowOfTeam(0,"Amjad Team"),RowOfTeam(0,"Mjd Team"),RowOfTeam(0,"Dani Team"),RowOfTeam(0,"Makram Team"),]);
  Team amjadTeam = Team("Amjad Team", [RowOfTeam(0,"Mayar Team"),RowOfTeam(0,"Mjd Team"),RowOfTeam(0,"Dani Team"),RowOfTeam(0,"Makram Team"),]);
  Team mjdTeam = Team("Mjd Team", [RowOfTeam(0,"Mayar Team"),RowOfTeam(0,"Amjad Team"),RowOfTeam(0,"Dani Team"),RowOfTeam(0,"Makram Team"),]);
  Team daniTeam = Team("Dani Team", [RowOfTeam(0,"Mayar Team"),RowOfTeam(0,"Amjad Team"),RowOfTeam(0,"Mjd Team"),RowOfTeam(0,"Makram Team"),]);
  Team makramTeam = Team("Makram Team", [RowOfTeam(0,"Mayar Team"),RowOfTeam(0,"Amjad Team"),RowOfTeam(0,"Mjd Team"),RowOfTeam(0,"Dani Team"),]);

  void changeSelectedFor1TeamRadio(int value,Team team,index){
      team.rows[index].result= value;
    emit(FamilyControllerChangeSelectedRadioState());
  }


  void changeMenuItem(item,context){
    currentItem = item;
    ZoomDrawer.of(context)!.close();

    emit(FamilyControllerChangeMenuItemState());
  }
  void addNewFamilyMeet(String date,context){
    print(date);
    DioHelper.postData(
        url: ADD_MEET,
        data: {
          "date":date
        }
    ).then((value)async{
     await getAllMeets();
      showToast(msg: "Meet Added Successfully", state: ToastStates.SUCCESS);
      Navigator.pop(context);
      emit(FamilyControllerAddNewFamilyMeetState());
    }).catchError((error){
      showToast(msg: "Not Added", state: ToastStates.ERROR);
      Navigator.pop(context);
      emit(FamilyControllerAddNewFamilyMeetErrorState());
    });

  }

  List<AllMeets> allMeets = [];
  bool loadAllMeet = false;
  Future<void> getAllMeets()async {
    loadAllMeet = true;
    emit(FamilyControllerLoadAllMeetState());
    DioHelper.getData(url: GET_ALL_MEET).then((value){
     allMeets =  (value.data as List)
          .map((x) => AllMeets.fromJson(x))
      .toList();

     allMeets = allMeets.reversed.toList();
     loadAllMeet = false;
     emit(FamilyControllerAllMeetSuccessfullyState());
    }).onError((error, stackTrace){
      loadAllMeet = false;
      emit(FamilyControllerAllMeetErrorState());
    });
  }

  void sendMeetResult(meetId,context) {
    //TODO Send To Spring
    DioHelper.postData(
        url: MEET_RESULT,
        data: {
          "meetId":meetId,
          "teamScoreRequests":[
            {
              "teamName":mayarTeam.name,

              "team1Name":mayarTeam.rows[0].name,
              "team2Name":mayarTeam.rows[1].name,
              "team3Name":mayarTeam.rows[2].name,
              "team4Name":mayarTeam.rows[3].name,

              "team1Result":mayarTeam.rows[0].result,
              "team2Result":mayarTeam.rows[1].result,
              "team3Result":mayarTeam.rows[2].result,
              "team4Result":mayarTeam.rows[3].result,
            },
            {
              "teamName":amjadTeam.name,

              "team1Name":amjadTeam.rows[0].name,
              "team2Name":amjadTeam.rows[1].name,
              "team3Name":amjadTeam.rows[2].name,
              "team4Name":amjadTeam.rows[3].name,

              "team1Result":amjadTeam.rows[0].result,
              "team2Result":amjadTeam.rows[1].result,
              "team3Result":amjadTeam.rows[2].result,
              "team4Result":amjadTeam.rows[3].result,
            },
            {
              "teamName":mjdTeam.name,

              "team1Name":mjdTeam.rows[0].name,
              "team2Name":mjdTeam.rows[1].name,
              "team3Name":mjdTeam.rows[2].name,
              "team4Name":mjdTeam.rows[3].name,

              "team1Result":mjdTeam.rows[0].result,
              "team2Result":mjdTeam.rows[1].result,
              "team3Result":mjdTeam.rows[2].result,
              "team4Result":mjdTeam.rows[3].result,
            },
            {
              "teamName":daniTeam.name,

              "team1Name":daniTeam.rows[0].name,
              "team2Name":daniTeam.rows[1].name,
              "team3Name":daniTeam.rows[2].name,
              "team4Name":daniTeam.rows[3].name,

              "team1Result":daniTeam.rows[0].result,
              "team2Result":daniTeam.rows[1].result,
              "team3Result":daniTeam.rows[2].result,
              "team4Result":daniTeam.rows[3].result,
            },
            {
              "teamName":makramTeam.name,

              "team1Name":makramTeam.rows[0].name,
              "team2Name":makramTeam.rows[1].name,
              "team3Name":makramTeam.rows[2].name,
              "team4Name":makramTeam.rows[3].name,

              "team1Result":makramTeam.rows[0].result,
              "team2Result":makramTeam.rows[1].result,
              "team3Result":makramTeam.rows[2].result,
              "team4Result":makramTeam.rows[3].result,
            },
          ]
        }
    ).then((value){
       refreshChhoseModel();
       showToast(msg: value.data['data'], state: ToastStates.SUCCESS);
       Navigator.pop(context);
       emit(FamilyControllerSendMeetResultState());
    }).onError((error, stackTrace){
      showToast(msg: error.toString(), state: ToastStates.ERROR);
      refreshChhoseModel();
      Navigator.pop(context);
      emit(FamilyControllerSendMeetResultErrorState());
    });
  }


  late OneMeetModel oneMeetModel;
  bool loadOneMeet = false;
  void getOneMeetResults(String meetID) {
    loadOneMeet = true;
    emit(FamilyControllerLoadOneMeetState());
    DioHelper.postData(url: GET_ONE_MEET,data: {"meetId":meetID}).then((value){
      oneMeetModel =  OneMeetModel.fromJson(value.data);
    }).then((value){
      loadOneMeet = false;
      emit(FamilyControllerLoadOneMeetSuccessfullyState());
    }).onError((error, stackTrace){
      loadOneMeet = false;
      emit(FamilyControllerLoadOneMeetErrorState());
    });
  }

  void refreshChhoseModel() {
    mayarTeam = Team("Mayar Team", [RowOfTeam(0,"Amjad Team"),RowOfTeam(0,"Mjd Team"),RowOfTeam(0,"Dani Team"),RowOfTeam(0,"Makram Team"),]);
    amjadTeam = Team("Amjad Team", [RowOfTeam(0,"Mayar Team"),RowOfTeam(0,"Mjd Team"),RowOfTeam(0,"Dani Team"),RowOfTeam(0,"Makram Team"),]);
    mjdTeam = Team("Mjd Team", [RowOfTeam(0,"Mayar Team"),RowOfTeam(0,"Amjad Team"),RowOfTeam(0,"Dani Team"),RowOfTeam(0,"Makram Team"),]);
    daniTeam = Team("Dani Team", [RowOfTeam(0,"Mayar Team"),RowOfTeam(0,"Amjad Team"),RowOfTeam(0,"Mjd Team"),RowOfTeam(0,"Makram Team"),]);
    makramTeam = Team("Makram Team", [RowOfTeam(0,"Mayar Team"),RowOfTeam(0,"Amjad Team"),RowOfTeam(0,"Mjd Team"),RowOfTeam(0,"Dani Team"),]);
  }

  bool loadDeleteMeet = false;
  void deleteMeet(String id,context) {
    loadDeleteMeet = true;
    emit(FamilyControllerLoadDeleteMeetState());
    DioHelper.postData(
        url: DELETE_MEET,
        data: {
          "meetId":id
        }
    ).then((value)async{
     refresh(context);
      loadDeleteMeet = false;

      emit(FamilyControllerDeleteMeetSuccessfullyState());
    }).onError((error, stackTrace) {
      loadDeleteMeet = false;
      Navigator.pop(context);

      showToast(msg: "Fail To Delete", state: ToastStates.ERROR);

      emit(FamilyControllerDeleteMeetErrorState());
    });
  }
  void refresh(context)async{
    await getAllMeets();
    Navigator.pop(context);
    showToast(msg: "Deleted Successfully", state: ToastStates.SUCCESS);
  }
}
