// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

const vapidPublicKey = new Uint8Array(<%= Base64.urlsafe_decode64(Rails.application.credentials.dig(:webpush, :public_key)).bytes %>);

if (navigator.serviceWorker) {
  navigator.serviceWorker.register("/serviceworker.js").then(function (reg) {
    navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
  serviceWorkerRegistration.pushManager
  .subscribe({
    userVisibleOnly: true,
    applicationServerKey: vapidPublicKey
  });
});
		console.log("Service worker change, registered the service worker");
	});
}
// Otherwise, no push notifications :(
else {
	console.error("Service worker is not supported in this browser");
}
