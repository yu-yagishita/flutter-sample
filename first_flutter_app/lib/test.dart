main() {
  print('hello World!');
  print(1 + 2);
  var a = 1;
  print(a);
  a = 2;
  print('\$で変数の値を埋め込む、$a');
  var b = 'test';
  var c = [1, 2, 3];
  List d = [3, 4, 5];

  // 定数
  final k = 1;
  // k = 2;
  const l = 1;
  List m = const [1, 2, 3];

  // forEach
  var lists = const [1, 2, 3, 4, 5];
  final listUpdate = lists.map((e) => e + 10);
  lists.forEach((element) {
    element++;
    print(element);
  });
  listUpdate.forEach((element) {
    print(element);
  });

  void enableFlags({bool bold = false, bool? hidden}) {
    print('$bold, $hidden');
  }

  enableFlags(hidden: true);

  String say(var from, String msg, [String device = 'unknown', String? mood]) {
    return '$from say $msg platform: $device mood: ${mood ?? 'unknown'}';
  }

  print(say(1, 'hello', 'ok', 'mood'));

  // 名前付き任意引数と順序付き任意引数は両方同時には使えないらしい。
  // void nameAndNinihikisu(String one, {String? two}, [String? three]){
  // print('$one, $two, $three');
  // }
}
