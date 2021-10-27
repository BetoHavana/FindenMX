import 'dart:convert';

class CarsFoundModel {
    CarsFoundModel({
        required this.payments,
    });

    List<Payment> payments;

    factory CarsFoundModel.fromJson(String str) => CarsFoundModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CarsFoundModel.fromMap(Map<String, dynamic> json) => CarsFoundModel(
        payments: List<Payment>.from(json["payments"].map((x) => Payment.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "payments": List<dynamic>.from(payments.map((x) => x.toMap())),
    };
}

class Payment {
    Payment({
        required this.corralonInfo,
        required this.carPaymentInfo,
        required this.paymentInfo,
    });

    CorralonInfo corralonInfo;
    CarPaymentInfo carPaymentInfo;
    PaymentInfo paymentInfo;

    factory Payment.fromJson(String str) => Payment.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Payment.fromMap(Map<String, dynamic> json) => Payment(
        corralonInfo: CorralonInfo.fromMap(json["corralon_info"]),
        carPaymentInfo: CarPaymentInfo.fromMap(json["car_payment_info"]),
        paymentInfo: PaymentInfo.fromMap(json["payment_info"]),
    );

    Map<String, dynamic> toMap() => {
        "corralon_info": corralonInfo.toMap(),
        "car_payment_info": carPaymentInfo.toMap(),
        "payment_info": paymentInfo.toMap(),
    };
}

class CarPaymentInfo {
    CarPaymentInfo({
        required this.id,
        required this.licensePlate,
        required this.state,
        required this.createdAt,
    });

    String id;
    String licensePlate;
    String state;
    DateTime createdAt;

    factory CarPaymentInfo.fromJson(String str) => CarPaymentInfo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CarPaymentInfo.fromMap(Map<String, dynamic> json) => CarPaymentInfo(
        id: json["id"],
        licensePlate: json["license_plate"],
        state: json["state"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "license_plate": licensePlate,
        "state": state,
        "created_at": createdAt.toIso8601String(),
    };
}

class CorralonInfo {
    CorralonInfo({
        required this.name,
        required this.lastName,
        required this.email,
        required this.createdAt,
        required this.updatedAt,
    });

    String name;
    String lastName;
    String email;
    DateTime createdAt;
    DateTime updatedAt;

    factory CorralonInfo.fromJson(String str) => CorralonInfo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CorralonInfo.fromMap(Map<String, dynamic> json) => CorralonInfo(
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "last_name": lastName,
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class PaymentInfo {
    PaymentInfo({
        required this.id,
        required this.amount,
        required this.createdAt,
    });

    String id;
    int amount;
    DateTime createdAt;

    factory PaymentInfo.fromJson(String str) => PaymentInfo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PaymentInfo.fromMap(Map<String, dynamic> json) => PaymentInfo(
        id: json["id"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "amount": amount,
        "created_at": createdAt.toIso8601String(),
    };
}
