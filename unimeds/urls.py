"""unimeds URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.10/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url, include
from django.contrib import admin
from django.contrib.auth.views import login
from management.views import *

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^home/', home, name='home'),
    url(r'^about/', about, name='about'),
    url(r'^adminhome/', adminhome, name='adminhome'),
    url(r'^register/', register, name='register'),
    url(r'^login/', login, name='login'),
    url(r'^logout/', logout, name='logout'),
    url(r'^contact/', contact, name='contact'),
    url(r'^product/', product, name='product'),
    url(r'^product_baby/', product_baby, name='product_baby'),
    url(r'^product_pc/', product_pc, name='product_pc'),
    url(r'^product_medicine/', product_medicine, name='product_medicine'),
    url(r'^cart/', cart, name='cart'),
    url(r'^delcart/', delcart, name='delcart'),
    url(r'^addproduct/', addproduct, name='addproduct'),
    url(r'^editproduct/', editproduct, name='editproduct'),
    url(r'^updateproduct/', updateproduct, name='updateproduct'),
    url(r'^replaceproduct/', replaceproduct, name='replaceproduct'),
    url(r'^showreplaceprod/', showreplaceprod, name='showreplaceprod'),
    url(r'^update/', update, name='update'),
    url(r'^pay/', pay, name='pay'),
    url(r'^addwholeseller/', addwholeseller, name='addwholeseller'),
    url(r'^showwholeseller/', showwholeseller, name='showwholeseller'),
    url(r'^purchaserecords/', purchaserecords, name='purchaserecords'),
    url(r'^showsalerecord/', showsalerecord, name='showsalerecord')
]
