/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

import java.sql.Connection;
import java.util.List;
import javax.persistence.EntityManager;
import model.Musica;

/**
 *
 * @author jv
 */
public class musicDaoJPA implements InterfaceDao<Musica> {

    private Connection conn;

    @Override
    public void incluir(Musica entidade) throws Exception {
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
    public void excluir(Musica entidade) throws Exception {
               EntityManager em = ConnFactory.getEntityManager();
        try {
            em.getTransaction().begin();
            Musica c1 = em.find(Musica.class,entidade.getId());
            em.remove(c1);
            em.getTransaction().commit();
        } finally {
            em.close();
        }

    }

    @Override
    public void editar(Musica entidade) throws Exception {  
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
    public Musica pesquisarId(int id) throws Exception {
           throw new UnsupportedOperationException("Not supported yet.");        
    }

    @Override
    public List<Musica> listar() throws Exception {
        List<Musica> ListMusicas;
        EntityManager em = ConnFactory.getEntityManager();
        try {
            em.getTransaction().begin();
            ListMusicas = em.createQuery("From Musica c").getResultList();
            em.getTransaction().commit();
        } finally {
            em.close();
        }
        return ListMusicas;
    }

}
