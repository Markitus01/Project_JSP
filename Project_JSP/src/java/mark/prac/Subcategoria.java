/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package mark.prac;

import java.util.Objects;

/**
 *
 * @author marks
 */
public class Subcategoria{
    private int id;
    private String nom;
    private Categoria pare;
    
    public Subcategoria(String nom, Categoria pare) {
        this.nom = nom;
        this.pare = pare;
    }

    public int getId() {
        return id;
    }

    public String getNom() {
        return nom;
    }

    public Categoria getPare() {
        return pare;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setPare(Categoria pare) {
        this.pare = pare;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 89 * hash + this.id;
        hash = 89 * hash + Objects.hashCode(this.nom);
        hash = 89 * hash + Objects.hashCode(this.pare);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Subcategoria other = (Subcategoria) obj;
        if (this.id != other.id) {
            return false;
        }
        if (!Objects.equals(this.nom, other.nom)) {
            return false;
        }
        return Objects.equals(this.pare, other.pare);
    } 
}
