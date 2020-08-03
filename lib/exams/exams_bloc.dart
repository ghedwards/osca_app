import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:osca_dart/app/osca_app_api.dart';
import 'package:osca_dart/osca_dart.dart';

part 'exams_bloc.freezed.dart';

class ExamsBloc extends Bloc<ExamsEvent, ExamsState> {
  ExamsBloc(this.api) : super(const ExamsState.loading()) {
    add(const ExamsEvent.reload());
  }
  final OscaAppApi api;

  @override
  Stream<ExamsState> mapEventToState(ExamsEvent event) async* {
    final exams = await api.getExams();
    exams.sort((a, b) => a.beginDate.compareTo(b.beginDate));
    yield ExamsState.loaded(exams);
  }
}

@freezed
abstract class ExamsEvent with _$ExamsEvent {
  const factory ExamsEvent.reload() = Reload;
}

@freezed
abstract class ExamsState with _$ExamsState {
  const factory ExamsState.error(String message) = Error;
  const factory ExamsState.loading() = Loading;
  const factory ExamsState.loaded(List<Exam> exams) = Loaded;
}