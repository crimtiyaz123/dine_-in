import 'package:dine_in/data/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];
  
  category.add(CategoryModel(
    id: "pizza",
    name: "Pizza",
    image: "images/pizza.png",
  ));
  
  category.add(CategoryModel(
    id: "burger",
    name: "Burger",
    image: "images/burger.png",
  ));
  
  category.add(CategoryModel(
    id: "sandwiches",
    name: "Sandwiches & Rolls",
    image: "images/sandwiche.png",
  ));
  
  category.add(CategoryModel(
    id: "chinese",
    name: "Chinese",
    image: "images/chinese.png",
  ));
  
  category.add(CategoryModel(
    id: "tea_snacks",
    name: "Tea & Snacks",
    image: "images/tea.png",
  ));
  
  category.add(CategoryModel(
    id: "maggi_pasta",
    name: "Maggi & Pasta",
    image: "images/maggi.png",
  ));
  
  category.add(CategoryModel(
    id: "desserts",
    name: "Desserts",
    image: "images/desserts.png",
  ));
  
  return category;
}