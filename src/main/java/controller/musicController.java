/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Musica;
import model.dao.InterfaceDao;
import model.dao.daoFactory;

/**
 *
 * @author jv
 * 
 */

@MultipartConfig(fileSizeThreshold=1024*1024*2, 
maxFileSize=1024*1024*10, 
maxRequestSize=1024*1024*50)

public class musicController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   
    private boolean save(String path, Part file, PrintWriter documentOut) {
        InputStream in = null;
        OutputStream out = null;
        try {
            in = file.getInputStream();
            out = new FileOutputStream(new File(path));
            int read = 0;
            final byte[] bytes = new byte[1024];
            while ((read = in.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }
        } catch (Exception ex) {
             documentOut.println("<html><body><script>alert('Error: " + ex.getMessage() + " ');</script></body></html>");
        }
        
       return true;
    }
 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        RequestDispatcher rd = null;
        try (PrintWriter documentOut = response.getWriter()) {
            try {
                String nomeMusic = request.getParameter("txtMusic");
                String nomeAutor = request.getParameter("txtAutor");
                Part img = request.getPart("myfileIMG");
                Part music = request.getPart("myfileMP3");
                String pathImg = "../imagens/" + nomeMusic + ".jpg";
                String pathMusic = "../music/" + nomeMusic + ".mp3";
                if (save(pathImg, img, documentOut) && save(pathMusic, music, documentOut)) {        
                    try {               
                        InterfaceDao dao = daoFactory.novoMusicDao();
                        Musica musica = new Musica(nomeMusic, nomeAutor, pathImg, pathMusic);
                        dao.incluir(musica);
                        rd = request.getRequestDispatcher("indexPlayer.html");
                        rd.forward(request, response);
                    } catch (Exception ex) {
                        rd = request.getRequestDispatcher("error.jsp?error=" + ex.getMessage());
                        rd.forward(request, response);
                    }
                }
            } catch (Exception ex) {
                rd = request.getRequestDispatcher("error.jsp?error=" + ex.getMessage());
                rd.forward(request, response);
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
