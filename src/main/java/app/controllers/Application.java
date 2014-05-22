package controllers;

import java.util.List;

import models.Book;
import play.data.Form;
import play.db.ebean.Model;
import play.libs.Json;
import play.mvc.BodyParser;
import play.mvc.Controller;
import play.mvc.Result;
import views.html.index;


public class Application extends Controller {


	public static Result index() {
		return ok(index.render("Ai, aziti, murmuliti!"));
	}

	public static Result addBook() {
		Book book = Form.form(Book.class).bindFromRequest().get();
		book.save();
		return redirect(routes.Application.index()); 
	}
	


	/**
	* This is a documentation comment
	*/
	@BodyParser.Of(play.mvc.BodyParser.Json.class)
	public static Result getBooks() {
		List<Book> bookList = new Model.Finder<String, Book>(String.class,
				Book.class).all();
		return ok(Json.toJson(bookList));
	}
		

}
