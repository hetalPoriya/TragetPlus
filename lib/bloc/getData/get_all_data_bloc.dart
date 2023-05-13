import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:traget_plus/apiService/api_services.dart';
import 'package:traget_plus/models/models.dart';

part 'get_all_data_event.dart';

part 'get_all_data_state.dart';

class GetAllDataBloc extends Bloc<GetAllDataEvent, GetAllDataState> {
  GetAllDataBloc() : super(GetAllDataInitial()) {
    on<OnPressedGetClassesEvent>(_onPressedGetClassesEvent);
    on<OnPressedGetStreamsEvent>(_onPressedGetStreamsEvent);
    on<OnPressedGetSubjectEvent>(_onPressedGetSubjectEvent);
    on<OnPressedGetTopicEvent>(_onPressedGetTopicEvent);
    on<OnPressedGetCategories>(_onPressedGetCategories);
    on<OnPressedGetQuestionsTopics>(_onPressedGetQuestionsTopics);
    on<OnPressedGetQuestionsEvent>(_onPressedGetQuestionsEvent);
    on<OnPressedGetQuestionsResultsEvent>(_onPressedGetQuestionsResultsEvent);
    on<OnPressedGetReferralEvent>(_onPressedGetReferralEvent);
    on<OnPressedGetTransactiOnEvent>(_onPressedGetTransactionEvent);
    on<OnPressedGetEarningEvent>(_onPressedGetEarningEvent);
    on<OnPressedGetSliderEvent>(_onPressedGetSliderEvent);
  }

  Future<FutureOr<void>> _onPressedGetClassesEvent(
      OnPressedGetClassesEvent event, Emitter<GetAllDataState> emit) async {
    emit(GetAllDataInitial(loading: true));
    try {
      GetClassesModel? getClasses;
      getClasses = await ApiServices().getClassesApi();
      emit(GetClassesLoaded(getClassesModel: getClasses));
      emit(GetAllDataInitial(loading: false));
    } catch (e) {
      emit(GetAllDataInitial(loading: false));
    }
  }

  Future<FutureOr<void>> _onPressedGetStreamsEvent(
      OnPressedGetStreamsEvent event, Emitter<GetAllDataState> emit) async {
    emit(GetAllDataInitial(loading: true));
    try {
      GetStreamsModel? getStreamsModel;
      getStreamsModel =
          await ApiServices().getStreamsApi(classId: event.classId);
      emit(GetStreamsLoaded(getStreamsModel: getStreamsModel));
      emit(GetAllDataInitial(loading: false));
    } catch (e) {
      emit(GetAllDataInitial(loading: false));
    }
  }

  Future<FutureOr<void>> _onPressedGetSubjectEvent(
      OnPressedGetSubjectEvent event, Emitter<GetAllDataState> emit) async {
    emit(GetAllDataInitial(loading: true));
    try {
      GetSubjectModel? getSubjectModel;
      getSubjectModel =
          await ApiServices().getSubjectsApi(streamId: event.streamId);
      emit(GetSubjectsLoaded(getSubjectModel: getSubjectModel));
      emit(GetAllDataInitial(loading: false));
    } catch (e) {
      emit(GetAllDataInitial(loading: false));
    }
  }

  Future<FutureOr<void>> _onPressedGetTopicEvent(
      OnPressedGetTopicEvent event, Emitter<GetAllDataState> emit) async {
    emit(GetAllDataInitial(loading: true));
    try {
      GetTopicModel? getTopicModel;
      getTopicModel = await ApiServices()
          .getTopicsApi(subjectId: event.subjectId, type: event.type);
      emit(GetTopicsLoaded(getTopicModel: getTopicModel));
      emit(GetAllDataInitial(loading: false));
    } catch (e) {
      emit(GetAllDataInitial(loading: false));
    }
  }

  Future<FutureOr<void>> _onPressedGetCategories(
      OnPressedGetCategories event, Emitter<GetAllDataState> emit) async {
    emit(GetAllDataInitial(loading: true));
    try {
      GetCategories? getCategories;
      getCategories = await ApiServices().getCategoriesApi();
      log('MY $getCategories');
      emit(GetCategoriesLoaded(getCategories: getCategories));
      emit(GetAllDataInitial(loading: false));
    } catch (e) {
      emit(GetAllDataInitial(loading: false));
    }
  }

  Future<FutureOr<void>> _onPressedGetQuestionsTopics(
      OnPressedGetQuestionsTopics event, Emitter<GetAllDataState> emit) async {
    emit(GetAllDataInitial(loading: true));
    try {
      GetCategories? getQuestionsTOpics;
      getQuestionsTOpics = await ApiServices()
          .getQuestionsTopicApiApi(subjectId: event.subjectId);
      log('MY $getQuestionsTOpics');
      emit(GetQuestionsTopicsLoaded(getQuestionsTOpics: getQuestionsTOpics));
      emit(GetAllDataInitial(loading: false));
    } catch (e) {
      emit(GetAllDataInitial(loading: false));
    }
  }

  Future<FutureOr<void>> _onPressedGetQuestionsEvent(
      OnPressedGetQuestionsEvent event, Emitter<GetAllDataState> emit) async {
    GetQuestionModel? getQuestionsModel;
    emit(GetAllDataInitial(loading: true));
    try {
      getQuestionsModel =
          await ApiServices().getQuestionsApi(topicId: event.topicId);
      emit(GetQuestionsLoaded(getQuestionModel: getQuestionsModel));
      emit(GetAllDataInitial(loading: false));
    } catch (e) {
      emit(GetAllDataInitial(loading: false));
    }
  }

  Future<FutureOr<void>> _onPressedGetQuestionsResultsEvent(
      OnPressedGetQuestionsResultsEvent event,
      Emitter<GetAllDataState> emit) async {
    GetQuestionResultModel? getQuestionResultModel;
    emit(GetAllDataInitial(loading: true));
    try {
      getQuestionResultModel = await ApiServices().getQuestionsResultApi(
          topicId: event.topicId, studentId: event.studentId);
      emit(GetQuestionsResultLoaded(
          getQuestionResultModel: getQuestionResultModel));
      emit(GetAllDataInitial(loading: false));
    } catch (e) {
      emit(GetAllDataInitial(loading: false));
    }
  }

  Future<FutureOr<void>> _onPressedGetReferralEvent(
      OnPressedGetReferralEvent event, Emitter<GetAllDataState> emit) async {
    emit(GetAllDataInitial(loading: true));

    MyReferralModel? myReferralModel;
    try {
      myReferralModel =
          await ApiServices().getReferralApi(referralCode: event.referralCode);
      emit(GetReferralLoaded(myReferralModel: myReferralModel));
      emit(GetAllDataInitial(loading: false));
    } catch (e) {
      emit(GetAllDataInitial(loading: false));
    }
  }

  Future<FutureOr<void>> _onPressedGetTransactionEvent(
      OnPressedGetTransactiOnEvent event, Emitter<GetAllDataState> emit) async {
    GetTransactionModel? getTranscationModel;
    emit(GetAllDataInitial(loading: true));
    try {
      getTranscationModel = await ApiServices().getTransactionApi(
          parentCode: event.parentCode, txnType: event.txnType);
      emit(GetTransactionLoaded(getTransactionModel: getTranscationModel));
      emit(GetAllDataInitial(loading: false));
    } catch (e) {
      emit(GetAllDataInitial(loading: false));
    }
  }

  Future<FutureOr<void>> _onPressedGetEarningEvent(
      OnPressedGetEarningEvent event, Emitter<GetAllDataState> emit) async {
    emit(GetAllDataInitial(loading: true));
    try {
      GetEarningModel? getEarningModel;
      getEarningModel =
          await ApiServices().getEarningApi(parentCode: event.parentCode);

      emit(GetEarningLoaded(getEarningModel: getEarningModel));
      emit(GetAllDataInitial(loading: false));
    } catch (e) {
      emit(GetAllDataInitial(loading: false));
    }
  }

  Future<FutureOr<void>> _onPressedGetSliderEvent(
      OnPressedGetSliderEvent event, Emitter<GetAllDataState> emit) async {
    emit(GetAllDataInitial(loading: true));
    try {
      GetSlider? getSlider;
      getSlider = await ApiServices().getSliderApi();

      emit(GetSliderLoaded(getSliders: getSlider));
      emit(GetAllDataInitial(loading: false));
    } catch (e) {
      emit(GetAllDataInitial(loading: false));
    }
  }
}
