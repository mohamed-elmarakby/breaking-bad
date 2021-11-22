import 'data_layer/models/character_model.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properities = const <dynamic>[]]);
}

class ServerError extends Failure {
  final String? message;
  ServerError({this.message});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
  String get getMessage => message!;
}
