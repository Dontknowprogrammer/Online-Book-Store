package com.DAO;

import com.entity.User;
import java.util.List;

public interface UserDAO {
    boolean userRegister(User user);
    User authenticateUser(String email, String password);
    
    public boolean updateProfile(User us);
    User getUserById(int id);
    User getUserByEmail(String email);
    List<User> getAllUsers();
}
