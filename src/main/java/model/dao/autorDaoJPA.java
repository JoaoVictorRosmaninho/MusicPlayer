/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.Connection;
import java.util.List;
import javax.persistence.EntityManager;
import model.Autor;

/**
 *
 * @author jv
 */
public class autorDaoJPA implements InterfaceDao<Autor> {

    private Connection conn;

    @Override
    public void incluir(Autor entidade) throws Exception {
         EntityManager em = ConnFactory.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(entidade); // Incluir
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    @Override
    public void excluir(Autor entidade) throws Exception {
               EntityManager em = ConnFactory.getEntityManager();
        try {
            em.getTransaction().begin();
            Autor c1 = em.find(Autor.class,entidade.getId());
            em.remove(c1);
            em.getTransaction().commit();
        } finally {
            em.close();
        }

    }

    @Override
    public void editar(Autor entidade) throws Exception {  
        EntityManager em = ConnFactory.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(entidade); // Incluir
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    @Override
    public Autor pesquisarId(int id) throws Exception {
           throw new UnsupportedOperationException("Not supported yet.");        
    }

    @Override
    public List<Autor> listar() throws Exception {
        List<Autor> ListAutors;
        EntityManager em = ConnFactory.getEntityManager();
        try {
            em.getTransaction().begin();
            ListAutors = em.createQuery("From Contato c").getResultList();
            em.getTransaction().commit();
        } finally {
            em.close();
        }
        return ListAutors;
    }

}
