
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_comics/core/network/network_info.dart';
import 'package:mockito/mockito.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MockInternetConnectionChecker extends Mock implements InternetConnectionChecker {}


void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);
  },);
  
 group("isConnected", () {
   test("should forward the call to InternetConnectionChecker.hasConnection", () async {
    //arrange
     final tHasConnectionFuture = Future.value(true);
    when(mockInternetConnectionChecker.hasConnection).thenAnswer((_) => tHasConnectionFuture);
    //act
     final result = networkInfoImpl.isConnected;
     //assert
     verify(mockInternetConnectionChecker.hasConnection);
     expect(result, tHasConnectionFuture);

   },);
 });
}