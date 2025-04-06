import 'package:sqflite/sqflite.dart';
import 'package:voter_reg/modules/voter_reg/models/data_models/voter_data.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/assembly_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/caste_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/category_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/religion_drop_response_model.dart';
import 'package:voter_reg/modules/voter_reg/models/response_models/state_drop_response_model.dart';
import '../../modules/voter_reg/models/response_models/district_drop_response_model.dart';
import '../../modules/voter_reg/models/response_models/parliament_drop_response_model.dart';

class LocalData {
  static Database? _database;
  static const String tableName = "voter_data";
  final List<CategoryData> categoryList = [
    CategoryData(
      idCategory: 1,
      religionId: 1,
      casteId: 2,
      categoryName: 'Brahmin',
    ),
    CategoryData(
      idCategory: 2,
      religionId: 1,
      casteId: 2,
      categoryName: 'Maratha',
    ),
  ];

  final List<CasteData> casteList = [
    CasteData(
      idCaste: 1,
      religionId: 1,
      casteName: 'Brahmin',
    ),
    CasteData(
      idCaste: 2,
      religionId: 1,
      casteName: 'Maratha',
    ),
    CasteData(
      idCaste: 3,
      religionId: 1,
      casteName: 'Rajput',
    ),
    CasteData(
      idCaste: 4,
      religionId: 1,
      casteName: 'Kshatriya',
    ),
  ];

  final List<ReligionData> religionList = [
    ReligionData(
      idReligion: 1,
      religion: 'Hindu',
    ),
    ReligionData(
      idReligion: 2,
      religion: 'Muslim',
    ),
    ReligionData(
      idReligion: 3,
      religion: 'Christian',
    ),
    ReligionData(
      idReligion: 4,
      religion: 'Sikh',
    ),
    ReligionData(
      idReligion: 5,
      religion: 'Buddhist',
    ),
    ReligionData(
      idReligion: 6,
      religion: 'Jain',
    ),
    ReligionData(
      idReligion: 7,
      religion: 'Parsi',
    ),
    ReligionData(
      idReligion: 8,
      religion: 'Jewish',
    )
  ];

  final List<AssemblyData> assemblyList = [
    AssemblyData(
      idAssemblyData: 1891,
      assemblyName: "Ahmednagar City",
      assemblyCode: "2871",
      parliamentId: 242,
      stateMasterId: 4,
    ),
    AssemblyData(
      idAssemblyData: 1892,
      assemblyName: "Karjat jamkhed",
      assemblyCode: "2872",
      parliamentId: 242,
      stateMasterId: 4,
    ),
    AssemblyData(
      idAssemblyData: 1893,
      assemblyName: "Parner",
      assemblyCode: "2873",
      parliamentId: 242,
      stateMasterId: 4,
    ),
    AssemblyData(
      idAssemblyData: 1894,
      assemblyName: "Rahuri",
      assemblyCode: "2874",
      parliamentId: 242,
      stateMasterId: 4,
    ),
    AssemblyData(
      idAssemblyData: 1895,
      assemblyName: "Shevgaon",
      assemblyCode: "2875",
      parliamentId: 242,
      stateMasterId: 4,
    ),
    AssemblyData(
      idAssemblyData: 1896,
      assemblyName: "Shrigonda",
      assemblyCode: "2876",
      parliamentId: 242,
      stateMasterId: 4,
    ),
    AssemblyData(
      idAssemblyData: 1897,
      assemblyName: "Akola East",
      assemblyCode: "2877",
      parliamentId: 243,
      stateMasterId: 4,
    ),
    AssemblyData(
      idAssemblyData: 1898,
      assemblyName: "Akola West",
      assemblyCode: "2878",
      parliamentId: 243,
      stateMasterId: 4,
    ),
    AssemblyData(
      idAssemblyData: 1899,
      assemblyName: "Akot",
      assemblyCode: "2879",
      parliamentId: 243,
      stateMasterId: 4,
    ),
  ];

  final List<ParliamentData> parliamentList = [
    ParliamentData(
      idParliamentData: 242,
      parliamentName: "Ahmednagar",
      parliamentCode: "362",
      stateMasterId: 4,
    ),
    ParliamentData(
      idParliamentData: 243,
      parliamentName: "Akola",
      parliamentCode: "363",
      stateMasterId: 4,
    ),
  ];

  List<DistrictData> districtList = [
    DistrictData(idDistrictMaster: 12, districtName: "Beed", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 16, districtName: "Bhandara", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 23, districtName: "Chandrapur", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 100, districtName: "Nagpur", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 103, districtName: "Nashik", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 111, districtName: "Palghar", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 129, districtName: "Sindhudurg", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 146, districtName: "Wardha", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 156, districtName: "Amravati", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 209, districtName: "Jalna", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 246, districtName: "Mumbai", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 247,
        districtName: "Mumbai Suburban",
        stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 268, districtName: "Sangli", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 297, districtName: "Yavatmal", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 298, districtName: "Ahmednagar", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 348, districtName: "Hingoli", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 378, districtName: "Latur", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 392, districtName: "Nanded", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 393, districtName: "Nandurbar", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 406, districtName: "Parbhani", stateMasterId: 4),
    DistrictData(idDistrictMaster: 416, districtName: "Pune", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 417, districtName: "Raigad", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 483, districtName: "Buldhana", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 504, districtName: "Gadchiroli", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 511, districtName: "Gondia", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 520, districtName: "Jalgaon", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 579, districtName: "Ratnagiri", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 617, districtName: "Washim", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 623, districtName: "Akola", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 654,
        districtName: "Chhatrapati Sambhajinagar",
        stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 668, districtName: "Dharashiv", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 669, districtName: "Dhule", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 701, districtName: "Kolhapur", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 746, districtName: "Satara", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 756, districtName: "Solapur", stateMasterId: 4),
    DistrictData(
        idDistrictMaster: 766, districtName: "Thane", stateMasterId: 4),
  ];

  final List<StateData> stateList = [
    StateData(idStateMaster: 4, stateName: "Maharashtra"),
  ];

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = "$dbPath/voter_database.db";

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE voter_data (
          idVoterData INTEGER PRIMARY KEY AUTOINCREMENT,
          refCode TEXT,
          voterId TEXT,
          firstName TEXT,
          lastName TEXT,
          mobileNo TEXT,
          emailId TEXT,
          dob TEXT,
          addressLine1 TEXT,
          addressLine2 TEXT,
          districtId INTEGER,
          stateId INTEGER,
          religionId INTEGER,
          casteId INTEGER,
          categoryId INTEGER,
          zilla TEXT,
          parliamentId INTEGER,
          assemblyId INTEGER
        )
      ''');
      },
    );
  }

  // Insert voter (idVoterData auto-increments)
  Future<int> insertVoter(Map<String, dynamic> body) async {
    final db = await database;
    return await db.insert(tableName, body,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateVoter(Map<String, dynamic> body) async {
    final db = await database;
    return await db.update(tableName, body);
  }

  // Fetch all voters
  Future<List<VoterData>?> getAllVoters() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    if (maps.isEmpty) {
      return null;
    } else {
      return List.generate(maps.length, (i) => VoterData.fromJson(maps[i]));
    }
  }

  // Delete voter by ID
  Future<int> deleteVoter(int id) async {
    final db = await database;
    return await db
        .delete(tableName, where: "idVoterData = ?", whereArgs: [id]);
  }
}
