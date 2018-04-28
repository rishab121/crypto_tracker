// Attribution -> Nat's Notes 
import "phoenix_html"
import React from 'react';
import ReactDOM from 'react-dom';

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
import socket from "./socket"

import run_all from "./all";
import run_coin from "./cs/coin-info";
import run_mycur from "./mycur";

import $ from "jquery";

function init() {
  let root = document.getElementById('root2');
  if (!root){
    return;
  }
  
  let channel = socket.channel("all:demo", {});
  
  run_all(root,channel);
}
function init2() {
  let mycur = document.getElementById('mycur-page');
  if (!mycur){
    return;
  }
  
  let channel = socket.channel("all:demo", {});
  
  run_mycur(mycur,channel);
}

function coinInfo(){
  let coinPage = document.getElementById('coin-page');
  if(!coinPage){
    return;
  }
  run_coin(coinPage);
}


function update_buttons() {
  $('.follow-button').each( (_, bb) => {
    let currency_id = $(bb).data('currency-id');
    let follow_id = $(bb).data('follow');
    if (follow_id != "") {
      $(bb).text("Unfollow");
      $(bb).removeClass("btn-success");
      $(bb).addClass("btn-danger");
    }
    else {
      $(bb).text("Follow");
      $(bb).removeClass("btn-danger");
      $(bb).addClass("btn-success")
    }
  });
}

function set_button(currency_id, value) {
  $('.follow-button').each( (_, bb) => {
    if (currency_id == $(bb).data('currency-id')) {
      $(bb).data('follow', value);
    }
  });
  update_buttons();
}

function follow(currency_id) {
  let text = JSON.stringify({
    follow: {
        user_id: current_user_id,
        currency_id: currency_id
      },
  });

  $.ajax(follow_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_button(currency_id, resp.data.id); },
  });
}

function unfollow(currency_id, follow_id) {
  $.ajax(follow_path + "/" + follow_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: () => { set_button(currency_id, ""); },
  });
}

function follow_click(ev) {
  let btn = $(ev.target);
  let follow_id = btn.data('follow');
  let currency_id = btn.data('currency-id');

  if (follow_id != "") {
    unfollow(currency_id, follow_id);
  }
  else {
    follow(currency_id);
  }
}

function init_follow() {
  if (!$('.follow-button')) {
    return;
  }

  $(".follow-button").click(follow_click);

  update_buttons();
}

$(init_follow)


// Use jQuery to delay until page loaded.
$(init);
$(init2);
$(coinInfo);