package kimgibeom.book.order.dao.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kimgibeom.book.order.domain.Order;
import kimgibeom.book.order.domain.OrderBook;

public interface OrderMap {
	int addOrder(@Param("userId") String userId, @Param("order") Order order);

	List<Order> getOrder(String userId);

	int addOrderBook(@Param("orderNum") int orderNum, @Param("bookIsbn") String bookIsbn,
			@Param("orderBook") OrderBook orderBook);

	int delOrder(int orderNum);

	List<Order> getOrderInfos();

	List<Order> getUserOrderInfos(String userId);

	List<Order> searchUserOrderInfos(String userId);
	
	int updateOrderStatus(int orderNum);
	
	List<Order> getPayCompleteOrders();
	
	List<Order> getPayCompleteOrder(int orderNum);
}