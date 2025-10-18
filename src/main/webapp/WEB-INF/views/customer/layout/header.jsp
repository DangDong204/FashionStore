<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	
<%-- JSTL directive --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    

<style>
	.account-menu {
		position: relative;
		display: inline-block;
	}
	
	.account-toggle {
		color: #111;
		font-weight: 500;
		text-decoration: none;
		padding: 8px 10px;
		display: flex;
		align-items: center;
		gap: 6px;
	}
	
	.account-dropdown {
		display: none;
		position: absolute;
		top: 100%;
		right: 0;
		min-width: 160px;
		background: white;
		box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
		border-radius: 6px;
		z-index: 1000;
		padding: 5px 0;
		list-style: none;
	}
	
	.account-dropdown li {
		padding: 8px 16px;
	}
	
	.account-dropdown li a {
		color: #333;
		text-decoration: none;
		display: block;
		font-size: 14px;
	}
	
	.account-dropdown li a:hover {
		background-color: #f2f2f2;
	}
	
	/* Hover để mở dropdown */
	.account-menu:hover .account-dropdown {
		display: block;
	}
</style>

<!-- Header Section Begin -->
<header class="header">
    <div class="container-fluid">
        <div class="row">
            <div class="col-xl-3 col-lg-2">
                <div class="header__logo">
                    <a href="${env }/index"><img src="${env }/customer/img/logo.png" alt=""></a>
                </div>
            </div>
            <div class="col-xl-6 col-lg-7">
                <nav class="header__menu">
                    <ul>
                        <li class="active"><a href="${env }/index">Home</a></li>
                        <li><a href="#">Quần</a></li>
                        <li><a href="#">Áo</a></li>
                        <li><a href="${env }/shop">Shop</a></li>
                        <li><a href="#">Blog</a>
                            <ul class="dropdown">
                                <li><a href="#">Blog Details</a></li>
                                <li><a href="#">Blog Details</a></li>
                                <li><a href="#">Blog Details</a></li>
                            </ul>
                        </li>
                        <li><a href="${env }/checkout">Checkout</a></li>
                        <li><a href="${env }/contact">Contact</a></li>
                    </ul>
                </nav>
            </div>
            <div class="col-lg-3">
                <div class="header__right">
                    <div class="header__right__auth" style="position: relative;">
					    <c:choose>
					        <%-- Khi CHƯA đăng nhập --%>
					        <c:when test="${!isLogined}">
					            <div class="account-menu">
					                <a href="#" class="account-toggle">
					                    <i class="fa fa-user"></i> Tài khoản
					                    <i class="fa fa-angle-down"></i>
					                </a>
					                <ul class="account-dropdown">
					                    <li><a href="${env}/login">Đăng nhập</a></li>
					                    <li><a href="${env}/register">Đăng ký</a></li>
					                </ul>
					            </div>
					        </c:when>
					    
					        <%-- Khi ĐÃ đăng nhập --%>
					        <c:otherwise>
					            <div class="account-menu">
					                <a href="#" class="account-toggle">
					                    <i class="fa fa-user"></i> ${loginedUser.name}
					                    <i class="fa fa-angle-down"></i>
					                </a>
					                <ul class="account-dropdown">
					                    <li><a href="${env}/account">Thông tin tài khoản</a></li>
					                    <li><a href="${env}/logout">Đăng xuất</a></li>
					                </ul>
					            </div>
					        </c:otherwise>
					    </c:choose>
					</div>
					                    
                    <ul class="header__right__widget">
                        <li><span class="icon_search search-switch" id="searchIcon"></span></li>
                        <li><a href="#"><span class="icon_heart_alt"></span>
                            <div class="tip">2</div>
                        </a></li>
                        <li>
                        <a href="${env }/cart">
						    <span class="icon_bag_alt"></span>
						    <div class="tip" id="totalCartProducts">
						      ${totalCartProducts}
						    </div>
						  </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="canvas__open">
            <i class="fa fa-bars"></i>
        </div>
    </div>
</header>
<!-- Header Section End -->
