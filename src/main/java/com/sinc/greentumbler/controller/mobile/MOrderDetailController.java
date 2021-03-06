package com.sinc.greentumbler.controller.mobile;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sinc.greentumbler.service.OrderService;
import com.sinc.greentumbler.vo.OrderDetailVO;
import com.sinc.greentumbler.vo.OrderVO;
import com.sinc.greentumbler.vo.RecentOrderVO;

@Controller
@RequestMapping("/mobile/orderDetails")
public class MOrderDetailController {
	
	@Resource(name="orderService")
	OrderService orderService;
	
	@RequestMapping(value="/getOrder/{orderId}", method=RequestMethod.POST)
	@ResponseBody
	public OrderVO getOrder(@PathVariable int orderId) {
		OrderVO order = orderService.selectOneOrder(orderId);
		List<OrderDetailVO> recentOrders = orderService.selectOrderListWithOrderId(orderId);
		order.setOrderList(recentOrders);
		return order;
	}
	
	@RequestMapping(value="/getOrderDetails/accounts/{accountId}", method=RequestMethod.POST)
	@ResponseBody
	public Object getOrderDetailsWithAccountId(@PathVariable String accountId) {
		System.out.println(accountId);
		List<RecentOrderVO> recentOrders = orderService.selectOrderListWithAccountId(accountId);
		
		return recentOrders;
	}
	
	@RequestMapping(value="/getOrderDetails/tumblers/{tumblerId}", method=RequestMethod.POST)
	@ResponseBody
	public Object getOrderDetailsWithTumblerId(@PathVariable int tumblerId) {
		System.out.println(tumblerId);
		List<RecentOrderVO> recentOrders = orderService.selectOrderListWithTumblerId(tumblerId);
		
		return recentOrders;
	}
	
	public List<OrderDetailVO> getOrderDetailsWithOrderId(int orderId) {
		List<OrderDetailVO> recentOrders = orderService.selectOrderListWithOrderId(orderId);
		
		return recentOrders;
	}
}
