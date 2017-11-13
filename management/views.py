from django.shortcuts import render, render_to_response, get_object_or_404, redirect
from django.http import HttpResponseRedirect, HttpResponse
from django.contrib import messages
from django.contrib import auth
from django.contrib.auth.models import User
from django.views.decorators.csrf import csrf_protect
from django.core.urlresolvers import reverse
from django.db import connection, IntegrityError, transaction
from datetime import datetime, date
import datetime
import re
#mport MySQLdb
#db=MySQLdb.connect("127.0.0.1", "root", "cse7005061XYZ", "unimeds")
from django.db import connection as db
# Create your views here.
def home(request):
    if request.user.is_superuser:
        return render(request, 'adminhome.html')
    return render(request,'home.html')

def about(request):
    if request.user.is_superuser:
        return render(request, 'adminhome.html')
    return render(request,'about.html')

def adminhome(request):
    if not request.user.is_superuser:
        return render(request, 'home.html')
    return render(request,'adminhome.html')

def contact(request):
    return render(request,'contact.html')
@csrf_protect
def login(request):
    cursor=db.cursor()
    if request.user.is_authenticated():  # Check if user is already logged in

        # Check if user is admin or faculty member and direct to corresponding dashboard
        if request.user.is_superuser:
            return render(request,'adminhome.html')
        else:
            return render(request,'home.html')
    if request.POST:  # POST Method
        user_id = request.POST['user_id']
        password = request.POST['password']
        if user_id == '':
            return render(request, 'login.html')
        cursor.execute("SELECT * from auth_user where username='" + user_id + "';")
        data = cursor.fetchall()

        if data is not None:  # Check if user is registered
            user = auth.authenticate(username=user_id, password=password)  # Authenticates the username and password
            if user is not None:
                auth.login(request, user)  # Logs in
                if request.user.is_superuser:
                    return redirect('adminhome')
                else:
                    return redirect('home')
            else:  # User exists but password is incorrect
                messages.error(request, 'The username and password combination is incorrect.')
        else:
            messages.error(request, 'ID not registered.')  # User does not exist
    return render(request, 'login.html')
@csrf_protect
def logout(request):
    cursor=db.cursor()
    if request.user.is_authenticated():
        CustID=request.user.username
        query = "SELECT BatchNo,Quantity FROM cart WHERE CustID='%s'" % (CustID)
        cursor.execute(query)
        data = cursor.fetchall()
        for d in data:
            batchno=d[0]
            quantity = d[1]
            query = "DELETE FROM cart WHERE CustID='%s' and BatchNo=%d" % (CustID, batchno)
            cursor.execute(query)
            query = "UPDATE Batch_Details SET Curr_quantity=Curr_quantity+%d WHERE BatchNo=%d " % (quantity, batchno)
            cursor.execute(query)
            db.commit()
        auth.logout(request)
        messages.success(request, 'Successfully logged out.')
    return render(request, 'login.html')
@csrf_protect
def register(request):
    cursor=db.cursor()
    if request.user.is_authenticated():  # Check if user is already logged in

        # Check if user is admin or faculty member and direct to corresponding dashboard
        if request.user.is_superuser:
            return render(request,'adminhome.html')
        else:
            return render(request,'home.html')
    if request.user.username == '':
        flag=0
        if request.POST:
            flag=1
            user_id=request.POST["user_id"]
            name=request.POST["name"]
            password=request.POST["password"]
            dob=request.POST["dob"]
            email=request.POST["email"]
            apt_name=request.POST["apt_name"]
            street_name=request.POST["street_name"]
            city=request.POST["city"]
            state=request.POST["state"]
            zip=request.POST["zip"]
            phone=request.POST["phone"]

            query="SELECT * FROM Customer WHERE CustID='%s' "%(user_id)
            cursor.execute(query)
            data = cursor.fetchall()
            if data:
                messages.error(request, 'The Customer ID is already there try another ')
                return render(request, 'Register.html')
            else:
                user = User.objects.create_user(user_id, email, password)
                user.save()
                db.commit()

                query = "SELECT id FROM auth_user WHERE username='%s'" % (user_id)
                cursor.execute(query)
                id = cursor.fetchall()
                u_id=id[0][0]
                query="INSERT INTO Customer VALUES('%s','%s','%s','%s','%s','%s','%s','%s',%s,%s,%s)"%(user_id,name,dob,email,apt_name,street_name,city,state,zip,phone,u_id)
                cursor.execute(query)
                db.commit()
                messages.error(request, 'Successfully Registered; Login Now')
                return render(request,'login.html')
        return render(request,'Register.html')
@csrf_protect
def cart(request):
    if request.user.is_superuser:
        return render(request, 'adminhome.html')
    if not request.user.is_authenticated:
        messages.error(request, 'Kindly Login or Register')
        return render(request,'login.html')
    CustID=request.user.username
    cursor=db.cursor()
    if request.POST:
        batchno =int(request.POST["batchno"])
        quantity=int(request.POST["quantity"])
        page=request.POST["page"]
        #print "page", page
        query="SELECT * FROM Cart WHERE CustID='%s' and BatchNo=%d"%(CustID,batchno)
        cursor.execute(query)
        already_bought=cursor.fetchall()
        if already_bought:
            query="UPDATE Cart SET Quantity=Quantity+%d WHERE CustID='%s' and BatchNo=%d "%(quantity,CustID,batchno)
            cursor.execute(query)
            query = "UPDATE Batch_Details SET Curr_quantity=Curr_quantity-%d WHERE BatchNo=%d " %(quantity, batchno)
            cursor.execute(query)
            db.commit()
        else:
            query="INSERT INTO Cart VALUES('%s',%d,%d)"%(CustID,batchno,quantity)
            cursor.execute(query)
            query = "UPDATE Batch_Details SET Curr_quantity=Curr_quantity-%d WHERE BatchNo=%d " % (quantity, batchno)
            cursor.execute(query)
            db.commit()
        messages.success(request, "Added to Cart Successfully")
        return redirect(page)
    else:
        query="SELECT p.Name,p.Category,b.Retail_price ,c.Quantity,b.BatchNo \
              FROM Cart as c,Batch_Details as b,Product_details as p \
              WHERE c.CustID='%s' and c.BatchNo=b.BatchNo and b.Name=p.Name"%(CustID)
        cursor.execute(query)
        data=cursor.fetchall()
        if len(data) == 0:
            return render(request, "Empty.html")
        price=0
        class product:
            def __init__(self,data):
                self.name=data[0]
                self.category=data[1]
                self.price=data[2]
                self.quantity=data[3]
                self.batchno=data[4]
        products=[]
        for obj in data:
            price+=obj[2]*obj[3]
            products.append(product(obj))
        return render(request,'cart.html',{'products':products,'price':price})
@csrf_protect
def delcart(request):
    CustID=request.user.username
    cursor=db.cursor()
    if request.POST:
        batchno=int(request.POST["batchno"])
        query="SELECT Quantity FROM cart WHERE CustID='%s' and BatchNo=%d"%(CustID,batchno)
        cursor.execute(query)
        data=cursor.fetchall()
        quantity=data[0][0]
        query="DELETE FROM cart WHERE CustID='%s' and BatchNo=%d"%(CustID,batchno)
        cursor.execute(query)
        query = "UPDATE Batch_Details SET Curr_quantity=Curr_quantity+%d WHERE BatchNo=%d " % (quantity, batchno)
        cursor.execute(query)
        db.commit()
        messages.success(request, "Successfully deleted from cart")
        return redirect('cart')
@csrf_protect
def product(request):
    if request.user.is_superuser:
        return render(request, 'adminhome.html')
    cursor = db.cursor()
    cursor.execute("SELECT p.Name,p.Category,p.Mfg_by,p.Description,m.Salt,m.prescription,b.Retail_price,b.BatchNo,b.curr_quantity\
                     from Product_details as p,Medicine_Details as m,Batch_Details as b\
                      where p.MedID=m.MedID and b.Name=p.Name and b.curr_quantity>0")
    data=cursor.fetchall()
    if len(data)==0:
        return render(request,"Empty.html")
    class product:
        def __init__(self,data):
            self.name=data[0]
            self.category=data[1]
            self.mfg=data[2]
            self.desc= data[3]
            self.salt=data[4]
            if data[5]=='N':
                self.presc='Not Required'
            else:
                self.presc="Required"
            self.price=data[6]
            self.BatchNo=data[7]
            self.quantity=data[8]
    products=[]
    for obj in data:
        products.append(product(obj))
    return render(request, 'product.html', {'data': products})
@csrf_protect
def product_baby(request):
    if request.user.is_superuser:
        return render(request, 'adminhome.html')
    cursor = db.cursor()
    cursor.execute("SELECT p.Name,p.Category,p.Mfg_by,p.Description,m.Salt,m.prescription,b.Retail_price,b.BatchNo,b.curr_quantity\
                     from Product_details as p,Medicine_Details as m,Batch_Details as b\
                      where p.MedID=m.MedID and b.Name=p.Name and p.Category='Baby Products' and b.curr_quantity>0 ")
    data=cursor.fetchall()
    if len(data)==0:
        return render(request,"Empty.html")
    class product:
        def __init__(self,data):
            self.name=data[0]
            self.category=data[1]
            self.mfg=data[2]
            self.desc= data[3]
            self.salt=data[4]
            if data[5]=='N':
                self.presc='Not Required'
            else:
                self.presc="Required"
            self.price=data[6]
            self.BatchNo = data[7]
            self.quantity = data[8]
    products=[]
    for obj in data:
        products.append(product(obj))
    return render(request, 'babyproducts.html', {'data': products})
@csrf_protect
def product_pc(request):
    if request.user.is_superuser:
        return render(request, 'adminhome.html')
    cursor = db.cursor()
    cursor.execute("SELECT p.Name,p.Category,p.Mfg_by,p.Description,m.Salt,m.prescription,b.Retail_price,b.BatchNo,b.curr_quantity\
                     from Product_details as p,Medicine_Details as m,Batch_Details as b\
                      where p.MedID=m.MedID and b.Name=p.Name and  p.Category='Personal Care' and b.curr_quantity>0 ")
    data=cursor.fetchall()
    if len(data)==0:
        return render(request,"Empty.html")
    class product:
        def __init__(self,data):
            self.name=data[0]
            self.category=data[1]
            self.mfg=data[2]
            self.desc= data[3]
            self.salt=data[4]
            if data[5]=='N':
                self.presc='Not Required'
            else:
                self.presc="Required"
            self.price=data[6]
            self.BatchNo = data[7]
            self.quantity = data[8]
    products=[]
    for obj in data:
        products.append(product(obj))
    return render(request, 'PCProducts.html', {'data': products})
@csrf_protect
def product_medicine(request):
    if request.user.is_superuser:
        return render(request, 'adminhome.html')
    cursor = db.cursor()
    cursor.execute("SELECT p.Name,p.Category,p.Mfg_by,p.Description,m.Salt,m.prescription,b.Retail_price,b.BatchNo,b.curr_quantity\
                     from Product_details as p,Medicine_Details as m,Batch_Details as b\
                      where p.MedID=m.MedID and b.Name=p.Name and  p.Category='Medicine' and b.curr_quantity>0")
    data=cursor.fetchall()
    if len(data)==0:
        return render(request,"Empty.html")
    class product:
        def __init__(self,data):
            self.name=data[0]
            self.category=data[1]
            self.mfg=data[2]
            self.desc= data[3]
            self.salt=data[4]
            if data[5]=='N':
                self.presc='Not Required'
            else:
                self.presc="Required"
            self.price=data[6]
            self.BatchNo = data[7]
            self.quantity = data[8]
    products=[]
    for obj in data:
        products.append(product(obj))
    return render(request, 'Medicines.html', {'data': products})
@csrf_protect
def addproduct(request):
    if not request.user.is_superuser:
        return render(request,'login.html')
    cursor=db.cursor()
    if request.POST:
        name=request.POST["name"]
        mfg_by=request.POST["mfg_by"]
        description=request.POST["desc"]
        medid=request.POST["medid"]
        category=request.POST["category"]
        salt=request.POST["salt"]
        presc=request.POST["prescription"]
        wholeprice=request.POST["whole_price"]
        retailprice=request.POST["retail_price"]
        mfg_date=request.POST["mfg_date"]
        exp_date=request.POST["exp_date"]
        quantity=request.POST["quantity"]
        prid=request.POST["prid"]
        wsid=request.POST["wsid"]
        p_date=request.POST["p_date"]
        W_name=request.POST["W_name"]
        W_addr=request.POST["W_addr"]
        W_email=request.POST["W_email"]
        W_phone=request.POST["W_phone"]
        t_price=request.POST["total_price"]
        t_quantity=request.POST["total_quantity"]
        cid=request.POST["cid"]
        shelfid=request.POST["shelfid"]


        print mfg_date

        query="SELECT * FROM Medicine_Details WHERE MedID='%s'"%(medid)
        cursor.execute(query)
        data=cursor.fetchall()
        if not data:
            query="INSERT INTO Medicine_Details VALUES('%s','%s','%s')"%(medid,salt,presc)
            cursor.execute(query)

        query="SELECT * FROM Product_Details WHERE Name='%s'"%(name)
        cursor.execute(query)
        data=cursor.fetchall()
        if not data:
            query="INSERT INTO Product_Details VALUES('%s','%s',%s,%s,'%s','%s','%s')"\
                  %(name,category,cid,shelfid,mfg_by,str(description),medid)
            cursor.execute(query)
            query = "SELECT * FROM Compartment WHERE CID=%s and ShelfNo=%s" % (cid, shelfid)
            cursor.execute(query)
            data = cursor.fetchall()
            if not data:
                query = "INSERT INTO Compartment VALUES(%s,%s)" % (cid, shelfid)
                cursor.execute(query)

        query = "SELECT * FROM WholeSeller WHERE WSID=%s" %(wsid)
        cursor.execute(query)
        data = cursor.fetchall()
        if not data:
            query = "INSERT INTO WholeSeller VALUES(%s,'%s','%s','%s',%s)" \
                    % (wsid,W_name,W_addr,W_email,W_phone)
            cursor.execute(query)

        query="SELECT * FROM Purchase_Record WHERE PRID=%s"%(prid)
        cursor.execute(query)
        data = cursor.fetchall()
        if not data:
            query="INSERT INTO Purchase_Record VALUES(%s,%s,'%s',%s,%s)"%(prid,wsid,p_date,t_price,t_quantity)
            cursor.execute(query)

        query="INSERT INTO Batch_Details(Name,Whole_price,Retail_price,Mfg_date,\
                Exp_date,Curr_quantity,PRID) VALUES('%s',%s,%s,'%s','%s',%s,%s)"\
              %(name,wholeprice,retailprice,mfg_date,exp_date,quantity,prid)
        cursor.execute(query)
        db.commit()
        messages.success(request, "Successfully added product")
        return redirect('addproduct')
    else:
        return render(request,'addproduct.html')

@csrf_protect
def editproduct(request):
    if not request.user.is_superuser:
        return render(request,'login.html')
    cursor=db.cursor()
    if request.POST:
        batchno=request.POST["batchno"]
        query="SELECT * FROM Repl_Record WHERE BatchNo='%s'"%(batchno)
        cursor.execute(query)
        data=cursor.fetchall()
        if data:
            messages.success(request, "Product Currently in replacement")
            return redirect('editproduct')
        query="DELETE FROM Batch_Details WHERE BatchNo=%s"%(batchno)
        cursor.execute(query)
        db.commit()
        messages.success(request, "Successfully deleted product")
        return redirect('editproduct')

    cursor.execute("SELECT p.Name,p.Category,p.Mfg_by,p.Description,m.Salt,m.prescription,b.Retail_price,b.BatchNo,b.curr_quantity,p.CID,p.ShelfNo,b.Exp_date\
                         from Product_details as p,Medicine_Details as m,Batch_Details as b\
                          where p.MedID=m.MedID and b.Name=p.Name")
    data = cursor.fetchall()

    class product:
        def __init__(self, data):
            self.name = data[0]
            self.category = data[1]
            self.mfg = data[2]
            self.desc =data[3]
            self.salt = data[4]
            if data[5] == 'N':
                self.presc = 'Not Required'
            else:
                self.presc = "Required"
            self.price = data[6]
            self.BatchNo = data[7]
            self.quantity = data[8]
            self.cid=data[9]
            self.shelfno=data[10]
            self.exp_date=data[11]

    products = []
    for obj in data:
        products.append(product(obj))
    return render(request, 'editproduct.html', {'data': products})
@csrf_protect
def updateproduct(request):
    if not request.user.is_superuser:
        return render(request,'login.html')
    cursor=db.cursor()
    if request.POST:
        batchno=request.POST["batchno"]
        query="SELECT p.Name,p.Category,p.Mfg_by,p.Description,m.Salt,m.prescription,b.Retail_price,b.BatchNo,b.curr_quantity,m.MedID\
                                    from Product_details as p,Medicine_Details as m,Batch_Details as b\
                                     where p.MedID=m.MedID and b.Name=p.Name and b.BatchNo=%s"%(batchno)
        cursor.execute(query)
        data = cursor.fetchall()
        if len(data) == 0:
            return render(request, "Empty.html")

        class product:
            def __init__(self, data):
                self.name = data[0]
                self.category = data[1]
                self.mfg = data[2]
                self.desc = data[3]
                self.salt = data[4]
                self.presc = data[5]
                self.price = data[6]
                self.BatchNo = data[7]
                self.quantity = data[8]
                self.medid=data[9]

        products = []
        for obj in data:
            products.append(product(obj))
        return render(request, 'updateproduct.html', {'data': products})
    else:
        return render(request,'editproduct.html')
@csrf_protect
def update(request):
    if not request.user.is_superuser:
        return render(request,'login.html')
    cursor=db.cursor()
    if request.POST:
        batchno=request.POST["batchno"]
        name=request.POST["name"]
        category=request.POST["category"]
        mfg=request.POST["mfg"]
        desc=request.POST["desc"]
        salt=request.POST["salt"]
        presc=request.POST["presc"]
        price=request.POST["price"]
        quantity=request.POST["quantity"]
        medid=request.POST["medid"]
        query="UPDATE Product_details SET Category='%s', Mfg_by='%s', Description='%s' WHERE NAME='%s'"%(category,mfg,desc,name)
        print query
        cursor.execute(query)

        query="UPDATE Medicine_Details SET Salt='%s', prescription='%s' WHERE MedID='%s'"%(salt,presc,medid)
        cursor.execute(query)

        query="Update Batch_Details SET Retail_price=%s,Curr_quantity=%s WHERE BatchNo=%s"%(price,quantity,batchno)
        cursor.execute(query)

        db.commit()
        messages.success(request, "Succefully Updated Details")
        return redirect('editproduct')
@csrf_protect
def addwholeseller(request):
    if not request.user.is_superuser:
        return render(request,'login.html')
    cursor=db.cursor()
    if request.POST:
        wsid = request.POST["wsid"]
        W_name = request.POST["W_name"]
        W_addr = request.POST["W_addr"]
        W_email = request.POST["W_email"]
        W_phone = request.POST["W_phone"]

        query="SELECT * FROM WholeSeller WHERE WSID=%s"%(wsid)
        cursor.execute(query)
        data=cursor.fetchall()
        if data:
            messages.success(request, "Please check ID WholeSeller Already there")
            return redirect('addwholeseller')
        else:
            query="INSERT INTO WholeSeller VALUES(%s,'%s','%s','%s','%s')"%(wsid,W_name,W_addr,W_email,W_phone)
            cursor.execute(query)
            db.commit()
            messages.success(request, "WholeSeller Added")
            return redirect('addwholeseller')
    else:
        return render(request,'addwholeseller.html')
@csrf_protect
def replaceproduct(request):
    if not request.user.is_superuser:
        return render(request,'login.html')
    cursor=db.cursor()
    date=datetime.datetime.now().date()
    if request.POST:
        batchno=request.POST["batchno"]
        query="SELECT b.Whole_Price,p.WSID,b.Curr_quantity FROM Batch_Details as b, Purchase_Record as p WHERE b.BatchNo=%s and b.PRID=p.PRID"%(batchno)
        cursor.execute(query)
        data=cursor.fetchall()
        print data
        price=data[0][0]
        wsid=data[0][1]
        quantity=data[0][2]

        query = "UPDATE Batch_Details SET Curr_quantity=0 WHERE BatchNo=%s" % (batchno)
        cursor.execute(query)

        query="INSERT INTO Repl_Record(BatchNo, WSID, Date, Price, Quantity) VALUES(%s,%s,'%s',%s,%s)"%(batchno,wsid,date,price,quantity)
        cursor.execute(query)
        db.commit()
        messages.success(request, "Added for Replacement")
        return redirect('editproduct')
@csrf_protect
def showreplaceprod(request):
    cursor=db.cursor()
    if not request.user.is_superuser:
        return render(request,'login.html')
    if request.POST:
        rrid=request.POST['rrid']
        print rrid
        query = "DELETE FROM Repl_Record WHERE RRID=%s" % (rrid)
        cursor.execute(query)
        db.commit()
        messages.success(request, "Successfully deleted replacement product")
        return redirect('showreplaceprod')
    cursor=db.cursor()
    query="SELECT p.Name,r.price,w.Name,w.Phone,r.Quantity,r.RRID FROM Product_Details as p,Batch_Details as b, Repl_Record as r, WholeSeller as w WHERE b.Name=p.Name and b.BatchNo=r.BatchNo and w.WSID=r.WSID"
    cursor.execute(query)
    data=cursor.fetchall()

    class rprod:
        def __init__(self,data):
            self.name=data[0]
            self.price=data[1]
            self.quantity=data[4]
            self.w_name=data[2]
            self.phone=data[3]
            self.rrid=data[5]
    products=[]
    for d in data:
        products.append(rprod(d))

    return render(request,'showreplaceprod.html',{'products':products})
@csrf_protect
def showwholeseller(request):
    if not request.user.is_superuser:
        return render(request,'login.html')
    cursor=db.cursor()
    query="SELECT * FROM WholeSeller"
    cursor.execute(query)
    data=cursor.fetchall()
    class seller:
        def __init__(self,data):
            self.wsid=data[0]
            self.name=data[1]
            self.email=data[3]
            self.addr=data[2]
            self.phone=data[4]

    sellers=[]
    for d in data:
        sellers.append(seller(d))

    return render(request,'showwholeseller.html',{'data':sellers})
@csrf_protect
def purchaserecords(request):
    if not request.user.is_superuser:
        return render(request,'login.html')
    cursor=db.cursor()
    query="SELECT p.PRID,p.date,p.Tprice,p.Quantity,w.Name FROM Purchase_Record as p, WholeSeller as w WHERE p.WSID=w.WSID"
    cursor.execute(query)
    data=cursor.fetchall()
    class record:
        def __init__(self,data):
            self.prid=data[0]
            self.date=data[1]
            self.tprice=data[2]
            self.quantity=data[3]
            self.name=data[4]
    records=[]
    for d in data:
        records.append(record(d))

    return render(request,'purchaserecords.html',{'records':records})
@csrf_protect
def showsalerecord(request):
    if not request.user.is_superuser:
        return render(request, 'login.html')
    cursor = db.cursor()
    query = "SELECT p.SRID,p.date,p.Price,p.Quantity,c.Name,c.Apt_Name,c.Street_Name,c.City,c.State,c.Phone FROM Sale_Record as p, Customer as c WHERE p.CustID=c.CustID"
    cursor.execute(query)
    data = cursor.fetchall()

    class record:
        def __init__(self, data,products):
            self.srid = data[0]
            self.date = data[1]
            self.price = data[2]
            self.quantity = data[3]
            self.name = data[4]
            self.addr=data[5]+' , '+data[6]+' , '+data[7]+' , '+data[8]
            self.phone=data[9]
            self.products=products

    class product:
        def __init__(self,name,quantity):
            self.name=name
            self.quantity=quantity

    records = []
    for d in data:
        list=[]
        srid=d[0]
        query="SELECT BatchNo,Quantity FROM SR_Prod WHERE SRID=%s"%(srid)
        cursor.execute(query)
        products = cursor.fetchall()
        for prod in products:
            batchno=prod[0]
            quantity=prod[1]
            query="SELECT Name FROM Batch_Details WHERE BatchNo=%s"%(batchno)
            cursor.execute(query)
            data = cursor.fetchall()
            name=data[0][0]
            list.append(product(name,quantity))

        records.append(record(d, list))

    return render(request, 'showsalerecord.html', {'records': records})
@csrf_protect
def pay(request):
    cursor=db.cursor()
    if request.user.is_authenticated():
        custid=request.user.username
        f = '%Y-%m-%d %H:%M:%S'
        date = datetime.datetime.now().strftime(f)

        price=request.POST["price"]
        query="SELECT BatchNo, Quantity FROM Cart WHERE CustID='%s'"%(custid)
        cursor.execute(query)
        products=cursor.fetchall()
        quantity=0
        for prod in products:
            quantity+=prod[1]

        query = "INSERT INTO Sale_Record(CustID,Date,Price,Quantity,On_Offline) VALUES('%s','%s',%s,%s,'Online')" % (custid, date, price, quantity)
        cursor.execute(query)
        query = "SELECT SRID FROM Sale_Record WHERE CustID='%s' and Date='%s'" % (custid, date)
        cursor.execute(query)
        data = cursor.fetchall()
        print query
        print data
        srid = data[0][0]


        for prod in products:
            batchno = prod[0]
            quantity=prod[1]
            query="INSERT INTO SR_Prod VALUES(%s,%s,%s)"%(srid,batchno,quantity)
            cursor.execute(query)

        query="DELETE FROM Cart WHERE CustID='%s'"%(custid)
        cursor.execute(query)
        db.commit()
        messages.success(request, "Transaction Completed")
        return redirect('product')

    else:
        return render(request, 'login.html')