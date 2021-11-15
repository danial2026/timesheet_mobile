/// GooleSheetForm is a data class which stores data fields of Feedback.
class GooleSheetForm {
  String weekday;
  String date;
  String task;
  String actual;
  String goal;
  String enterexit;

  String googleSheetId;
  String id;

  GooleSheetForm(this.weekday, this.date, this.task, this.actual, this.goal,
      this.enterexit, this.googleSheetId, this.id);

  factory GooleSheetForm.fromJson(dynamic json) {
    return GooleSheetForm(
        "${json['weekday']}",
        "${json['date']}",
        "${json['task']}",
        "${json['actual']}",
        "${json['goal']}",
        "${json['enterexit']}",
        "${json['googleSheetId']}",
        "${json['id']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'weekday': weekday,
        'date': date,
        'task': task,
        'actual': actual,
        'goal': goal,
        'enterexit': enterexit,
        'googleSheetId': googleSheetId,
        'id': id
      };
}
