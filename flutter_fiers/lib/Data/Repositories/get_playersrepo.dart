import 'dart:convert';

import 'package:flutter_fiers/Data/Models/get_players_model.dart';
import 'package:http/http.dart' as http;

class GetPlayersRepo {
  Future<GetPLayersModel?> getplayers() async {
    try {
      var response = await http.get(Uri.parse(
          "https://apiv2.allsportsapi.com/football/?&met=Players&playerId=103051168&APIkey=782fbb526483bebe3c0113d7b536d5b3442661b50aee717535a5e9c410e34328"));
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
