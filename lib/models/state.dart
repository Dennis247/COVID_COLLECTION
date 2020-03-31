class NigeriaState {
  final int id;
  final String name;

  NigeriaState(this.id, this.name);

  static List<NigeriaState> stateListFromJson(List collection) {
    List<NigeriaState> nigeriaStateList =
        collection.map((json) => NigeriaState.fromJson(json)).toList();
    return nigeriaStateList;
  }

  NigeriaState.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json['name'];
}
