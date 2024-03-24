class ClassDataModel {
	String? name;
	String? lastName;
	String? uniqCode;
	int? studentCode;
	String? field;
	String? tendency;
	List<Classes>? classes;

	ClassDataModel({this.name, this.lastName, this.uniqCode, this.studentCode, this.field, this.tendency, this.classes});

	ClassDataModel.fromJson(Map<String, dynamic> json) {
		name = json['Name'];
		lastName = json['LastName'];
		uniqCode = json['UniqCode'];
		studentCode = json['StudentCode'];
		field = json['Field'];
		tendency = json['Tendency'];
		if (json['Classes'] != null) {
			classes = <Classes>[];
			json['Classes'].forEach((v) { classes!.add(Classes.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['Name'] = name;
		data['LastName'] = lastName;
		data['UniqCode'] = uniqCode;
		data['StudentCode'] = studentCode;
		data['Field'] = field;
		data['Tendency'] = tendency;
		if (classes != null) {
      data['Classes'] = classes!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Classes {
	int? day;
	List<Class>? classData;

	Classes({this.day, this.classData});

	Classes.fromJson(Map<String, dynamic> json) {
		day = json['day'];
		if (json['class'] != null) {
			classData = <Class>[];
			json['class'].forEach((v) {  classData!.add(Class.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['day'] = day;
		if (classData != null) {
      data['class'] = classData!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Class {
	String? color;
	String? className;
	String? maestro;
	String? type;
	String? start;
	String? end;
	String? apartment;
	String? classLocation;
	Students? students;

	Class({this.color, this.className, this.maestro, this.type, this.start, this.end, this.apartment, this.classLocation, this.students});

	Class.fromJson(Map<String, dynamic> json) {
		color = json['color'];
		className = json['class'];
		maestro = json['maestro'];
		type = json['type'];
		start = json['start'];
		end = json['end'];
		apartment = json['apartment'];
		classLocation = json['class_location'];
		students = json['students'] != null ? Students.fromJson(json['students']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['color'] = color;
		data['class'] = className;
		data['maestro'] = maestro;
		data['type'] = type;
		data['start'] = start;
		data['end'] = end;
		data['apartment'] = apartment;
		data['class_location'] = classLocation;
		if (students != null) {
      data['students'] = students!.toJson();
    }
		return data;
	}
}

class Students {
	String? baseUrl;
	String? count;
	List<Data>? data;

	Students({this.baseUrl, this.count, this.data});

	Students.fromJson(Map<String, dynamic> json) {
		baseUrl = json['base_url'];
		count = json['count'];
		if (json['data'] != null) {
			data = <Data>[];
			json['data'].forEach((v) { data!.add(Data.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['base_url'] = baseUrl;
		data['count'] = count;
		if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Data {
	String? avatar;

	Data({this.avatar});

	Data.fromJson(Map<String, dynamic> json) {
		avatar = json['avatar'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['avatar'] = avatar;
		return data;
	}
}

class Today {
  String? date;

  Today({this.date});

  Today.fromJson(Map<String, dynamic> json) {
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    return data;
  }
}