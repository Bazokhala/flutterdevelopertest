class Maquinaria {
  String id;
  String code;
  String brand;
  String model;
  String category;
  String status;
  double hours;

  Maquinaria({
    required this.id,
    required this.code,
    required this.brand,
    required this.model,
    required this.category,
    required this.status,
    required this.hours,
  });

  factory Maquinaria.fromJson(Map<String, dynamic> json) {
    return Maquinaria(
      id: json['_id'] as String,
      code: json['code'] as String,
      brand: json['brand'] as String,
      model: json['model'] as String,
      category: json['category'] as String,
      status: json['status'] as String,
      hours: (json['hours'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'code': code,
      'brand': brand,
      'model': model,
      'category': category,
      'status': status,
      'hours': hours,
    };
  }
}
