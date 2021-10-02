/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;
import model.dao.InterfaceDao;
import model.dao.daoFactory;

/**
 *
 * @author jv
 */
public class userController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String login = request.getParameter("txtLogin");
        String senha = request.getParameter("txtSenha");
        String opcao = request.getParameter("opcao");
        RequestDispatcher rd = null;
        try {
            InterfaceDao dao = daoFactory.novoUserDao();
            if (opcao.equals("login")) {
                List<User> usuarios = dao.listar();
                for (User user : usuarios) {
                    if (user.getLogin().equals(login) && user.getSenha().equals(senha)) {
                        rd = request.getRequestDispatcher("indexPlayer.html");
                        rd.forward(request, response);
                    } else {
                        response.getWriter().write("<html><body><script>alert('Usuario ou Senha Inválidos');</script></body></html>");
                    }
                }
            } else if (opcao.equals("cadastrar")) {
                String senhaConfirm = request.getParameter("txtSenhaConfirm");
                if (!senha.equals(senhaConfirm)) {
                    response.getWriter().write("<html><body><script>alert('As senhas nao coincidem: " + senha + " " + senhaConfirm + "');</script></body></html>");
                } else {
                    User user = new User(login, senha);
                    dao.incluir(user);
                    rd = request.getRequestDispatcher("indexPlayer.html");
                    rd.forward(request, response);
                }
            }
        } catch (Exception ex) {
            rd = request.getRequestDispatcher("error.jsp?error=" + ex.getMessage());
            rd.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
