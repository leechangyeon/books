package kimgibeom.book.order.dao;

import java.util.List;

import kimgibeom.book.order.domain.Order;
import kimgibeom.book.order.domain.OrderBook;

public interface OrderDao {
	int addOrder(String userId, Order order);

	List<Order> getOrder(String userId);

	int addOrderBook(int orderNum, String bookIsbn, OrderBook orderBook);

	int delOrder(int orderNum);

	List<Order> getOrderInfos();

	List<Order> getUserOrderInfos(String userId);

	List<Order> searchUserOrderInfos(String userId);

	int updateOrderStatus(int orderNum);
	
	List<Order> getPayCompleteOrders();
	
	List<Order> getPayCompleteOrder(int orderNum);
}