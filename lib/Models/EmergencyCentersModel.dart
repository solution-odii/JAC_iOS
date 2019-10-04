class EmergencyCenterModel {
    final int id;
    final int version;
    final String delFlag;
    final String name;
    final String phone;
    final String email;
    final String address;
    final String duration;
    final int createdOn;
    final Object deletedOn;

    EmergencyCenterModel({this.id, this.version, this.delFlag, this.name, this.phone, this.email, this.address, this.duration, this.createdOn, this.deletedOn});

    factory EmergencyCenterModel.fromJson(Map<String, dynamic> json) {
        return EmergencyCenterModel(
            id: json['id'],
            version: json['version'],
            delFlag: json['delFlag'],
            name: json['name'],
            phone: json['phone'],
            email: json['email'],
            address: json['address'],
            duration: json['duration'],
            createdOn: json['createdOn'],
            deletedOn: json['deletedOn'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['version'] = this.version;
        data['delFlag'] = this.delFlag;
        data['name'] = this.name;
        data['phone'] = this.phone;
        data['email'] = this.email;
        data['address'] = this.address;
        data['duration'] = this.duration;
        data['createdOn'] = this.createdOn;
        data['deletedOn'] = this.deletedOn;
        return data;
    }
}