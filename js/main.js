// DPTC Main JavaScript

// Show all fade-in elements immediately (no animation delay)
document.querySelectorAll('.fade-in').forEach(el => el.classList.add('visible'));

// Navbar scroll effect
const navbar = document.getElementById('navbar');
window.addEventListener('scroll', () => {
  navbar.classList.toggle('scrolled', window.scrollY > 50);
});

// Mobile menu
const hamburger = document.getElementById('hamburger');
const mobileMenu = document.getElementById('mobileMenu');
const mobileClose = document.getElementById('mobileClose');
if (hamburger) hamburger.addEventListener('click', () => mobileMenu.classList.add('open'));
if (mobileClose) mobileClose.addEventListener('click', () => mobileMenu.classList.remove('open'));
if (mobileMenu) mobileMenu.querySelectorAll('a').forEach(link => {
  link.addEventListener('click', () => mobileMenu.classList.remove('open'));
});

// Service filter tabs
const filterBtns = document.querySelectorAll('.filter-btn');
const serviceCards = document.querySelectorAll('.service-card');
filterBtns.forEach(btn => {
  btn.addEventListener('click', () => {
    filterBtns.forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    const filter = btn.dataset.filter;
    serviceCards.forEach(card => {
      if (filter === 'all' || card.dataset.category === filter) {
        card.classList.remove('hidden');
      } else {
        card.classList.add('hidden');
      }
    });
  });
});

// Contact form
const contactForm = document.getElementById('contactForm');
if (contactForm) contactForm.addEventListener('submit', e => {
  e.preventDefault();
  const btn = contactForm.querySelector('.form-submit');
  btn.textContent = 'Message Sent!';
  btn.style.background = '#16a34a';
  setTimeout(() => {
    btn.textContent = 'Send Message';
    btn.style.background = '';
    contactForm.reset();
  }, 3000);
});

// Subscribe form
const subscribeForm = document.getElementById('subscribeForm');
if (subscribeForm) subscribeForm.addEventListener('submit', e => {
  e.preventDefault();
  const btn = subscribeForm.querySelector('button');
  btn.textContent = 'Done!';
  setTimeout(() => { btn.textContent = '>'; subscribeForm.reset(); }, 2000);
});

// Current day highlight
const days = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
const today = days[new Date().getDay()];
document.querySelectorAll('.hours-table tr').forEach(row => {
  const dayCell = row.querySelector('td:first-child');
  if (dayCell && dayCell.textContent.trim() === today) row.classList.add('today');
});
