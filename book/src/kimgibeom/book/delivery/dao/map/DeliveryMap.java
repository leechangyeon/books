package kimgibeom.book.delivery.dao.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kimgibeom.book.delivery.domain.Delivery;
import kimgibeom.book.order.domain.Order;

public interface DeliveryMap {
	List<Delivery> getDeliveryCompleteList();

	Delivery getDelivery(int orderNum);

	int addDelivery(@Param("orderNum") int orderNum, @Param("delivery") Delivery delivery);
	
	List<Delivery> searchUserDeliveryComplete(String userId);
	
	List<Delivery> searchUserPayComplete(String userId);
}
