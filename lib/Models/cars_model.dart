import 'dart:convert';

class CarsModel {
    CarsModel({
         required this.car,
    });

    Car car;

    factory CarsModel.fromJson(String str) => CarsModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CarsModel.fromMap(Map<String, dynamic> json) => CarsModel(
        car:Car.fromMap(json["car"]),
    );

    Map<String, dynamic> toMap() => {
        "car": car.toMap(),
    };

    
}

class Car {
    Car({
        this.licensePlate,
        this.model,
        this.createdAt,
        this.updatedAt,
        this.message,
    });

    String ? licensePlate;
    String ? model;
    DateTime ? createdAt;
    DateTime ? updatedAt;
    String ? message;

    factory Car.fromJson(String str) => Car.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Car.fromMap(Map<String, dynamic> json) => Car(
        licensePlate: json["license_plate"],
        model: json["model"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "license_plate": licensePlate,
        "model": model,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "message": message,
    };
}
