import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {}

class GetHomePageDetails extends HomeEvent {
final String? sId;
final String? uuId;
final String? userId;

GetHomePageDetails({this.sId, this.uuId, this.userId});

@override
  List<Object> get props =>[sId!, uuId!, userId!];

}