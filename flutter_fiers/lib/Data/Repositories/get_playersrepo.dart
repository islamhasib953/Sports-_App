import 'dart:convert';
import 'package:flutter_fiers/Data/Models/get_players_model.dart';
import 'package:http/http.dart' as http;

class GetPlayersRepo {
  Future<GetPLayersModel?> getplayers(int id) async {
    try {
      var response = await http.get(Uri.parse(
"https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=96&APIkey=96dcd54337dd88e5c710d0afbdafaf7f08e390184032cf6b60baf041d7733994"));
      var decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        GetPLayersModel myResponse = GetPLayersModel.fromJson(decodedResponse);
        return myResponse;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
