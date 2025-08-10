package org.exam.entity;

import java.math.BigDecimal;

public class Order {

    private Integer id;
    private String orderNo;
    private String name;
    private String img;
    private Integer userId;
    private Integer shopId;
    private Integer number;
    private String status;

    // 参考Pet类添加的关联字段（可选）
    private String shopName;
    private String userName;
    private BigDecimal price;

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // 关联字段的getter和setter
    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", orderNo=" + orderNo +
                ", name='" + name + '\'' +
                ", img='" + img + '\'' +
                ", userId=" + userId +
                ", shopId=" + shopId +
                ", number=" + number +
                ", status='" + status + '\'' +
                ", shopName='" + shopName + '\'' +
                ", userName='" + userName + '\'' +
                '}';
    }
}