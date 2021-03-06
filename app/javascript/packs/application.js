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

window.presentationCache = {
  interesting: {},
  event: {},
  backmaker: {},
  zen: {},
};

function cacheContains(category, key) {
  const cache = window.presentationCache[category];
  if (!cache) {
    console.error("Missing category in cache: " + category);
    return false;
  }

  return cache[key] ? true : false;
}

function cacheSet(category, key) {
  window.presentationCache[category][key] = true;
}

window.addEventListener("turbolinks:load", () => {
  const spotlight = document.querySelector('.spotlight');

  addClickListener('#presentation #interestings', (e) => {
    spotlight.innerHTML = '';
    spotlight.appendChild(presentInterestings(window.interestings));
  });

  addClickListener('#presentation #backmakers', (e) => {
    spotlight.innerHTML = '';
    spotlight.appendChild(presentBackmakers(window.backmakers));
  });

  addClickListener('#presentation #events', (e) => {
    spotlight.innerHTML = '';
    spotlight.appendChild(presentEvents(window.events));
  });

  addClickListener('#presentation #next-mc', (e) => {
    spotlight.innerHTML = '';
    presentNextWeekMCInterface(spotlight, window.next_weeks_mc, window.backmakers);
  });

  addClickListener('#presentation #zen', (e) => {
    spotlight.innerHTML = '';
    spotlight.appendChild(presentMomentOfZen(window.moment_of_zen));
  });
});

function presentNextWeekMCInterface(container, name, team) {
  if (typeof name != 'string') {
    return document.createElement('span');
  }

  const p = document.createElement('p');
  const span = document.createElement('span');
  span.innerText = "Next week's MC will be ...";
  p.appendChild(span);

  const select = document.createElement('select');
  select.className = 'ml-1';
  select.id = 'nextMC';

  for (var i = 0; i < team.length; i++) {
    const option = document.createElement('option');
    option.value = team[i].name;
    option.innerHTML = team[i].name;
    if (team[i].name === name) { option.selected = true; }

    select.appendChild(option);
  }

  p.appendChild(select);
  container.appendChild(p);

  const p2 = document.createElement('p');
  p2.className = 'mt-3';
  const submitButton = document.createElement('button');
  submitButton.innerText = 'Make it so';
  submitButton.className = 'inline-flex py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500';
  submitButton.addEventListener('click', (e) => {
    const chosen_backmaker = select.value;
    fetch('/standups/today/nominate', {
      method: 'POST',
      headers: {
        'X-CSRF-Token': csrfTokenIfPresent(),
        'Content-type': 'application/json',
      },
      body: JSON.stringify({
        'backmaker': chosen_backmaker,
      })
    }).then((_) => {
      const success = document.createElement('span');
      success.innerText = "??? You got it, boss";
      p.innerText = '';
      p.appendChild(success);
      submitButton.remove();
    });
  });

  p2.appendChild(submitButton);
  container.appendChild(p2);
}

function addClickListener(selector, callback) {
  const element = document.querySelector(selector);
  if (!element) return;

  element.addEventListener('click', callback);
}

function presentInterestings(content) {
  return present('interesting', content, 'title', 'body');
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

function present(category, content, property, detailProperty) {
  const root = document.createElement('p');
  const list = document.createElement('ul');
  list.classList.add('inline-block');
  list.classList.add('text-left');
  root.appendChild(list);

  content.forEach((item, index) => {
    const categoryId = category + '-' + String(index);
    const listItem = document.createElement('li');
    const checkbox = document.createElement('input');
    checkbox.type = 'checkbox';
    checkbox.id = categoryId;
    checkbox.classList.add('h-4');
    checkbox.classList.add('w-4');
    checkbox.classList.add('text-purple-600');
    checkbox.classList.add('focus:ring-purple-500');
    checkbox.classList.add('border-gray-300');
    checkbox.classList.add('rounded');
    checkbox.checked = cacheContains(category, categoryId);
    checkbox.addEventListener('click', function(_) {
      cacheSet(category, categoryId);
    });

    const label = document.createElement('label');
    label.htmlFor = category + '-' + String(index);
    label.innerText = item[property];
    label.classList.add('ml-3');
    listItem.append(checkbox);
    listItem.append(label);

    list.appendChild(listItem);

    if (detailProperty) {
      const detail = item[detailProperty];
      if (detail.startsWith('http://') || detail.startsWith('https://')) {
	const link = document.createElement('a');
        link.href = detail;
        link.innerText = '\xa0-\xa0' + detail; // non-breaking space
        link.classList = "font-medium text-indigo-600 hover:text-indigo-500";

        listItem.appendChild(link);
      } else {
	const text = document.createElement('label');
        text.innerText = '\xa0-\xa0' + detail;
        listItem.appendChild(text);
      }
    }
  });

  return root;
}

function csrfTokenIfPresent() {
  const tag = document.querySelector("meta[name='csrf-token']")
  if (!tag) return

  return tag.content;
}

