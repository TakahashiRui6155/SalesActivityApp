package servlet;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DBConnection;
@WebServlet("/dbtest")
public class DBTestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html; charset=UTF-8");

        try (Connection con = DBConnection.getConnection()) {
            response.getWriter().println("データベース接続成功！");
        } catch (Exception e) {
            response.getWriter().println("データベース接続失敗<br>");
            response.getWriter().println(e.getMessage());
            e.printStackTrace();
        }
    }
}