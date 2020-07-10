package kimgibeom.book.book.service;

import java.util.List;

import kimgibeom.book.book.dao.BookDao;
import kimgibeom.book.book.dao.BookDaoImpl;
import kimgibeom.book.book.domain.Book;
import kimgibeom.book.book.domain.BookImg;

public class BookServiceImpl implements BookService {
	private BookDao bookDao;

	public BookServiceImpl() {
		this.bookDao = new BookDaoImpl();
	}

	@Override
	public Book findBook(String bookIsbn) {
		return bookDao.getBook(bookIsbn);
	}

	@Override
	public List<Book> readIsbns() {
		return bookDao.getIsbns();
	}

	@Override
	public boolean modifyBookCnt(String bookIsbn, int orderBookCnt) {
		return bookDao.updateBookCnt(bookIsbn, orderBookCnt) > 0;
	}

	@Override
	public List<Book> searchBooks(String searchBookTitle) {
		return bookDao.findBooks(searchBookTitle);
	}

	@Override
	public boolean writeBook(Book book) {
		return bookDao.addBook(book) > 0;
	}

	@Override
	public boolean removeBook(String bookIsbn) {
		return bookDao.delBook(bookIsbn) > 0;
	}

	@Override
	public boolean updateBook(String bookIsbn, Book book) {
		return bookDao.modifyBook(bookIsbn, book) > 0;
	}

	@Override
	public List<Book> lookupBook(String title) {
		return bookDao.searchBook(title);
	}

	@Override
	public int writeBookImg(String bookIsbn, BookImg bookImg) {
		return bookDao.addBookImg(bookIsbn, bookImg);
	}

	@Override
	public BookImg readBookImgName(String bookIsbn) {
		return bookDao.getBookImgName(bookIsbn);
	}

	@Override
	public boolean updateBookImgName(String bookIsbn, String bookImgName) {
		return bookDao.modifyBookImgName(bookIsbn, bookImgName)>0;
	}
}