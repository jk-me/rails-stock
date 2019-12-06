// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$(function(){
  console.log('js loaded')
  clickToUpdate()
})

function interval(){
  console.log('interval is working')
}

function updateVal(){
  let portfolioVal = 0
  $.get('/stocks', function(sjson){
    // console.log(sjson, sjson[0].symbol)
    // let stock = sjson[0]
    for (const stock of sjson){
      $.post("/alpharesp",{symbol: stock.symbol}, function(apijson){
        console.log(apijson)
        let val = parseFloat(apijson['Global Quote']['05. price']) * parseFloat(stock.shares)
        portfolioVal += val
        // $(`.${stock.id}`).text(`${stock.symbol}, ${stock.shares} shares -------- ${val.toFixed(2)}`)
        $(`.${stock.id}`).html(`
            <span class="${stock.id}-color">
              ${stock.symbol}
            </span>
            <span>, ${stock.shares} shares--------</span>
            <span class="${stock.id}-color">${val.toFixed(2)}</span>
            <hr>
        `)

        $('#port-value').text(`($${portfolioVal.toFixed(2)})`)

        if (apijson['Global Quote']['05. price'] < apijson['Global Quote']['02. open']){
          $(`.${stock.id}-color`)[0].style.color = '#801f12'
          $(`.${stock.id}-color`)[1].style.color = '#801f12' //red, stock below open price
        }
        else if (apijson['Global Quote']['05. price'] === apijson['Global Quote']['02. open']){
          $(`.${stock.id}-color`)[0].style.color = '#515154'
          $(`.${stock.id}-color`)[1].style.color = '#515154' //grey, at open price
        }
        else{
          $(`.${stock.id}-color`)[0].style.color = '#0f8a3c'
          $(`.${stock.id}-color`)[1].style.color = '#0f8a3c'  //green, above open price
        }
        // console.log(apijson['Global Quote']['05. price'])
        // console.log(apijson['Global Quote']['01. symbol'])
      })
    }
  })
}

function clickToUpdate(){
  $('.update').on('click', function(e){
    e.preventDefault()
    updateVal()
  })
}


//-------------------------------------------

function showTransactions(){ //extra js function to load transactions without reloading page
  $('.show-t').on('click', function(e){
    e.preventDefault()
    $('.page-name').html("<span class='page-title'>Transactions</span>")

    $.get('/transactions', function(json){
      let pagehtml = '<div>'
      for (const el of json){
        pagehtml += `<p> BUY (${el.symbol}) - ${el.shares} @ ${el.price} ---- ${el.created_at}</p>`
      }
      pagehtml+='</div>'
      $('.container').html(pagehtml)
    })
  })
}
