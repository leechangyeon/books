package kimgibeom.book.book.dao.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kimgibeom.book.book.domain.Book;
import kimgibeom.book.book.domain.BookImg;

public interface BookMap {
	Book getBook(String bookIsbn);

	List<Book> findBooks(String searchBookTitle);

	List<Book> getIsbns();

	int updateBookCnt(@Param("bookIsbn") String bookIsbn, @Param("orderBookCnt") int orderBookCnt);

	int addBook(Book book);

	int delBook(String bookIsbn);

	int modifyBook(@Param("bookIsbn") String bookIsbn, @Param("book") Book book);

	List<Book> searchBook(String title);

	int addBookImg(@Param("bookIsbn") String bookIsbn, @Param("bookImg") BookImg bookImg);
	
	BookImg getBookImgName(String bookIsbn);
	
	int modifyBookImgName(@Param("bookIsbn") String bookIsbn, @Param("bookImgName") String bookImgName);
}