/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package mark.prac.mysql;

import mark.prac.Usuari;
import mark.prac.Objecte;
import mark.prac.Categoria;
import mark.prac.Subcategoria;

import com.mysql.jdbc.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author marks
 */
public class DBManager
{
    private String url = "jdbc:mysql://localhost:3306/practica_jsp?allowMultiQueries=true";
    private Connection con = null;
    
    public void connect()
    {
        try{
            Class.forName(("com.mysql.jdbc.Driver"));
            con = (Connection) DriverManager.getConnection(url,"root","");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void close()
    {
        try
        {
            if(con!=null)
            {
                con.close();
            }
        }
        catch (SQLException ex)
        {
            Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    //-----------------------------------------------------------------PART D'USUARIS-----------------------------------------------------------------//
    public List<Usuari> getUsuaris(){
        PreparedStatement st = null;
        List<Usuari> usuaris = new ArrayList<Usuari>();
        try{
            
            st = con.prepareStatement("select nick, mail, pswd, rol from usuaris;");
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                Usuari u = new Usuari();
                u.setNick(rs.getString("nick"));
                u.setMail(rs.getString("mail"));
                u.setPswd(rs.getString("pswd"));
                u.setRol(rs.getInt("rol"));
                usuaris.add(u);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return usuaris;
    }
    
    public Usuari getUsuari(String userMail)
    {
        PreparedStatement st = null;
        Usuari usuari = null;
        try{
            
            st = con.prepareStatement("select nick, mail, pswd, rol from usuaris where mail=?;");
            st.setString(1, userMail);
            
            ResultSet rs = st.executeQuery();
            if (rs.next()){
                usuari = new Usuari();
                usuari.setNick(rs.getString("nick"));
                usuari.setMail(rs.getString("mail"));
                usuari.setPswd(rs.getString("pswd"));
                usuari.setRol(rs.getInt("rol"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return usuari;
    }
    
    public boolean insertUsuari(Usuari u){
        try {
            String query = "insert into usuaris (nick, mail, pswd, rol) values (?,?,?,1)"; //1 perque sempre serán usuaris normals els autoregistrats
            PreparedStatement preparedStmt;
            preparedStmt = con.prepareStatement(query);
            preparedStmt.setString(1, u.getNick());
            preparedStmt.setString(2, u.getMail());
            preparedStmt.setString(3, u.getPswd());
            preparedStmt.execute();
            
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }
    
    public boolean updateUsuari(Usuari u){
        try {
            
            String query = "update usuaris set nick=?, pswd=?, rol=? where mail=?";
            PreparedStatement preparedStmt;
            preparedStmt = con.prepareStatement(query);
            
            preparedStmt.setString(1, u.getNick());
            preparedStmt.setString(2, u.getPswd());
            preparedStmt.setInt(3, u.getRol());   
            preparedStmt.setString(4, u.getMail());
            
            preparedStmt.execute();
            
            return true;
        } catch (SQLException ex) {
            return false;
        }
    }
    
    public boolean deleteUsuari(String userMail){
        try {
            String query = "delete from usuaris where mail=?";
            PreparedStatement preparedStmt;
            preparedStmt = con.prepareStatement(query);
            preparedStmt.setString(1, userMail);
            
            preparedStmt.execute();
            
            return true;
        } catch (SQLException ex) {
            return false;
        }        
    }
    //-----------------------------------------------------------------PART D'USUARIS-----------------------------------------------------------------//
    
    
    
    
    //-----------------------------------------------------------------PART D'OBJECTES-----------------------------------------------------------------//
    public List<Objecte> getObjectes(){
        PreparedStatement st = null;
        List<Objecte> objectes = new ArrayList<Objecte>();
        try{
            
            st = con.prepareStatement("select id, usuari, nom, descripcio, categoria, subcategoria, preu, img from objectes;");
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                Objecte o = new Objecte();
                o.setId(rs.getInt("id"));
                o.setUsuari(rs.getString("usuari"));
                o.setNom(rs.getString("nom"));
                o.setDescripcio(rs.getString("descripcio"));
                o.setCategoria(rs.getInt("categoria"));
                o.setSubcategoria(rs.getInt("subcategoria"));
                o.setPreu(rs.getBigDecimal("preu"));
                o.setImg(rs.getString("img"));
                objectes.add(o);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return objectes;
    }
    
    public List<Objecte> getObjectesUsuari(String usuari){
        PreparedStatement st = null;
        List<Objecte> objectes = new ArrayList<Objecte>();
        try{
            
            st = con.prepareStatement("select id, usuari, nom, descripcio, categoria, subcategoria, preu, img from objectes where usuari = ?;");
            st.setString(1, usuari);
            ResultSet rs = st.executeQuery();
            while(rs.next()){
                Objecte o = new Objecte();
                o.setId(rs.getInt("id"));
                o.setUsuari(rs.getString("usuari"));
                o.setNom(rs.getString("nom"));
                o.setDescripcio(rs.getString("descripcio"));
                o.setCategoria(rs.getInt("categoria"));
                o.setSubcategoria(rs.getInt("subcategoria"));
                o.setPreu(rs.getBigDecimal("preu"));
                o.setImg(rs.getString("img"));
                objectes.add(o);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return objectes;
    }
    //-----------------------------------------------------------------PART D'OBJECTES-----------------------------------------------------------------//
    
    
    
    
    //-----------------------------------------------------------------PART DE CATEGORIES-----------------------------------------------------------------//
    
    //-----------------------------------------------------------------PART DE CATEGORIES-----------------------------------------------------------------//
    
    
    
    
    //-----------------------------------------------------------------PART DE SUBCATEGORIES-----------------------------------------------------------------//
    
    //-----------------------------------------------------------------PART DE SUBCATEGORIES-----------------------------------------------------------------//
}
