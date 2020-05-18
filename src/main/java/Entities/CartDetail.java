package Entities;

import java.io.Serializable;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "cart_detail")
public class CartDetail implements Serializable {
	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name = "idCart", nullable = false)
	@EmbeddedId
	private Cart idCart;

	@ManyToOne
	@JoinColumn(name = "idProduct", nullable = false)
	@EmbeddedId
	private Product idProduct;

	private int quantity;

	public Cart getIdCart() {
		return idCart;
	}

	public void setIdCart(Cart idCart) {
		this.idCart = idCart;
	}

	public Product getIdProduct() {
		return idProduct;
	}

	public void setIdProduct(Product idProduct) {
		this.idProduct = idProduct;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

}
