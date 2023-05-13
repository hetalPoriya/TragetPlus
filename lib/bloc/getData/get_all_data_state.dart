part of 'get_all_data_bloc.dart';

@immutable
abstract class GetAllDataState extends Equatable {}

class GetAllDataInitial extends GetAllDataState {
  final bool? loading;

  GetAllDataInitial({this.loading});

  @override
  // TODO: implement props
  List<Object?> get props => [loading];
}

class GetClassesLoaded extends GetAllDataState {
  final GetClassesModel? getClassesModel;
  GetClassesLoaded({this.getClassesModel});

  @override
  // TODO: implement props
  List<Object?> get props => [getClassesModel];
}

class GetStreamsLoaded extends GetAllDataState {
  final GetStreamsModel? getStreamsModel;
  GetStreamsLoaded({this.getStreamsModel});

  @override
  // TODO: implement props
  List<Object?> get props => [getStreamsModel];
}

class GetSubjectsLoaded extends GetAllDataState {
  final GetSubjectModel? getSubjectModel;
  GetSubjectsLoaded({this.getSubjectModel});

  @override
  // TODO: implement props
  List<Object?> get props => [getSubjectModel];
}

class GetTopicsLoaded extends GetAllDataState {
  final GetTopicModel? getTopicModel;
  GetTopicsLoaded({this.getTopicModel});

  @override
  // TODO: implement props
  List<Object?> get props => [getTopicModel];
}

class GetCategoriesLoaded extends GetAllDataState {
  final GetCategories? getCategories;
  GetCategoriesLoaded({this.getCategories});

  @override
  // TODO: implement props
  List<Object?> get props => [getCategories];
}

class GetQuestionsTopicsLoaded extends GetAllDataState {
  final GetCategories? getQuestionsTOpics;
  GetQuestionsTopicsLoaded({this.getQuestionsTOpics});

  @override
  // TODO: implement props
  List<Object?> get props => [getQuestionsTOpics];
}

class GetQuestionsLoaded extends GetAllDataState {
  final GetQuestionModel? getQuestionModel;
  GetQuestionsLoaded({this.getQuestionModel});

  @override
  // TODO: implement props
  List<Object?> get props => [getQuestionModel];
}

class GetQuestionsResultLoaded extends GetAllDataState {
  final GetQuestionResultModel? getQuestionResultModel;
  GetQuestionsResultLoaded({this.getQuestionResultModel});

  @override
  // TODO: implement props
  List<Object?> get props => [getQuestionResultModel];
}

class GetReferralLoaded extends GetAllDataState {
  final MyReferralModel? myReferralModel;
  GetReferralLoaded({this.myReferralModel});

  @override
  // TODO: implement props
  List<Object?> get props => [myReferralModel];
}

class GetTransactionLoaded extends GetAllDataState {
  final GetTransactionModel? getTransactionModel;
  GetTransactionLoaded({this.getTransactionModel});

  @override
  // TODO: implement props
  List<Object?> get props => [getTransactionModel];
}

class GetEarningLoaded extends GetAllDataState {
 final  GetEarningModel? getEarningModel;
  GetEarningLoaded({this.getEarningModel});

  @override
  // TODO: implement props
  List<Object?> get props => [getEarningModel];
}

class GetSliderLoaded extends GetAllDataState {
  final  GetSlider? getSliders;
  GetSliderLoaded({this.getSliders});

  @override
  // TODO: implement props
  List<Object?> get props => [getSliders];
}
