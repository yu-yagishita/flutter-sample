main() {
  // インスタンス生成
  var person1 = new Person('Yamada', 'Taro');
  print('${person1.firstName} ${person1.lastName}');
  // メンバ関数呼び出し
  person1.greed();
  // 名前付きコンストラクタ呼び出し
  var person2 = new Person.origin();
  print('${person2.firstName} ${person2.lastName}');

  // 静的メンバはインスタンス化しなくても呼び出し可能（クラス共通の関数、変数）
  print(Person.capacity);
  Person.staticMethod();

  // callメソッドの呼び出し
  print(person1());

  // 実は同ライブラリ内であれば、privateにアクセスできてしまう
  person2._member = 'abc';
  print(person2._member);

  var engineer1 = new Engineer('エン', 'ジニア');
  engineer1.greed();
  // 親クラスにキャストできる
  // Person engineer2 = Engineer.instance(true);
  Person engineer2 = Engineer.instance();
  // 呼ばれるのは継承クラスのgreed(ポリモーフィズム)
  engineer2.greed();
  // 明示的に元のクラスにキャストするにはasを使う
  (engineer2 as Engineer).greed();
}

class Person {
  String firstName = '';
  String lastName = '';

  // this.フィールド名の引数だけで、フィールドに値を代入できる
  // コンストラクタのブロック内ではすでに代入された状態で使用できる
  // thisを省略すると別の仮引数として扱われてしまう
  Person(this.firstName, this.lastName);

  // privateメンバは便宜上、_から始まる。ただし、同ライブラリ内であればアクセスしようと思えばアクセスできてしまう。
  String _member = 'member';

  // 名前付きコンストラクタ
  // 複数のコンストラクタをもたせたいときに使う
  Person.origin() {
    this.firstName = '氏';
    this.lastName = '名';
    // 実はメソッド内はthisを省略してもクラス内のフィールドにアクセスできる
    // firstName = '氏';
    // lastName = '名';
  }

  // メンバ関数（インスタンス化したら呼び出し可能）
  greed() {
    print('Hello ${firstName} ${lastName}');
  }

  // 同名メソッドは作成できない（メソッドのオーバーロード）
  // 引数で処理を分けたい同名メソッドを作りたければ任意引数を使う
  // greed(int a) {}

  // 静的メンバ変数
  static const capacity = 16;

  // 静的メンバ関数
  static void staticMethod() {
    print('Hello');
  }

  // callは特殊なメンバ関数
  // インスタンス名()で呼び出しできる(呼び出し可能なクラス)
  call() => '$firstName $lastName';
}

// extendsでクラスの継承（親クラスのメンバが参照できる）
class Engineer extends Person {
  final String name;

  // 親クラスのコンストラクタを呼ぶには初期化子（:）でsuperを使う
  // メンバ変数の初期化も初期化子内で行える
  Engineer(String firstName, String lastName)
      : name = '',
        super(firstName, lastName);

  Engineer.origin()
      : name = 'hello',
        super.origin() {
    print('${firstName} ${lastName}');
  }

  // 先頭にfactoryキーワードをつけるとファクトリーコンストラクタとなる
  // 自身のインスタンスを戻り値として返すことを明示できる
  // factory Engineer.instance(bool isEngineer) {
  //   var instance = isEngineer ? new Engineer.origin() : new Person.origin();
  //   return instance;
  // }
  factory Engineer.instance() {
    Engineer instance = new Engineer.origin();
    return instance;
  }

  // メソッドの上書き
  // @overrideは任意（けど書いたほうがわかりやすい）
  @override
  greed() {
    // super.greed(); // メンバ関数内でコンストラクタ以外の親クラスのメンバ関数はsuper.メンバ関数名で呼び出しできる
    print('I am ${firstName}${lastName}');
  }
}
