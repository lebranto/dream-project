package com.kh.jipshop.dto;

public class CartDTO {

    private int cartId;
    private int productId;
    private String productName;
    private int productPrice;
    private String productPhoto1;
    private int cartQty;

    public CartDTO() {}

    public CartDTO(int productId, String productName, int productPrice, String productPhoto1) {
        this.productId = productId;
        this.productName = productName;
        this.productPrice = productPrice;
        this.productPhoto1 = productPhoto1;
        this.cartQty = 1;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(int productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductPhoto1() {
        return productPhoto1;
    }

    public void setProductPhoto1(String productPhoto1) {
        this.productPhoto1 = productPhoto1;
    }

    public int getCartQty() {
        return cartQty;
    }

    public void setCartQty(int cartQty) {
        this.cartQty = cartQty;
    }
}