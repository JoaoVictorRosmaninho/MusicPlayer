/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.dao;

/**
 *
 * @author jv
 */
public class daoFactory {

    public static userDaoJPA novoUserDao() throws Exception {
        return new userDaoJPA();
    }
     public static musicDaoJPA novoMusicDao() throws Exception {
        return new musicDaoJPA();
    }
}
