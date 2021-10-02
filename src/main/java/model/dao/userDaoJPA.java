/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.Connection;
import java.util.List;
import javax.persistence.EntityManager;
import model.User;

/**
 *
 * @author jv
 */
public class userDaoJPA implements InterfaceDao<User> {

    private Connection conn;

    @Override
    public void incluir(User entidade) throws Exception {
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
    public void excluir(User entidade) throws Exception {
               EntityManager em = ConnFactory.getEntityManager();
        try {
            em.getTransaction().begin();
            User c1 = em.find(User.class,entidade.getId());
            em.remove(c1);
            em.getTransaction().commit();
        } finally {
            em.close();
        }

    }

    @Override
    public void editar(User entidade) throws Exception {  
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
    public User pesquisarId(int id) throws Exception {
           throw new UnsupportedOperationException("Not supported yet.");        
    }

    @Override
    public List<User> listar() throws Exception {
        List<User> ListUsers;
        EntityManager em = ConnFactory.getEntityManager();
        try {
            em.getTransaction().begin();
            ListUsers = em.createQuery("From User c").getResultList();
            em.getTransaction().commit();
        } finally {
            em.close();
        }
        return ListUsers;
    }

}
