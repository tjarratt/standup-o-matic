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

  addClickListener('#presentation #interestings', (e) => {
    e.preventDefault();

    spotlight.innerHTML = '';
    spotlight.appendChild(presentInterestings(window.interestings));
  });

  addClickListener('#presentation #backmakers', (e) => {
    e.preventDefault();

    spotlight.innerHTML = '';
    spotlight.appendChild(presentBackmakers(window.backmakers));
    spotlight.appendChild(presentNextWeekMCInterface(window.next_weeks_mc, window.backmakers));
  });

  addClickListener('#presentation #events', (e) => {
    e.preventDefault();

    spotlight.innerHTML = '';
    spotlight.appendChild(presentEvents(window.events));
  });

  addClickListener('#presentation #zen', (e) => {
    e.preventDefault();

    spotlight.innerHTML = '';
    spotlight.appendChild(presentMomentOfZen(window.moment_of_zen));
  });
});

function presentNextWeekMCInterface(name, team) {
  if (typeof name != 'string') {
    return document.createElement('span');
  }

  const p = document.createElement('p');
  p.style.display = 'none';

  const span = document.createElement('span');
  span.innerText = "Next week's MC will be ...";
  p.appendChild(span);

  const select = document.createElement('select');
  select.id = 'nextMC';

  for (var i = 0; i < team.length; i++) {
    const option = document.createElement('option');
    option.value = team[i].name;
    option.innerHTML = team[i].name;
    if (team[i].name === name) { option.selected = true; }

    select.appendChild(option);
  }

  const checkboxes = document.querySelectorAll('.spotlight input');
  checkboxes.forEach((ele) => {
    ele.addEventListener('change', (e) => {
      var isUnchecked = undefined;
      checkboxes.forEach((checkbox) => {
        if (checkbox.checked == false) {
          isUnchecked = true;
          return;
        }
      });

      if (isUnchecked) { p.style.display = 'none'; }
      else             { p.style.display = 'block'; }
    });
  });

  p.appendChild(select);

  const submitButton = document.createElement('button');
  submitButton.innerText = 'Make it so';
  submitButton.addEventListener('click', (e) => {
    const chosen_backmaker = select.value;
    fetch('/standups/today/nominate', {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").content,
        'Content-type': 'application/json',
      },
      body: JSON.stringify({
        'backmaker': chosen_backmaker,
      })
    });
  });

  p.appendChild(submitButton);

  return p;
}

function addClickListener(selector, callback) {
  const element = document.querySelector(selector);
  if (!element) return;

  element.addEventListener('click', callback);
}

function presentInterestings(content) {
  return present('interesting', content, 'title');
};

function presentBackmakers(content) {
  return present('backmaker', content, 'name');
};

function presentEvents(content) {
  return present('event', content, 'label');
}

function presentMomentOfZen(content) {
  return present('zen', [content], 'title');
}

function present(category, content, property) {
  const root = document.createElement('p');
  const list = document.createElement('ul');
  root.appendChild(list);

  content.forEach((item, index) => {
    const listItem = document.createElement('li');
    const checkbox = document.createElement('input');
    checkbox.type = 'checkbox';
    checkbox.id = category + '-' + String(index);

    const label = document.createElement('label');
    label.htmlFor = category + '-' + String(index);
    label.innerText = item[property];
    label.classList.add('ml-3');
    listItem.append(checkbox);
    listItem.append(label);

    list.appendChild(listItem);
  });

  return root;
}

