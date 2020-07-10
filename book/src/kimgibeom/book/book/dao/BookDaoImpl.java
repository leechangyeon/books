package kimgibeom.book.book.dao;

import java.util.List;

import kimgibeom.book.book.dao.map.BookMap;
import kimgibeom.book.book.domain.Book;
import kimgibeom.book.book.domain.BookImg;
import kimgibeom.book.config.Configuration;

public class BookDaoImpl implements BookDao {
	private BookMap bookMap;

	public BookDaoImpl() {
		this.bookMap = Configuration.getMapper(BookMap.class);
	}

	@Override
	public Book getBook(String bookIsbn) {
		return bookMap.getBook(bookIsbn);
	}

	@Override
	public List<Book> getIsbns() {
		return bookMap.getIsbns();
	}

	@Override
	public int updateBookCnt(String bookIsbn, int orderBookCnt) {
		return bookMap.updateBookCnt(bookIsbn, orderBookCnt);
	}
 
	@Override
	public List<Book> findBooks(String searchBookTitle) {
		return bookMap.findBooks(searchBookTitle);
	}

	@Override
	public int addBook(Book book) {
		return bookMap.addBook(book);
	}

	@Override
	public int delBook(String bookIsbn) {
		return bookMap.delBook(bookIsbn);
	}

	@Override
	public int modifyBook(String bookIsbn, Book book) {
		return bookMap.modifyBook(bookIsbn, book);
	}

	@Override
	public List<Book> searchBook(String title) {
		return bookMap.searchBook(title);
	}

	@Override
	public int addBookImg(String bookIsbn, BookImg bookImg) {
		return bookMap.addBookImg(bookIsbn, bookImg);
	}

	@Override
	public BookImg getBookImgName(String bookIsbn) {
		return bookMap.getBookImgName(bookIsbn);
	}

	@Override
	public int modifyBookImgName(String bookIsbn, String bookImgName) {
		return bookMap.modifyBookImgName(bookIsbn, bookImgName);
	}
}