package Entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "product")
public class Product implements Serializable, Comparable<Product> {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "idProduct", nullable = false)
	private int idProduct;

	@Column(name = "productName", nullable = false)
	private String productName;

	@Column(name = "price", nullable = false)
	private int price;

	@Column(name = "image", nullable = false)
	private String image;

	@ManyToOne
	@JoinColumn(name = "idCategory", nullable = false)
	private Category idCategory;

	@Override
	public String toString() {
		return "Product [idProduct=" + idProduct + ", productName=" + productName + ", price=" + price + ", image="
				+ image + ", idCategory=" + idCategory + "]";
	}

	public int getIdProduct() {
		return idProduct;
	}

	public void setIdProduct(int idProduct) {
		this.idProduct = idProduct;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Category getIdCategory() {
		return idCategory;
	}

	public void setIdCategory(Category idCategory) {
		this.idCategory = idCategory;
	}

	@Override
	public int compareTo(Product o) {
		return this.idProduct - o.idProduct;
	}

}
