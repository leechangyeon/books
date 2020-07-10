package kimgibeom.book.order.domain;

public class OrderBook {
	private int count;
	private String bookIsbn;

	public String getBookIsbn() {
		return bookIsbn;
	}

	public void setBookIsbn(String bookIsbn) {
		this.bookIsbn = bookIsbn;
	}

	public String toString() {
		return String.format("%d", count);
	}

	public OrderBook() {
	}

	public OrderBook(int count) {
		this.count = count;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
}