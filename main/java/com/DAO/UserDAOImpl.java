package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.entity.User;
import java.util.List; 
import java.util.ArrayList;
public class UserDAOImpl implements UserDAO {
    private Connection conn;

    public UserDAOImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public boolean userRegister(User user) {
        boolean f = false;
        try {
            String query = "INSERT INTO user (name, email, phno, password) VALUES (?, ?, ?, ?)";
            PreparedStatement pstmt = this.conn.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPhno());
            pstmt.setString(4, user.getPassword());

            pstmt.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public User authenticateUser(String email, String password) {
        User user = null;
        try {
            String query = "SELECT * FROM user WHERE email = ? AND password = ?";
            PreparedStatement pstmt = this.conn.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhno(rs.getString("phno"));
                user.setPassword("password");
                user.setAddress("address");
                user.setLandmark("landmark");
                user.setCity("city");
                user.setState("state");
                user.setPincode("pincode");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

   

    @Override
    public boolean updateProfile(User user) {
        boolean success = false;
        try {
            // Fetch existing user information
            User existingUser = getUserById(user.getId());
            if (existingUser != null) {
                // Update only the fields that are not null in the provided user object
                if (user.getName() != null) {
                    existingUser.setName(user.getName());
                }
                if (user.getEmail() != null) {
                    existingUser.setEmail(user.getEmail());
                }
                if (user.getPhno() != null) {
                    existingUser.setPhno(user.getPhno());
                }
                // Check if a new password is provided
                if (user.getPassword() != null && !user.getPassword().isEmpty()) {
                    existingUser.setPassword(user.getPassword());
                }
                // Execute the update query
                String query;
                if (user.getPassword() != null && !user.getPassword().isEmpty()) {
                    query = "UPDATE user SET name=?, email=?, phno=?, password=? WHERE id=?";
                } else {
                    query = "UPDATE user SET name=?, email=?, phno=? WHERE id=?";
                }
                PreparedStatement pstmt = this.conn.prepareStatement(query);
                pstmt.setString(1, existingUser.getName());
                pstmt.setString(2, existingUser.getEmail());
                pstmt.setString(3, existingUser.getPhno());
                if (user.getPassword() != null && !user.getPassword().isEmpty()) {
                    pstmt.setString(4, existingUser.getPassword());
                    pstmt.setInt(5, existingUser.getId());
                } else {
                    pstmt.setInt(4, existingUser.getId());
                }

                int rowsUpdated = pstmt.executeUpdate();
                if (rowsUpdated > 0) {
                    success = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }


    @Override
    public User getUserById(int id) {
        User user = null;
        try {
            String query = "SELECT * FROM user WHERE id = ?";
            PreparedStatement pstmt = this.conn.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhno(rs.getString("phno"));
                user.setPassword("password");
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

	@Override
	public User getUserByEmail(String email) {
		User user = null;
	    try {
	        String query = "SELECT * FROM user WHERE email = ?";
	        PreparedStatement pstmt = this.conn.prepareStatement(query);
	        pstmt.setString(1, email);

	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            user = new User();
	            user.setId(rs.getInt("id"));
	            user.setName(rs.getString("name"));
	            user.setEmail(rs.getString("email"));
	            user.setPhno(rs.getString("phno"));
	            user.setPassword(rs.getString("password"));
	            
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return user;
	}
	   @Override
	    public List<User> getAllUsers() {
	        List<User> userList = new ArrayList<>();
	        try {
	            String query = "SELECT * FROM user";
	            PreparedStatement pstmt = this.conn.prepareStatement(query);
	            ResultSet rs = pstmt.executeQuery();
	            while (rs.next()) {
	                User user = new User();
	                user.setId(rs.getInt("id"));
	                user.setName(rs.getString("name"));
	                user.setEmail(rs.getString("email"));
	                user.setPhno(rs.getString("phno"));
	                userList.add(user);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return userList;
	    }
    
}
