class OneMeetModel {
  List<TeamMeetRows>? teamMeetRows;

  OneMeetModel({this.teamMeetRows});

  OneMeetModel.fromJson(Map<String, dynamic> json) {
    if (json['teamMeetRows'] != null) {
      teamMeetRows = <TeamMeetRows>[];
      json['teamMeetRows'].forEach((v) {
        teamMeetRows!.add(new TeamMeetRows.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teamMeetRows != null) {
      data['teamMeetRows'] = this.teamMeetRows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamMeetRows {
  String? teamName;
  String? team1Name;
  String? team1State;
  String? team2Name;
  String? team2State;
  String? team3Name;
  String? team3State;
  String? team4Name;
  String? team4State;

  TeamMeetRows(
      {this.teamName,
        this.team1Name,
        this.team1State,
        this.team2Name,
        this.team2State,
        this.team3Name,
        this.team3State,
        this.team4Name,
        this.team4State});

  TeamMeetRows.fromJson(Map<String, dynamic> json) {
    teamName = json['teamName'];
    team1Name = json['team1Name'];
    team1State = json['team1State'];
    team2Name = json['team2Name'];
    team2State = json['team2State'];
    team3Name = json['team3Name'];
    team3State = json['team3State'];
    team4Name = json['team4Name'];
    team4State = json['team4State'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teamName'] = this.teamName;
    data['team1Name'] = this.team1Name;
    data['team1State'] = this.team1State;
    data['team2Name'] = this.team2Name;
    data['team2State'] = this.team2State;
    data['team3Name'] = this.team3Name;
    data['team3State'] = this.team3State;
    data['team4Name'] = this.team4Name;
    data['team4State'] = this.team4State;
    return data;
  }
}