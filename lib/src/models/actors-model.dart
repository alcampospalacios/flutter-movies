// Generated by https://quicktype.io
class Actors {
  List<Actor> listOfActors = [];

  Actors();

  Actors.fromJsonList(List<dynamic> listOfList) {
    if (listOfList == null) return;

    listOfList.forEach((element) {
      final actor = Actor.fromJsonMap(element);
      listOfActors.add(actor);
    });
  }
}

class Actor {
  late bool adult;
  late int gender;
  late String id;
  late String knownForDepartment;
  late String name;
  late String originalName;
  late double popularity;
  late String profilePath;
  late int castId;
  late String character;
  late String creditId;
  late int order;

  Actor({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'].toString();
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'] / 1;
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
  }

  String getProfileImage() {
    if (profilePath == null) {
      return 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png';
    }
    return 'https://image.tmdb.org/t/p/w500/$profilePath';
  }
}
