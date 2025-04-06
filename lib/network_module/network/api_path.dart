import 'package:voter_reg/network_module/network/app_config.dart';

enum APIPath { getStateDrop, getDistrictDrop, getParliamentDrop, getAssemblyDrop }

class APIPathHelper {
  static String getValue(APIPath path) {
    String baseUrl = AppConfig.getInstance().apiBaseUrl!;
    switch (path) {
      case APIPath.getStateDrop:
        return "$baseUrl/Master/GetStateMaster";
      case APIPath.getDistrictDrop:
        return "$baseUrl/Master/GetDistrictMaster";
      case APIPath.getParliamentDrop:
        return "$baseUrl/Master/GetParliamentMaster";
      case APIPath.getAssemblyDrop:
        return "$baseUrl/Master/GetAssemblyMaster";
    }
  }

  // Future<Map<String, String>> getContentType() async {
  //   var token = await SaveData.getToken();
  //   Map<String, String> contentType = {
  //     "content-type": "application/json",
  //     'Authorization': 'Bearer $token',
  //   };
  //   return contentType;
  // }
}

// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6Imthbm5hbkBnbWFpbC5jb20iLCJqdGkiOiJmOWFiYTg1Mi03ZDhmLTQ4MGMtYTJhZS04OWZkZGRmZTE1ZTMiLCJleHAiOjE3MTA0MTI0MDIsImlzcyI6Im5jY2ZpbmRpYS5jb20iLCJhdWQiOiJuY2NmaW5kaWEuY29tIn0.hfOvxoSjzEKayihilWYHs2HpjgUrHv5mur3MDLOW89Q
