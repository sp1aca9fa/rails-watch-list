// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core";
import "bootstrap";

// Override Turbo's native confirm dialog with a styled Bootstrap modal
Turbo.config.forms.confirm = (message) => {
  return new Promise((resolve) => {
    const modalEl  = document.getElementById("confirmModal");
    const okBtn    = document.getElementById("confirmModalOk");
    const cancelBtn = document.getElementById("confirmModalCancel");

    document.getElementById("confirmModalMessage").textContent = message;

    // Show modal + backdrop via DOM (avoids Bootstrap JS named-import issue)
    const backdrop = document.createElement("div");
    backdrop.className = "modal-backdrop fade show";
    document.body.appendChild(backdrop);
    document.body.classList.add("modal-open");
    modalEl.style.display = "block";
    requestAnimationFrame(() => modalEl.classList.add("show"));

    const close = (result) => {
      modalEl.classList.remove("show");
      modalEl.style.display = "none";
      document.body.classList.remove("modal-open");
      backdrop.remove();
      resolve(result);
    };

    okBtn.addEventListener("click",    () => close(true),  { once: true });
    cancelBtn.addEventListener("click", () => close(false), { once: true });
    backdrop.addEventListener("click",  () => close(false));
  });
};
