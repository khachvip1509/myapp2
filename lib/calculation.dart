var s = "Nguyen Ken";
int x=10;
List<int> numbers = [1,2,3,4,5,6];
List<String> stringNumbers = numbers.map((number) {
  return 'value= $number';
}).toList();