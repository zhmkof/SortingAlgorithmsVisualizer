class SortingAlgorithm {
	///title标题，complexity复杂度
  String title, complexity;
  List<Resource> resources;
  SortingAlgorithm({this.title, this.complexity, this.resources});
}

class Resource {
  String title, url;
  Resource(this.title, this.url);
}
