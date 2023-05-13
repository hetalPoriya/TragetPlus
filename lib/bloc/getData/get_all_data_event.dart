part of 'get_all_data_bloc.dart';

@immutable
abstract class GetAllDataEvent extends Equatable {}

class OnPressedGetClassesEvent extends GetAllDataEvent {
  OnPressedGetClassesEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnPressedGetStreamsEvent extends GetAllDataEvent {
  final int? classId;

  OnPressedGetStreamsEvent({this.classId});

  @override
  // TODO: implement props
  List<Object?> get props => [classId];
}

class OnPressedGetSubjectEvent extends GetAllDataEvent {
  final int? id;
  final int? streamId;

  OnPressedGetSubjectEvent({this.id, this.streamId});

  @override
  // TODO: implement props
  List<Object?> get props => [id, streamId];
}

class OnPressedGetTopicEvent extends GetAllDataEvent {
  final int? subjectId;
  final int? type;

  OnPressedGetTopicEvent({this.subjectId, this.type});

  @override
  // TODO: implement props
  List<Object?> get props => [subjectId, type];
}

class OnPressedGetCategories extends GetAllDataEvent {
  OnPressedGetCategories();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OnPressedGetQuestionsTopics extends GetAllDataEvent {
  final int? subjectId;
  OnPressedGetQuestionsTopics({this.subjectId});

  @override
  // TODO: implement props
  List<Object?> get props => [subjectId];
}

class OnPressedGetQuestionsEvent extends GetAllDataEvent {
  final int? topicId;

  OnPressedGetQuestionsEvent({this.topicId});

  @override
  // TODO: implement props
  List<Object?> get props => [topicId];
}

class OnPressedGetQuestionsResultsEvent extends GetAllDataEvent {
  final int? topicId;
  final int? studentId;

  OnPressedGetQuestionsResultsEvent({this.topicId, this.studentId});

  @override
  // TODO: implement props
  List<Object?> get props => [topicId, studentId];
}

class OnPressedGetReferralEvent extends GetAllDataEvent {
  final String? referralCode;

  OnPressedGetReferralEvent({this.referralCode});

  @override
  // TODO: implement props
  List<Object?> get props => [referralCode];
}

class OnPressedGetTransactiOnEvent extends GetAllDataEvent {
  final String? parentCode;
  final String? txnType;

  OnPressedGetTransactiOnEvent({this.parentCode, this.txnType});

  @override
  // TODO: implement props
  List<Object?> get props => [parentCode, txnType];
}

class OnPressedGetEarningEvent extends GetAllDataEvent {
  final String? parentCode;

  OnPressedGetEarningEvent({this.parentCode});

  @override
  // TODO: implement props
  List<Object?> get props => [parentCode];
}

class OnPressedGetSliderEvent extends GetAllDataEvent {
  OnPressedGetSliderEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
