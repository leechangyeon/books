package kimgibeom.book.delivery.dao;

import java.util.List;

import kimgibeom.book.delivery.domain.Delivery;

public interface DeliveryDao {
	List<Delivery> getDeliveryCompleteList();

	Delivery getDelivery(int orderNum);

	int addDelivery(int orderNum, Delivery delivery);

	List<Delivery> searchUserDeliveryComplete(String userId);
	
	List<Delivery> searchUserPayComplete(String userId);
}
