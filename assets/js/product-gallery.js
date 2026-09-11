/**
 * Product Card In-Card Carousel & Smooth Contact/Enquiry Navigation
 * Shree Ram & Company (Vijeta Stone) - Jaipur
 * 
 * - In-card carousel with 4-5 images per product (Width 900 x Height 1200, 3:4 portrait ratio)
 * - Previous / Next navigation arrows
 * - Small indicator dots
 * - Touch swipe support on mobile
 * - Minimal Luxury Card: ONLY Carousel + Product Name
 * - NO lightboxes or large photo popups
 * - NO separate product-detail pages
 * - Clicking the card smoothly scrolls to the existing Contact / Enquiry Form section
 *   and automatically pre-fills the selected product name
 */

// ---------------------------------------------------------------------------
// 1. IN-CARD SLIDER / CAROUSEL LOGIC
// ---------------------------------------------------------------------------

function shiftCardSlide(btn, delta, event) {
    if (event) {
        event.preventDefault();
        event.stopPropagation();
    }
    const gallery = btn.closest('.product-gallery');
    if (!gallery) return;

    const track = gallery.querySelector('.gallery-track');
    const slides = gallery.querySelectorAll('.gallery-slide');
    const dots = gallery.querySelectorAll('.gallery-indicators .indicator-dot');
    const total = slides.length;
    if (total <= 1) return;

    let currentIndex = parseInt(gallery.getAttribute('data-active-index') || '0', 10);
    currentIndex = (currentIndex + delta + total) % total;
    gallery.setAttribute('data-active-index', currentIndex);

    track.style.transform = `translateX(-${currentIndex * 100}%)`;

    // Lazy-load active and adjacent images
    loadSlideImage(slides[currentIndex]);
    if (slides[(currentIndex + 1) % total]) loadSlideImage(slides[(currentIndex + 1) % total]);

    // Update dot indicators
    dots.forEach((dot, idx) => {
        if (idx === currentIndex) {
            dot.classList.remove('bg-white/50', 'w-1.5');
            dot.classList.add('bg-white', 'w-3');
        } else {
            dot.classList.remove('bg-white', 'w-3');
            dot.classList.add('bg-white/50', 'w-1.5');
        }
    });
}

function goToCardSlide(dot, targetIndex, event) {
    if (event) {
        event.preventDefault();
        event.stopPropagation();
    }
    const gallery = dot.closest('.product-gallery');
    if (!gallery) return;

    const track = gallery.querySelector('.gallery-track');
    const slides = gallery.querySelectorAll('.gallery-slide');
    const dots = gallery.querySelectorAll('.gallery-indicators .indicator-dot');

    gallery.setAttribute('data-active-index', targetIndex);
    track.style.transform = `translateX(-${targetIndex * 100}%)`;

    loadSlideImage(slides[targetIndex]);

    dots.forEach((d, idx) => {
        if (idx === targetIndex) {
            d.classList.remove('bg-white/50', 'w-1.5');
            d.classList.add('bg-white', 'w-3');
        } else {
            d.classList.remove('bg-white', 'w-3');
            d.classList.add('bg-white/50', 'w-1.5');
        }
    });
}

function loadSlideImage(slide) {
    if (!slide) return;
    const img = slide.querySelector('img');
    if (img && img.getAttribute('data-src')) {
        img.src = img.getAttribute('data-src');
        img.removeAttribute('data-src');
    }
}

// ---------------------------------------------------------------------------
// 2. CARD CLICK & SMOOTH SCROLL TO ENQUIRY FORM (No Popups / No Detail Pages)
// ---------------------------------------------------------------------------

function handleCardClick(productName, categoryName, event) {
    // If the click happened on arrow or dot indicators, do not trigger card navigation
    if (event) {
        if (event.target.closest('.gallery-arrow') || event.target.closest('.gallery-indicators')) {
            return;
        }
    }
    selectProductForEnquiry(productName, categoryName);
}

function selectProductForEnquiry(productName, categoryName) {
    const contactSection = document.getElementById('contact') || document.getElementById('enquiry');

    // Update on-page enquiry form inputs if present
    const badge = document.getElementById('enquiry-product-badge');
    const badgeName = document.getElementById('enquiry-badge-name');
    const prodInput = document.getElementById('enquiry-product');
    const waLink = document.getElementById('contact-whatsapp-link');
    const msgInput = document.getElementById('contact-message') || document.getElementById('details') || document.getElementById('message');

    if (badge && badgeName) {
        badgeName.textContent = productName;
        badge.classList.remove('hidden');
    }

    if (prodInput) {
        prodInput.value = `${productName}${categoryName ? ' (' + categoryName + ')' : ''}`;
    }

    if (waLink) {
        const msg = `Hello Shree Ram & Company, I am interested in inquiring about: ${productName}${categoryName ? ' (' + categoryName + ')' : ''}.`;
        waLink.href = `https://wa.me/916367607459?text=${encodeURIComponent(msg)}`;
    }

    if (msgInput && msgInput.id === 'details' && !msgInput.value) {
        msgInput.value = `Interested in: ${productName}. Please provide bespoke pricing and dimensions.`;
    }

    // Directly and smoothly scroll to the Contact / Enquiry Form section
    if (contactSection) {
        contactSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
        setTimeout(() => {
            const nameInput = document.getElementById('contact-name') || contactSection.querySelector('input[type="text"]');
            if (nameInput) nameInput.focus();
        }, 500);
    } else {
        // Fallback if accessed on an external page without on-page form
        window.location.href = `/get-a-quote/?product=${encodeURIComponent(productName)}`;
    }
}

function clearSelectedProduct() {
    const badge = document.getElementById('enquiry-product-badge');
    if (badge) badge.classList.add('hidden');
    const prodInput = document.getElementById('enquiry-product');
    if (prodInput) prodInput.value = '';
    const waLink = document.getElementById('contact-whatsapp-link');
    if (waLink) {
        waLink.href = "https://wa.me/916367607459?text=Hello%20Shree%20Ram%20%26%20Company%2C%20I%20would%20like%20to%20inquire%20about%20custom%20stone%20work.";
    }
}

// ---------------------------------------------------------------------------
// 3. INITIALIZATION & MOBILE TOUCH GESTURES
// ---------------------------------------------------------------------------

function initProductGalleries() {
    // Attach touch gestures for mobile swiping inside each card
    document.querySelectorAll('.product-gallery').forEach(gallery => {
        if (gallery.dataset.swipeInitialized) return;
        gallery.dataset.swipeInitialized = 'true';

        let touchStartX = 0;
        let touchEndX = 0;

        gallery.addEventListener('touchstart', (e) => {
            touchStartX = e.changedTouches[0].screenX;
        }, { passive: true });

        gallery.addEventListener('touchend', (e) => {
            touchEndX = e.changedTouches[0].screenX;
            const diff = touchEndX - touchStartX;
            if (Math.abs(diff) > 40) {
                if (diff < 0) {
                    shiftCardSlide(gallery.querySelector('.gallery-arrow.next-btn'), 1);
                } else {
                    shiftCardSlide(gallery.querySelector('.gallery-arrow.prev-btn'), -1);
                }
            }
        }, { passive: true });
    });

    // Check URL parameters for pre-selected product
    const urlParams = new URLSearchParams(window.location.search);
    const paramProduct = urlParams.get('product');
    if (paramProduct) {
        selectProductForEnquiry(paramProduct, '');
    }
}

document.addEventListener('DOMContentLoaded', () => {
    initProductGalleries();
});
