import {contractAddress, contractABI} from './constant.js';

const buyBtn = document.getElementById('buy-btn');
const myAddress = document.getElementById('my-address-text');
const tokenSold = document.getElementById('token-sold-text');
const priceAmount = document.getElementById('price-amount');
var contract;


window.addEventListener('load', () => {
    if(typeof(web3) === 'undefined') {
        return console.log("Metamask is not installed.");
    }
    //get the address of the user
    myAddress.innerHTML = "My account: " + web3.eth.accounts[0];
    //create a contract instance
    contract = web3.eth.contract(contractABI).at(contractAddress);
    //get the number of token sold
    contract.tokenSold.call(function(err, result){
        if(result){
            tokenSold.innerHTML = result.toNumber() + " tokens sold";
        }
    });
    
})


buyBtn.addEventListener('click', () =>{
    if(priceAmount.value <= 0 ) {
        alert("Error: under equal 0")
        return;
    }
    buyToken();
})



function buyToken(){
    if(contract == undefined) return; 
    //convert to wei
    var val = web3.toWei(priceAmount.value, 'ether');
    //send transaction
    contract.buyToken.sendTransaction({
        from:web3.eth.getAccount,
        value:val
    }, (err, res) =>{
        if(res) console.log(res)
        else console.log(err)
    })
}