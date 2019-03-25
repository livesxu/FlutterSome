class Person {

  const Person({
    this.userId,
    this.title,
    this.id,
    this.body,

  });


  final String userId;
  final String id;
  final String title;
  final String body;
}

final List<Person> Persons = [

  Person(
      userId: "1",
      id: "1",
      title: "first",
      body: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1553060953312&di=8b23adb0cc18da3716399573e4bd9dfe&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F68%2F59%2F71X58PICNjx_1024.jpg"
  ),
  Person(
      userId: "2",
      id: "2",
      title: "second",
      body: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1553060954391&di=92593e09b2ce64572c364ba598be6257&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F40%2F15%2F83V58PICyKZ_1024.jpg"
  ),
  Person(
      userId: "3",
      id: "3",
      title: "third",
      body: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1553060954391&di=69035d451ca1621b8bb232faf4fe4be6&imgtype=0&src=http%3A%2F%2Fwx1.sinaimg.cn%2Flarge%2F947146f6ly1fm4s35876oj20dw0dw3zv.jpg"
  ),
  Person(
      userId: "4",
      id: "4",
      title: "fourth",
      body: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1553060954391&di=0fcc631a1559f0899c85a775fddbefc4&imgtype=0&src=http%3A%2F%2Fimg3.redocn.com%2Ftupian%2F20140816%2Flansetexiaoguangyingqichetaobaodianzhaobeijing_2736991.jpg"
  )
];