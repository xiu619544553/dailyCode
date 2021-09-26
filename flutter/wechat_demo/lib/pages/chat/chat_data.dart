
class Chat {
  final String? name;
  final String? message;
  final String? image_url;

  const Chat({
    this.name,
    this.message,
    this.image_url
  });

  // 只要是被 factory修饰的构造函数，创建什么对象自己决定，比如返回一个已有对象、创建单例
  factory Chat.fromJson(Map json) {
    return Chat(
      name: json['name'],
      message: json['message'],
      image_url: json['image_url'],
    );
  }
}