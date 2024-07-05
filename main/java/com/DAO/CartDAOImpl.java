package com.DAO;

import com.entity.BookDtls;
import com.entity.Cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDAOImpl implements CartDAO {
    private Connection conn;

    public CartDAOImpl(Connection conn) {
        this.conn = conn;
    }

    public boolean addCart(Cart c) {
        boolean f = false;
        try {
            String sql = "INSERT INTO cart(bid, uid, bookName, author, price, total_price) VALUES (?, ?, ?, ?, ?, ?)";

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, c.getBid());
                ps.setInt(2, c.getUserId());
                ps.setString(3, c.getBookName());
                ps.setString(4, c.getAuthor());
                ps.setDouble(5, c.getPrice());
                ps.setDouble(6, c.getTotal_price());

                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    f = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public List<Cart> getBookByUser(int userId) {
        List<Cart> list=new ArrayList<Cart>();
    	Cart c=null;
        double totalPrice=0;
        try {
            String sql = "SELECT * FROM cart WHERE uid=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);

               
                ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        c = new Cart();
                        c.setCid(rs.getInt(1));
                        c.setBid(rs.getInt(2));
                        c.setUserId(rs.getInt(3));
                        c.setBookName(rs.getString(4));
                        c.setAuthor(rs.getString(5));
                        c.setPrice(rs.getDouble(6));
                        totalPrice=totalPrice+rs.getDouble(7);
                        c.setTotal_price(totalPrice);
                        
                        list.add(c);
                    }
                
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

	@Override
	public boolean deleteBook(int bid,int uid) {
		boolean f=false;
		try {
			String sql="delete from cart where bid=? and uid=?";
			PreparedStatement ps=conn.prepareStatement(sql);
			ps.setInt(1, bid);
			ps.setInt(2, uid);
			int i=ps.executeUpdate();
			} 
	catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
    
}
