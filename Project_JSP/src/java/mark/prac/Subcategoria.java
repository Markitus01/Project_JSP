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
public class Subcategoria
{
    private int id;
    private String nom;
    private int pare;
    
    public Subcategoria(){}
    
    public Subcategoria(String nom, int pare) {
        this.nom = nom;
        this.pare = pare;
    }

    public int getId() {
        return id;
    }

    public String getNom() {
        return nom;
    }

    public int getPare() {
        return pare;
    }
    
    public void setId(int id)
    {
        this.id = id;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setPare(int pare) {
        this.pare = pare;
    }
    
    @Override
    public int hashCode() {
        int hash = 3;
        hash = 71 * hash + this.id;
        hash = 71 * hash + Objects.hashCode(this.nom);
        hash = 71 * hash + this.pare;
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
        if (this.pare != other.pare) {
            return false;
        }
        return Objects.equals(this.nom, other.nom);
    }
}
