class Notes{
  int id;
  String title;
  String note;

  Notes(this.title, this.note);

  Notes.fromMap(Map map){
    id = map[id];
    title = map[title];
    note = map[note];
  }

}