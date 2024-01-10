class EventCheckin {
  EventCheckin({
    this.id,
    this.active,
    this.event,
    this.user,
  });

  String? id;
  bool? active;
  String? event;
  String? user;

  factory EventCheckin.fromJson(Map<String, dynamic> json) => EventCheckin(
        id: json['id'],
        active: json['active'],
        event: json['event'],
        user: json['user'],
      );
}
