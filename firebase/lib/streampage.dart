import 'dart:async';

main(){
  StreamController _myStreamController = StreamController();
  void functionForStreamController() async {
      for(int i =0 ; i<10; i++){
        await Future.delayed(Duration(seconds: 1));
        _myStreamController.sink.add(i+1);
        if(i==6){_myStreamController.addError('Bir hata oluştu');}
        // hata ekledik
      }
      _myStreamController.close();// akışı durdurmak
  }
  functionForStreamController();
  _myStreamController.stream.listen(
          (event) {
            print(event*10);
          },
    onDone: (){print('onDone propertisi çalıştı..');},
    onError: (error){print(error);},
    cancelOnError: true
  );
}