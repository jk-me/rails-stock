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
  })
}

function showPortfolio(){
  $('.show-p').on('click', function(e){
    
    titlehtml = `<span class='page-title'>Portfolio</span> <span id='port_value'> ( $<%= @account.balance %> )</span>`
    $('.page-name').html(titlehtml)

  })

}
