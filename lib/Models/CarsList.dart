

class CarTypes{
  final String id;
  final String code;
  final String type;
  final String description;
  final String category;
  final String extraInfo;
  final String version;

  CarTypes({
    this.id,
    this.code,
    this.type,
    this.description,
    this.category,
    this.extraInfo,
    this.version
  });

  factory CarTypes.fromJson(Map<String, dynamic> json){
    return new CarTypes(
        id: json['id'].toString(),
        code: json['code'],
        type: json['type'],
        description: json['description'],
        category: json['category'],
        extraInfo: json['extraInfo'],
        version: json['version'].toString()

    );
  }

  Map<String, dynamic> toMap() =>{
      'id': id,
      'code': code,
      'type' : type,
      'description' : description,
      'category' : category,
      'extraInfo' : extraInfo,
      'version' : version

  };


}

class CarListTypes{
  final List<CarTypes> carListTypes;

  CarListTypes({
    this.carListTypes
  });

  factory CarListTypes.fromJson(List<dynamic> parsedJson){
    List<CarTypes> carListTypes = new List<CarTypes>();

    carListTypes = parsedJson.map((i) => CarTypes.fromJson(i)).toList();

    return new CarListTypes(
        carListTypes: carListTypes
    );
  }

}