part of 'home_bloc.dart';

class HomeState extends Equatable {
  final ApiResponse<VoterListResponseModel> voterListApi;
  const HomeState({this.voterListApi = const ApiResponse.loading()});

  HomeState copyWith(
      {List<VoterData>? voterList,
      ApiResponse<VoterListResponseModel>? voterListApi}) {
    return HomeState(voterListApi: voterListApi ?? this.voterListApi);
  }

  @override
  List<Object> get props => [voterListApi];
}
