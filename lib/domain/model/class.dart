class Classes {
  final int id;
  final String date;
  final int duration;
  final int availableSeats;
  final int totalSeats;

  Classes({
    required this.id,
    required this.date,
    required this.duration,
    required this.availableSeats,
    required this.totalSeats,
  });

  factory Classes.fromJson(Map<String, dynamic> json) {
    return Classes(
      id: json['id'],
      date: json['class_date_time'],
      duration: json['duration'],
      availableSeats: json['available_seats'],
      totalSeats: json['total_seats'],
    );
  }

  //Map<String, dynamic> toJson() {}

  // ClassesDto toData() {
  //   return ClassesDto(
  //     id: id,
  //     date: date,
  //     duration: duration,
  //     availableSeats: availableSeats,
  //     totalSeats: totalSeats,
  //   );
  // }
}
