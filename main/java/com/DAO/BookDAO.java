package com.DAO;
import com.entity.BookDtls;
import java.util.List; 
public interface BookDAO {
public boolean addBooks(BookDtls book);
public List<BookDtls> getAllBooks();
BookDtls getBookById(int bookId);
public boolean updateEditBooks(BookDtls book);
boolean deleteBook(int bookId);
List<BookDtls> getAllActiveBooks();
public List<BookDtls> getBookBySearch(String ch);
public List<BookDtls> getBookByCategory(String category);
public List<String> getAllBookCategories();
}
