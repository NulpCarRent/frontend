import 'dart:async';
import 'package:frontend/api/car.dart';
import 'dart:convert';
import '../config/api_config.dart';
import 'package:http/http.dart' as http;

class Api{
  Data carsFromJson(String str) =>
      Data.fromJson(json.decode(str));

  String transportToJson(Car data) => json.encode(data.toJson());

  Future<Data> getTransports() async {
    final response = await http.get(api_url);
    // print(response.body.toString());
    // Data cars = carsFromJson(response.body);
    // print(cars.cars[0].toJson());
    return carsFromJson(response.body);
  }
  
  Future<int> postTransport(Car worker) async {
    final json = worker.toJson();
    final response = await http.post(api_url, headers: {'Content-type' : 'application/json', },  body: jsonEncode(json));
    print(response.toString());
    return response.statusCode;
  }
}

class Data {
  List<Car> cars;

  Data({
    this.cars,
  });

  factory Data.fromJson(List<dynamic> json) => Data(
        cars:
            List<Car>.from(json.map((x) => Car.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "autos": List<dynamic>.from(cars.map((x) => x.toJson())),
      };
}