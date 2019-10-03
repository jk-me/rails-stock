// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$(function(){
  console.log('js loaded')
  updateVal()
  showTransactions()
  showPortfolio()
})

function updateVal(){

}

function showTransactions(){
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
    let pagehtml
    $.get('/stocks', function(sjson){  //first column, stock data and api data
      for (const stock of sjson){
        $.post('/alphavantage',
          {}
          , function(apijson){

        })
      }



      // let titlehtml = `<span class='page-title'>Portfolio</span> <span id='port_value'> ( ${} )</span>`

      $('.page-name').html(titlehtml)
    })
    $.get('/account/'+id+'.json', function(json){ //second column, account data for form
      pagehtml = `<div class="col">
    <p>Balance: $${json.balance}</p>
    <form action="/alphavantage" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="✓"><input type="hidden" name="authenticity_token" value="AOa8fXpbF/IcEy52ALnVXYWNUr1kvaF5ZUS1COLzt0mZwT2A9P/AwmSkWy+gh5HWVA5M2X1x66wkssR2x6H6lw==">
      <p>Symbol: <input type="text" name="symbol" id="symbol"></p>
      <p>No. Shares: <input type="number" name="shares" id="shares"></p>
      <input type="submit" name="commit" value="Purchase" data-disable-with="Purchase">
</form>  </div>`
    })


  })

}
