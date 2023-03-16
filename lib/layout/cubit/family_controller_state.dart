part of 'family_controller_cubit.dart';

@immutable
abstract class FamilyControllerState {}

class FamilyControllerInitial extends FamilyControllerState {}
class FamilyControllerChangeMenuItemState extends FamilyControllerState {}
class FamilyControllerChangeDateTimeState extends FamilyControllerState {}

class FamilyControllerChangeSelectedRadioState extends FamilyControllerState {}


class FamilyControllerAddNewFamilyMeetState extends FamilyControllerState {}
class FamilyControllerAddNewFamilyMeetErrorState extends FamilyControllerState {}


class FamilyControllerSendMeetResultState extends FamilyControllerState {}
class FamilyControllerSendMeetResultErrorState extends FamilyControllerState {}

class FamilyControllerLoadAllMeetState extends FamilyControllerState {}
class FamilyControllerAllMeetSuccessfullyState extends FamilyControllerState {}
class FamilyControllerAllMeetErrorState extends FamilyControllerState {}

class FamilyControllerLoadOneMeetState extends FamilyControllerState {}
class FamilyControllerLoadOneMeetSuccessfullyState extends FamilyControllerState {}
class FamilyControllerLoadOneMeetErrorState extends FamilyControllerState {}



class FamilyControllerLoadDeleteMeetState extends FamilyControllerState {}
class FamilyControllerDeleteMeetSuccessfullyState extends FamilyControllerState {}
class FamilyControllerDeleteMeetErrorState extends FamilyControllerState {}
