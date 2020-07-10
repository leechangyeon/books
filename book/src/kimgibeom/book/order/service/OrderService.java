package kimgibeom.book.order.service;

import java.util.List;

import kimgibeom.book.order.domain.Order;
import kimgibeom.book.order.domain.OrderBook;

public interface OrderService {
	boolean putOrder(String userId, Order order);

	List<Order> readOrder(String userId);

	int putOrderBook(int orderNum, String bookIsbn, OrderBook orderBook);

	boolean removeOrder(int orderNum);

	List<Order> readOrderInfos();

	List<Order> readUserOrderInfos(String userId);

	List<Order> findUserOrderInfos(String userId);

	int modifyOrderStatus(int orderNum);

	List<Order> readPayCompleteOrders();

	List<Order> readPayCompleteOrder(int orderNum);
}