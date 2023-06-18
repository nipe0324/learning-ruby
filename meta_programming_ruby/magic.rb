# 1. アラウンドエイリアス
# 再定義したメソッドから以前のメソッドをエイリアスで呼び出す
class String
  alias_method :old_reverse, :reverse

  def reverse
    "**#{old_reverse}**"
  end
end

p "abc".reverse
#=> "**cba**

# 2. ブランクストレート
# オブジェクトからメソッドを削除して、すべてゴーストメソッドにする
class C2 < BasicObject
  def method_missing(_name, *_args)
    "a Ghost Method"
  end
end

blank_state = C2.new
p blank_state.to_s
#=> "a Ghost Method"

# 3. クラス拡張
# クラスの特異クラスにモジュールをインクルードして、クラスメソッドを定義する
class C3; end

module M3
  def my_method
    'a class method'
  end
end

class << C3
  include M3
end

p C3.my_method
#=> "a class method"

# 4. クラスインスタンス変数
# クラスの状態をClassオブジェクトのインスタンス変数に格納する
class C4
  @my_class_instance_variable = "some value"

  def self.class_attribute
    @my_class_instance_variable
  end
end

p C4.class_attribute
#=> "some value"

# 5. クラスマクロ
# クラス定義の中で暮らすメソッドを使う
class C5
  def self.my_macro(arg)
    p "my_macro(#{arg}) called"
  end
end

class C5
  my_macro :x
  # => "my_macro(x) called"
end

# 6. クリーンルーム
# ブロックを評価する環境としてオブジェクトを使う
class CleanRoom
  def a_useful_method(x)
    x * 2
  end
end

p CleanRoom.new.instance_eval { a_useful_method(3) }
#=> 6

# 7. コードプロセッサ
# 外部ソースにあるコード文字列を処理する
code = <<~CODE
  1 + 1
  3 * 2
  Math.log10(100)
CODE

code.split("\n").each do |line|
  puts "#{line.chomp} ==> #{eval(line)}"
end
# 1 + 1 ==> 2
# 3 * 2 ==> 6
# Math.log10(100) ==> 2.0

# 8. コンテキスト探査機
# オブジェクトのコンテキストにある情報にアクセスするためにブロックを実行する
class C8
  def initialize
    @x = "a private instance variable"
  end
end

c8_obj = C8.new
p c8_obj.instance_eval { @x }
#=> "a private instance variable"

# 9. あとで評価
# Procやlambdaにコードとコンテキストを保持させて、後で評価する
class C9
  def store(&block)
    @my_code_capsule = block
  end

  def execute
    @my_code_capsule.call
  end
end

c9_obj = C9.new
c9_obj.store { $X = 1 }
$X = 0

c9_obj.execute
p $X
#=> 1

# 10. 動的ディスパッチ
# 実行時に呼び出すメソッドを決める
method_to_call = :upcase
obj = "abc"

p obj.send(method_to_call)
#=> "ABC"

# 11. 動的メソッド
# 実行時にメソッドの定義方法を決める
class C11; end

C11.class_eval do
  define_method :my_method do
    "a dynamic method"
  end
end

c11_obj = C11.new
p c11_obj.my_method
#=> "a dynamic method"

# 12. 動的プロキシ
# メソッド呼び出しを動的に他のオブジェクトに転送する
class MyDynamicProxy
  def initialize(target)
    @target = target
  end

  def method_missing(name, *args, &block)
    "result: #{@target.send(name, *args, &block)}"
  end
end

obj = MyDynamicProxy.new("a string")
p obj.upcase
#=> "result: A STRING"

# 13. フラットスコープ
# クロージャを使って、2つのスコープで変数を共有する
class C13
  def an_attribute
    @attr
  end
end

obj = C13.new
a_variable = 100

obj.instance_eval do
  @attr = a_variable
end

p obj.an_attribute
#=> 100

# 14. ゴーストメソッド
# 該当するメソッドのないメッセージに応答する
class C14
  def method_missing(name, *args)
    name.to_s.upcase
  end
end

obj = C14.new
p obj.my_ghost_method
#=> "MY_GHOST_METHOD"

# 15. フックメソッド
# メソッドをオーバーライドして、オブジェクトモデルのイベントを捕まえる
$INHERITORS = []

class C15
  def self.inherited(subclass)
    $INHERITORS << subclass
  end
end

class D15 < C15; end
class E15 < C15; end
class F15 < C15; end

p $INHERITORS
#=> [D15, E15, F15]

# 16. カーネルメソッド
# すべてのオブジェクトで使えるようにKernelモジュールにメソッドを定義する
module Kernel
  def a_method
    "a kernel method"
  end
end

p a_method
#=> "a kernel method"

# 17. 遅延インスタンス変数
# 最初にアクセスされるまでインスタンス変数を初期化しない
class C17
  def attribute
    @attribute ||= "some value"
  end
end

obj = C17.new
p obj.instance_variables
#=> []

obj.attribute
p obj.instance_variables
#=> [:@attribute]

# 18. ミミックメソッド
# 他の言語要素に偽装したメソッド
def BaseClass(name)
  name == "string" ? String : Object
end

class C18 < BaseClass "string" # クラスのように見えるが実態はメソッド
  attr_accessor :an_attribute  # キーワードのように見えるが実態はメソッド
end

obj = C18.new
obj.an_attribute = 1 # 属性のように見えるがメソッド

# 19. モンキーパッチ
# 既存のクラスの振る舞いを変更する
class String
  def reverse
    "override"
  end
end

p "abc".reverse
#=> "override"

# 20. ネームスペース
# 定数をモジュール内に定義して、名前の衝突を避ける
module MyNamespace
  class Array
    def to_s
      "my array class"
    end
  end
end

p Array.new.to_s
#=> []
p MyNamespace::Array.new.to_s
#=> my array class

# 21. nilガード
# nilへの参照をOR演算子で置き換える
x = nil
y = x || "a value"
p y
#=> "a value"

# 22. オブジェクト拡張
# オブジェクトの特異クラスにモジュールをインクルードして、特異メソッドを定義する
obj = Object.new

module M22
  def my_method
    "a singleton method"
  end
end

class << obj
  include M22
end

p obj.my_method
#=> "a singleton method"

# 23. オープンクラス
# 既存のクラスを修正する
class String
  def my_string_method
    "my method"
  end
end

p "abc".my_string_method
#=> "my method"

# 24. Prependラッパー
# プリペンドした側からメソッドを呼び出す
module M24
  def upcase
    "x#{super}x"
  end
end

# class String
#   prepend M24
# end

String.class_eval do
  prepend M24
end

p "abc".upcase
#=> "xABCx"

# 25. Refinments
# ファイルの終わりまで、あるいはモジュールのインクルードが有効な範囲まで、クラスにパッチを当てる
module MyRefinments
  refine String do
    def downcase
      "my downcase"
    end
  end
end

p "ABC".downcase
#=> "abc"

using MyRefinments
p "ABC".downcase
#=> "my downcase"

# 26. Refinmentsラッパー
# Refinmentsしたほうから、Refinmentsしていないほうのメソッドを呼び出す
module StringRefinments
  refine String do
    def downcase
      "x#{super}x"
    end
  end
end

using StringRefinments
p "ABC".downcase

# 27. サンドボックス
# 信頼できないコードを安全な環境で実行する
def sandbox(&code)
  proc {
    $SAFE = 2
    yield
  }.call
end

begin
  sandbox { File.delete "a_file" }
rescue Exception => e
  p e.message
  #=> "No such file or directory @ apply2files - a_file"
end

# 28. スコープゲート
# class, module, defキーワードでスコープを区切る
a = 1
p defined? a
#=> "local-variable"

module MyModule
  b = 1
  p defined? a
  #=> nil
  p defined? b
  #=> "local-variable"
end

p defined? a
#=> "local-variable"
p defined? b
#=> nil

# 29. 自己yield
# ブロックにselfを渡す
class Person
  attr_accessor :name, :surname

  def initialize
    yield self
  end
end

joe = Person.new do |p|
  p.name = 'Joe'
  p.surname = 'Smith'
end

# 30. 共有スコープ
# 同じフラットスコープの複数のコンテキストで変数を共有する
lambda {
  shared = 10
  self.class.class_eval do
    define_method :counter do
      shared
    end

    define_method :down do
      shared -= 1
    end
  end
}.call

p counter #=> 10
3.times { down }
p counter #=> 7

# 31. 特異メソッド（シングルトンメソッド）
# 特定のオブジェクトにメソッドを定義する
obj = "abc"

class << obj
  def my_singleton_method
    "x"
  end
end

p obj.my_singleton_method #=> "x"

# 32. コード文字列
# 文字列のRubyコードを評価する
my_string_of_code = "1 + 1"
p eval(my_string_of_code) #=> 2

# 33. SymbolのProc変換
p [1, 2, 3, 4].map(&:even?) #=> [false, true, false, true]
