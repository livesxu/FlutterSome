import 'package:fish_redux/fish_redux.dart';

class interactionsComState implements Cloneable<interactionsComState> {

  int weiboId = 0;
  int reposts_count = 0;//转发数
  int comments_count = 0;//评论数
  int attitudes_count = 0;//表态数

  interactionsComState({int weiboId,int reposts_count,int comments_count,int attitudes_count}) {
    this.weiboId = weiboId;
    this.reposts_count = reposts_count;
    this.comments_count = comments_count;
    this.attitudes_count = attitudes_count;
  }

  @override
  interactionsComState clone() {
    return interactionsComState()
      ..weiboId = weiboId
      ..reposts_count = reposts_count
      ..comments_count = comments_count
      ..attitudes_count = attitudes_count;
  }
}

interactionsComState initState(Map<String, dynamic> args) {
  return interactionsComState();
}
