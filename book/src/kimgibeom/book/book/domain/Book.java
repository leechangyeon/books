package kimgibeom.book.book.domain;

import java.util.List;

public class Book {
	private String bookIsbn;
	private String title;
	private String writer;
	private String publisher;
	private String content;
	private int price;
	private int count;
	private int cartNum;
	private List<String> bookIsbns;

	public Book() {

	}

	public Book(String bookIsbn, String title, String writer, String publisher, String content, int price, int count) {
		this.bookIsbn = bookIsbn;
		this.title = title;
		this.writer = writer;
		this.publisher = publisher;
		this.content = content;
		this.price = price;
		this.count = count;
	}

	public String getBookIsbn() {
		return bookIsbn;
	}

	public String getTitle() {
		return title;
	}

	public String getWriter() {
		return writer;
	}

	public String getPublisher() {
		return publisher;
	}

	public String getContent() {
		return content;
	}

	public int getPrice() {
		return price;
	}

	public int getCount() {
		return count;
	}

	public int getCartNum() {
		return cartNum;
	}

	public void setCartNum(int cartNum) {
		this.cartNum = cartNum;
	}

	public List<String> getBookIsbns() {
		return bookIsbns;
	}

	public void setBookIsbns(List<String> bookIsbns) {
		this.bookIsbns = bookIsbns;
	}

	public void setBookIsbn(String bookIsbn) {
		this.bookIsbn = bookIsbn;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public void setCount(int count) {
		this.count = count;
	}
}