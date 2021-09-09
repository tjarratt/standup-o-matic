// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

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

  document.querySelector('.zen').addEventListener('click', (e) => {
    e.preventDefault();

    spotlight.innerHTML = '';
    spotlight.appendChild(presentMomentOfZen(window.moment_of_zen));
  });
});

function presentInterestings(content) {
  return present('interesting', content, 'title');
};

function presentBackmakers(content) {
  return present('backmaker', content, 'name');
};

function presentMomentOfZen(content) {
  return present('zen', [content], 'title');
}

function present(category, content, property) {
  const root = document.createElement('ul');

  content.forEach((item, index) => {
    const listItem = document.createElement('li');
    const checkbox = document.createElement('input');
    checkbox.type = 'checkbox';
    const span = document.createElement('span');
    span.innerText = item[property];
    span.classList.add('ml-3');

    const label = document.createElement('label');
    label.for = category + '-' + String(index);
    label.appendChild(checkbox);
    label.appendChild(span);
    listItem.append(label);

    root.appendChild(listItem);
  });

  return root;
}

