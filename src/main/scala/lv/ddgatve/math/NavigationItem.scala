package lv.ddgatve.math

class NavigationItem(url:String, title:String, children:List[NavigationItem]) {
  def isInternal():Boolean = { !children.isEmpty }
  def getUrl():String = { url }
  def getTitle(): String = {title}

  
  
}

//object NavigationItem {
//    def readNavigationItems(root: scala.xml.Elem):List[NavigationItem] = {
//    val urls = ((root \ "item") map
//    { x => x.head.attribute("id").get(0).text }).toList
//    val titles = ((root \ "item") map
//    { x => x.head.attribute("title").get(0).text }).toList
////    val children = ((root \ "item") map
////    { x => readNavigationItems( (x \ "list").get(0)).toList
//
//    List()
//}