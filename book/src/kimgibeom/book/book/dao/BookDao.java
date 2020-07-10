package kimgibeom.book.book.dao;

import java.util.List;

import kimgibeom.book.book.domain.Book;
import kimgibeom.book.book.domain.BookImg;

public interface BookDao {
	Book getBook(String bookIsbn);

	List<Book> getIsbns();

	int updateBookCnt(String bookIsbn, int orderBookCnt);

	List<Book> findBooks(String searchBookTitle);

	int addBook(Book book);

	int delBook(String bookIsbn);

	int modifyBook(String bookIsbn, Book book);

	List<Book> searchBook(String title);

	int addBookImg(String bookIsbn, BookImg bookImg);
	
	BookImg getBookImgName(String bookIsbn);
	
	int modifyBookImgName(String bookIsbn, String bookImgName);
}