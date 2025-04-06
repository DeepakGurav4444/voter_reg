part of 'voter_reg_bloc.dart';

class VoterRegState extends Equatable {
  const VoterRegState(
      {this.currentPage = 0,
      this.selectedState,
      this.selectedDistrict,
      this.selectedParliament,
      this.selectedReligion,
      this.parliamentList = const ApiResponse.loading(),
      this.registerApi = const ApiResponse.completed(0),
      this.statesList = const ApiResponse.loading(),
      this.assemblyList = const ApiResponse.loading(),
      this.religionList = const ApiResponse.loading(),
      this.casteList = const ApiResponse.loading(),
      this.selectedAssembly,
      this.selectedCaste,
      this.voterActionData = const VoterActionData(action: VoterAction.add),
      this.categoryList = const ApiResponse.loading(),
      this.selectedCategory,
      this.districtList = const ApiResponse.loading()});

  final ApiResponse<int> registerApi;
  final ApiResponse<StateDropResponseModel> statesList;
  final ApiResponse<CasteDropResponseModel> casteList;
  final ApiResponse<DistrictDropResponseModel> districtList;
  final ApiResponse<ParliamentDropResponseModel> parliamentList;
  final ApiResponse<AssemblyDropResponseModel> assemblyList;
  final ApiResponse<ReligionDropResponseModel> religionList;
  final ApiResponse<CategoryDropResponseModel> categoryList; 
  final StateData? selectedState;
  final DistrictData? selectedDistrict;
  final ParliamentData? selectedParliament;
  final AssemblyData? selectedAssembly;
  final ReligionData? selectedReligion;
  final CasteData? selectedCaste;
  final CategoryData? selectedCategory;
  final VoterActionData voterActionData;
  final int currentPage;

  VoterRegState copyWith(
      {ApiResponse<int>? registerApi,
      ApiResponse<StateDropResponseModel>? statesList,
      ApiResponse<ParliamentDropResponseModel>? parliamentList,
      ApiResponse<DistrictDropResponseModel>? districtList,
      ApiResponse<AssemblyDropResponseModel>? assemblyList,
      ApiResponse<ReligionDropResponseModel>? religionList,
      ApiResponse<CasteDropResponseModel>? casteList,
      ApiResponse<CategoryDropResponseModel>? categoryList,
      AssemblyData? selectedAssembly,
      ParliamentData? selectedParliament,
      int? currentPage,
      ReligionData? selectedReligion,
      CasteData? selectedCaste,
      VoterActionData? voterActionData,
      StateData? selectedState,
      CategoryData? selectedCategory,
      DistrictData? selectedDistrict}) {
    return VoterRegState(
        registerApi: registerApi ?? this.registerApi,
        statesList: statesList ?? this.statesList,
        districtList: districtList ?? this.districtList,
        selectedState: selectedState ?? this.selectedState,
        selectedParliament: selectedParliament ?? this.selectedParliament,
        selectedDistrict: selectedDistrict ?? this.selectedDistrict,
        selectedAssembly: selectedAssembly ?? this.selectedAssembly,
        assemblyList: assemblyList ?? this.assemblyList,
        religionList: religionList ?? this.religionList,
        selectedReligion: selectedReligion ?? this.selectedReligion,
        casteList: casteList ?? this.casteList,
        selectedCaste: selectedCaste ?? this.selectedCaste,
        categoryList: categoryList ?? this.categoryList,
        selectedCategory: selectedCategory ?? this.selectedCategory,
        currentPage: currentPage ?? this.currentPage,
        parliamentList: parliamentList ?? this.parliamentList,
        voterActionData: voterActionData ?? this.voterActionData);
  }

  @override
  List<Object?> get props => [
        registerApi,
        statesList,
        districtList,
        parliamentList,
        selectedState,
        selectedDistrict,
        selectedParliament,
        selectedAssembly,
        selectedReligion,
        selectedCaste,
        assemblyList,
        religionList,
        casteList,
        categoryList,
        selectedCategory,
        currentPage,
        voterActionData
      ];
}
