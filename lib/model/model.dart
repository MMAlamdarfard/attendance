// class ModelClass {
// 	Today? today;
// 	List<Results>? results;

// 	ModelClass({this.today, this.results});

// 	ModelClass.fromJson(Map<String, dynamic> json) {
// 		today = json['today'] != null ? Today.fromJson(json['today']) : null;
// 		if (json['results'] != null) {
// 			results = <Results>[];
// 			json['results'].forEach((v) { results!.add(Results.fromJson(v)); });
// 		}
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = <String, dynamic>{};
// 		if (today != null) {
//       data['today'] = today!.toJson();
//     }
// 		if (results != null) {
//       data['results'] = results!.map((v) => v.toJson()).toList();
//     }
// 		return data;
// 	}
// }

// class Today  {
// 	String? year;
// 	String? month;
// 	String? day;

// 	Today({this.year, this.month, this.day});
 
// 	Today.fromJson(Map<String, dynamic> json) {
// 		year = json['year'];
// 		month = json['month'];
// 		day = json['day'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = <String, dynamic>{};
// 		data['year'] = year;
// 		data['month'] = month;
// 		data['day'] = day;
// 		return data;
// 	}
  
//   String key() {
//     return "$year$month$day";
//   }
 
//   // Today todayInInteger(){
//   //   return Today(year: int.parse(year??"0"), month: int.parse(month??"0"), day: int.parse(day??"0"));
//   // }

//   @override
//   bool operator ==(covariant Today other){
//     return day == other.day && year == other.year && month == other.month;
//   }
  
//   @override
//   int get hashCode => DateTime(int.parse(year??"0"),int.parse(month??"0"),int.parse(day??"0")).microsecond;
   

// }

// class Results {
// 	String? year;
// 	String? month;
// 	String? day;
// 	List<Classes>? classes;
// 	bool? isHoliday;

// 	Results({this.year, this.month, this.day, this.classes, this.isHoliday});

// 	Results.fromJson(Map<String, dynamic> json) {
// 		year = json['year'];
// 		month = json['month'];
// 		day = json['day'];
// 		if (json['classes'] != null) {
// 			classes = <Classes>[];
// 			json['classes'].forEach((v) { classes!.add(Classes.fromJson(v)); });
// 		}
// 		isHoliday = json['is_holiday'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = <String, dynamic>{};
// 		data['year'] = year;
// 		data['month'] = month;
// 		data['day'] = day;
// 		if (classes != null) {
//       data['classes'] = classes!.map((v) => v.toJson()).toList();
//     }
// 		data['is_holiday'] = isHoliday;
// 		return data;
// 	}
// }

// class Classes {
//   String? color;
// 	String? className;
// 	String? maestro;
// 	String? type;
// 	String? start;
// 	String? end;
// 	String? apartment;
// 	String? classLocation;
// 	Students? students;
  


// 	Classes({this.className, this.maestro, this.type, this.start, this.end, this.apartment, this.classLocation, this.students});

   
//   @override
//   bool operator ==(covariant Classes other){
//     return className ==  other.className && maestro == other.maestro;
//     }
  


// 	Classes.fromJson(Map<String, dynamic> json) {
//     color = json['color'];
// 		className = json['class'];
// 		maestro = json['maestro'];
// 		type = json['type'];
// 		start = json['start'];
// 		end = json['end'];
// 		apartment = json['apartment'];
// 		classLocation = json['class_location'];
// 		students = json['students'] != null ? Students.fromJson(json['students']) : null;
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = <String, dynamic>{};
// 		data['class'] = className;
// 		data['maestro'] = maestro;
// 		data['type'] = type;
// 		data['start'] = start;
// 		data['end'] = end;
// 		data['apartment'] = apartment;
// 		data['class_location'] = classLocation;
//     data['color']= color;
// 		if (students != null) {
//       data['students'] = students!.toJson();
//     }
// 		return data;
// 	}
  
//    @override
   
//    int get hashCode => className.hashCode;
  
// }

// class Students {
// 	String? baseUrl;
// 	String? count;
// 	List<Data>? data;

// 	Students({this.baseUrl, this.count, this.data});

// 	Students.fromJson(Map<String, dynamic> json) {
// 		baseUrl = json['base_url'];
// 		count = json['count'];
// 		if (json['data'] != null) {
// 			data = <Data>[];
// 			json['data'].forEach((v) { data!.add(Data.fromJson(v)); });
// 		}
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = <String, dynamic>{};
// 		data['base_url'] = baseUrl;
// 		data['count'] = count;
// 		if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
// 		return data;
// 	}
// }

// class Data {
// 	String? avatar;

// 	Data({this.avatar});

// 	Data.fromJson(Map<String, dynamic> json) {
// 		avatar = json['avatar'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = <String, dynamic>{};
// 		data['avatar'] = avatar;
// 		return data;
// 	}
// }