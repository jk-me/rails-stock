// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$(function(){
  console.log('js loaded')
  updateVal()
  // showTransactions()
  showPortfolio()
})

function updateVal(){

}

function showTransactions(){ //extra
  $('.show-t').on('click', function(e){
    e.preventDefault()
    $('.page-name').html(`<span class='page-title'>Transactions</span>`)

    $.get('/transactions', function(json){
      let pagehtml = '<div>'
      for (const el of json){
        pagehtml += `
          <p> BUY (${el.symbol}) - ${el.shares} @ ${el.price} ---- ${el.created_at}</p>
           `
      }
      pagehtml+='</div>'
      $('.container').html(pagehtml)
    })
  })
}

function showPortfolio(){
  $('.show-p').on('click', function(e){
    e.preventDefault
    let id = $(this).data('account')
    let portfolioVal = 0
    $.get('/stocks', function(sjson){  //first column, stock data and api data
      console.log(sjson, sjson[0].symbol)
      // let stock = sjson[0]
      for (const stock of sjson){
        $.post("/alpharesp",{symbol: stock.symbol}, function(apijson){
          let val = parseFloat(apijson['Global Quote']['05. price']) * parseFloat(stock.shares)
          portfolioVal += val
          $(`.${stock.id}`).text(`${stock.symbol}, ${stock.shares} shares -------- ${val}`)
          console.log(apijson)
          // console.log(apijson['Global Quote']['05. price'])
          // console.log(apijson['Global Quote']['01. symbol'])
        })
      }

    })
  })

}
