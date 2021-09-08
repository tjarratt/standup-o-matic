// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "../application.css"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

window.addEventListener("turbolinks:load", () => {
  const spotlight = document.querySelector('.spotlight');

  document.querySelector('.interestings').addEventListener('click', (e) => {
    e.preventDefault();

    spotlight.innerHTML = '';
    spotlight.appendChild(presentInterestings(window.interestings));
  });

  document.querySelector('.backmakers').addEventListener('click', (e) => {
    e.preventDefault();

    spotlight.innerHTML = '';
    spotlight.appendChild(presentBackmakers(window.backmakers));
  });
});

function presentInterestings(content) {
  const root = document.createElement('ul');

  content.forEach((item) => {
    const listItem = document.createElement('li');
    listItem.innerText = item.title;
    root.appendChild(listItem);
  });

  return root;
};

function presentBackmakers(content) {
  const root = document.createElement('ul');

  content.forEach((item) => {
    const listItem = document.createElement('li');
    listItem.innerText = item.name;
    root.appendChild(listItem);
  });

  return root;
};

