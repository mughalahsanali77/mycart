function add_to_cart(pid, name, price) {
    let cart = localStorage.getItem("cart");
    if (cart == null) {
        //no cart yet
        let products = [];
        let product = {
            productId: pid,
            productName: name,
            productQuantity: 1,
            productPrice: price
        }
        products.push(product);
        localStorage.setItem("cart", JSON.stringify(products));
        showToast("Product has added first time")

    } else {
        //cart is already present
        let pcart = JSON.parse(cart);
        let oldProduct = pcart.find((item) => item.productId == pid)
        if (oldProduct) {

            //only increase the quantity
            oldProduct.productQuantity = oldProduct.productQuantity + 1;

            pcart.map((item) => {
                if (item.productId == oldProduct.productId) {
                    item.prductQuantity = oldProduct.productQuantity;
                }
            })
            localStorage.setItem("cart", JSON.stringify(pcart));
          showToast(oldProduct.productName+" quantity has been increased ")
        } else {
            //we hav to add the product
            let product = {
                productId: pid,
                productName: name,
                productQuantity: 1,
                productPrice: price
            }
            pcart.push(product);
            localStorage.setItem("cart", JSON.stringify(pcart));
            showToast("product has been added to cart")
        }

    }


    updateCart();
}

updateCart();
//update cart
function updateCart() {
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);

    if (cart == null || cart.length == 0) {
        console.log("cart is empty");
        $(".cart-items").html("( 0 )")
        $(".cart-body").html("<h3>Cart does not have any item yet</h3>")
        
        $(".checkout-btn").attr('disabled',true);
    } else {

        //there is sometjing in cart
        console.log(cart);
        $(".cart-items").html(`( ${cart.length} )`);
        let table = `
         <table class='table'>
            <thead class='thead-light'>
                <tr>
                    <td>Item Name</td>
                    <td>Price</td>
                    <td>Quantity</td>
                    <td>Total Price</td>
                    <td>Action</td>
                </tr>
            </thead>

`;
        let cartTotal=0;
        cart.map((item) => {
            table += `
                    <tr>
                    
                        <td> ${item.productName} </td>
                        <td> ${item.productPrice} </td>
                        <td> ${item.productQuantity} </td>
                        <td> ${item.productQuantity * item.productPrice} </td>
                        <td><button onclick='deleteItemFromCart(${item.productId})' class='btn btn-danger btn-sm'>remove</button></td>
                    </tr>
            
            `
            cartTotal+=item.productQuantity * item.productPrice;
        })

        table = table + `
            <tr><td colspan'5' class='text-right font-weight-bold m-5'>Total Price : ${cartTotal}</td></tr>
            </table>`
        $(".cart-body").html(table);
        $(".checkout-btn").attr('disabled',false);
    }

}

function deleteItemFromCart(pid){
    let cart=JSON.parse(localStorage.getItem('cart'));
   let newCart= cart.filter((item)=>item.productId!=pid);
   localStorage.setItem('cart',JSON.stringify(newCart));
   updateCart();
   showToast("product has been removed from cart")
   
    
}



$(document).ready(function () {
    updateCart();

})
function showToast(content){
    $("#toast").addClass("display");
    $("#toast").html(content);
    setTimeout(()=>{
        $("#toast").removeClass("display");
    },2000);
} 

function goToCheckOut(){
    window.location="checkout.jsp";
}