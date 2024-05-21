

abstract class SubscribtionStates {}
class SubscribtionInitalState  extends SubscribtionStates {}
class CreateSubLoadingState extends SubscribtionStates {}
class CreateSubSuccesState extends SubscribtionStates {
   
  CreateSubSuccesState() ;
}
class CreateSubErrortate extends SubscribtionStates {
  String message ; 
  CreateSubErrortate(this.message) ;
}