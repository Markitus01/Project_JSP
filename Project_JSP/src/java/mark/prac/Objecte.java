/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package mark.prac;

import java.math.BigDecimal;
import java.util.Objects;

/**
 *
 * @author marks
 */
public class Objecte {
    private int id;
    private String usuari;
    private String nom;
    private String descripcio;
    private int categoria;
    private int subcategoria;
    private BigDecimal preu;
    private String img;

    public Objecte(String usuari, String nom, String descripcio, int categoria, int subcategoria, BigDecimal preu, String img) {
        this.usuari = usuari;
        this.nom = nom;
        this.descripcio = descripcio;
        this.categoria = categoria;
        this.subcategoria = subcategoria;
        this.preu = preu;
        this.img = img;
    }

    public String getUsuari() {
        return usuari;
    }

    public String getNom() {
        return nom;
    }

    public String getDescripcio() {
        return descripcio;
    }

    public int getCategoria() {
        return categoria;
    }

    public int getSubcategoria() {
        return subcategoria;
    }

    public BigDecimal getPreu() {
        return preu;
    }

    public String getImg() {
        return img;
    }

    public void setUsuari(String usuari) {
        this.usuari = usuari;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setDescripcio(String descripcio) {
        this.descripcio = descripcio;
    }

    public void setCategoria(int categoria) {
        this.categoria = categoria;
    }

    public void setSubcategoria(int subcategoria) {
        this.subcategoria = subcategoria;
    }

    public void setPreu(BigDecimal preu) {
        this.preu = preu;
    }

    public void setImg(String img) {
        this.img = img;
    }
    
    @Override
    public int hashCode() {
        int hash = 3;
        hash = 11 * hash + this.id;
        hash = 11 * hash + Objects.hashCode(this.usuari);
        hash = 11 * hash + Objects.hashCode(this.nom);
        hash = 11 * hash + Objects.hashCode(this.descripcio);
        hash = 11 * hash + this.categoria;
        hash = 11 * hash + this.subcategoria;
        hash = 11 * hash + Objects.hashCode(this.preu);
        hash = 11 * hash + Objects.hashCode(this.img);
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
        final Objecte other = (Objecte) obj;
        if (this.id != other.id) {
            return false;
        }
        if (this.categoria != other.categoria) {
            return false;
        }
        if (this.subcategoria != other.subcategoria) {
            return false;
        }
        if (!Objects.equals(this.usuari, other.usuari)) {
            return false;
        }
        if (!Objects.equals(this.nom, other.nom)) {
            return false;
        }
        if (!Objects.equals(this.descripcio, other.descripcio)) {
            return false;
        }
        if (!Objects.equals(this.img, other.img)) {
            return false;
        }
        return Objects.equals(this.preu, other.preu);
    }
}
