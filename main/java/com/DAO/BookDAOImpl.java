 package com.DAO;

import com.DB.DBConnect;
import com.entity.BookDtls;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDAOImpl implements BookDAO {
    private Connection conn;

    public BookDAOImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public boolean addBooks(BookDtls book) {
        String sql = "INSERT INTO book_dtls(bookName, author, price, bookCategory, status, photo, email) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, book.getBookName());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getPrice());
            ps.setString(4, book.getBookCategory());
            ps.setString(5, book.getStatus());
            ps.setString(6, book.getPhotoName());
            ps.setString(7, book.getEmail());

            int i = ps.executeUpdate();
            return i == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<BookDtls> getAllBooks() {
        List<BookDtls> list = new ArrayList<>();
        String sql = "SELECT * FROM book_dtls";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                BookDtls book = new BookDtls();
                book.setBookId(rs.getInt("bookId"));
                book.setBookName(rs.getString("bookName"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(rs.getString("price"));
                book.setBookCategory(rs.getString("bookCategory"));
                book.setStatus(rs.getString("status"));
                book.setPhotoName(rs.getString("photo"));
                book.setEmail(rs.getString("email"));
                list.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public BookDtls getBookById(int bookId) {
        BookDtls book = null;
        String sql = "SELECT * FROM book_dtls WHERE bookId = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    book = new BookDtls();
                    book.setBookId(rs.getInt("bookId"));
                    book.setBookName(rs.getString("bookName"));
                    book.setAuthor(rs.getString("author"));
                    book.setPrice(rs.getString("price"));
                    book.setBookCategory(rs.getString("bookCategory"));
                    book.setStatus(rs.getString("status"));
                    book.setPhotoName(rs.getString("photo"));
                    book.setEmail(rs.getString("email"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return book;
    }

    @Override
    public boolean updateEditBooks(BookDtls book) {
        boolean status = false;
        try {
            // Update book details in the database using prepared statement
            String sql = "UPDATE book_dtls SET bookname=?, author=?, price=?, bookCategory=?, status=? WHERE bookId=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, book.getBookName());
            stmt.setString(2, book.getAuthor());
            stmt.setString(3, book.getPrice()); 
            stmt.setString(4, book.getBookCategory());
            stmt.setString(5, book.getStatus());
            stmt.setInt(6, book.getBookId());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                status = true; // Update successful
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
    @Override
    public boolean deleteBook(int bookId) {
        // Implementation to delete a book from the database
        boolean isSuccess = false;
        try {
            String query = "DELETE FROM book_dtls WHERE bookId = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, bookId);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isSuccess;
    }
    @Override
    public List<BookDtls> getAllActiveBooks() {
        List<BookDtls> activeBooks = new ArrayList<>();
        String sql = "SELECT * FROM book_dtls WHERE status = 'Active'";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                BookDtls book = new BookDtls();
                book.setBookId(rs.getInt("bookId"));
                book.setBookName(rs.getString("bookName"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(rs.getString("price"));
                book.setBookCategory(rs.getString("bookCategory"));
                book.setStatus(rs.getString("status"));
                book.setPhotoName(rs.getString("photo"));
                book.setEmail(rs.getString("email"));
                activeBooks.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return activeBooks;
    }

	@Override
	public List<BookDtls> getBookBySearch(String ch) {
		 List<BookDtls> searchResults = new ArrayList<>();
		    String sql = "SELECT * FROM book_dtls WHERE bookName LIKE ? OR author LIKE ? OR bookCategory LIKE? and status=?";
		    try (PreparedStatement ps = conn.prepareStatement(sql)) {
		        // Set the search query in the prepared statement
		        ps.setString(1, "%" + ch + "%");
		        ps.setString(2, "%" + ch + "%");
		        ps.setString(3, "%" + ch + "%");
		        ps.setString(4, "Active");
		        // Execute the query
		        try (ResultSet rs = ps.executeQuery()) {
		            while (rs.next()) {
		                BookDtls book = new BookDtls();
		                book.setBookId(rs.getInt("bookId"));
		                book.setBookName(rs.getString("bookName"));
		                book.setAuthor(rs.getString("author"));
		                book.setPrice(rs.getString("price"));
		                book.setBookCategory(rs.getString("bookCategory"));
		                book.setStatus(rs.getString("status"));
		                book.setPhotoName(rs.getString("photo"));
		                book.setEmail(rs.getString("email"));
		                searchResults.add(book);
		            }
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return searchResults;
	}
	@Override
	public List<BookDtls> getBookByCategory(String category) {
	    List<BookDtls> categoryBooks = new ArrayList<>();
	    String sql = "SELECT * FROM book_dtls WHERE bookCategory = ? AND status = 'Active'";
	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, category);
	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                BookDtls book = new BookDtls();
	                book.setBookId(rs.getInt("bookId"));
	                book.setBookName(rs.getString("bookName"));
	                book.setAuthor(rs.getString("author"));
	                book.setPrice(rs.getString("price"));
	                book.setBookCategory(rs.getString("bookCategory"));
	                book.setStatus(rs.getString("status"));
	                book.setPhotoName(rs.getString("photo"));
	                book.setEmail(rs.getString("email"));
	                categoryBooks.add(book);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return categoryBooks;
	}
	public List<String> getAllBookCategories() {
	    List<String> categories = new ArrayList<>();
	    String sql = "SELECT DISTINCT bookCategory FROM book_dtls";
	    try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
	        while (rs.next()) {
	            String category = rs.getString("bookCategory");
	            categories.add(category);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return categories;
	}


}
