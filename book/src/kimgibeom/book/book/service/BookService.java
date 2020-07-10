package kimgibeom.book.book.service;

import java.util.List;

import kimgibeom.book.book.domain.Book;
import kimgibeom.book.book.domain.BookImg;

public interface BookService {
	Book findBook(String bookIsbn);

	List<Book> readIsbns();

	boolean modifyBookCnt(String bookIsbn, int orderBookCnt);

	List<Book> searchBooks(String searchBookTitle);

	boolean writeBook(Book book);

	boolean removeBook(String bookIsbn);

	boolean updateBook(String bookIsbn, Book book);

	List<Book> lookupBook(String title);

	int writeBookImg(String bookIsbn, BookImg bookImg);

	BookImg readBookImgName(String bookIsbn);

	boolean updateBookImgName(String bookIsbn, String bookImgName);
}