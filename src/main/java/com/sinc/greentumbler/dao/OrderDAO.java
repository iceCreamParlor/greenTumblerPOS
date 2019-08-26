package com.sinc.greentumbler.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.sinc.greentumbler.vo.OrderDetailVO;
import com.sinc.greentumbler.vo.OrderVO;
import com.sinc.greentumbler.vo.RecentOrderVO;

@Service("orderDAO")
public class OrderDAO {
	@Resource(name="sqlSession")
	private SqlSession session;
	
	public OrderVO insertRow(OrderVO order) {
		return session.selectOne("com.sinc.greentumbler.order.insertRow", order);
	}
	
	public int insertOrderItem(OrderDetailVO od) {
		return session.insert("com.sinc.greentumbler.order.insertOrderItem", od);
	}
	// 최근 주문 정보 불러오기
	public RecentOrderVO selectOne(String account_id) {
		return session.selectOne("com.sinc.greentumbler.order.selectOne", account_id);
	}
	public List<RecentOrderVO> selectOrderList(String account_id) {
		return session.selectList("com.sinc.greentumbler.order.selectOrderList", account_id);
	}
	
}
