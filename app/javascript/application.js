// app/javascript/application.js
import "@hotwired/turbo-rails";
import { Application } from "@hotwired/stimulus";
import ReactController from "./controllers/react_controller";
import "controllers";
import "trix";
import "@rails/actiontext";

// Initialize Stimulus application and register the React controller
const application = Application.start();
application.register("react", ReactController);

// VAPID key for web push notifications
const vapidPublicKey = new Uint8Array(
  <%= Base64.urlsafe_decode64(Rails.application.credentials.dig(:webpush, :public_key)).bytes %>
);

if (navigator.serviceWorker) {
  navigator.serviceWorker.register("/serviceworker.js").then(function (reg) {
    navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
      serviceWorkerRegistration.pushManager.subscribe({
        userVisibleOnly: true,
        applicationServerKey: vapidPublicKey
      });
    }).then(async function(sub) {
      const data = await fetch('/notifySubscription', {
        method: 'POST',
        headers: {
          'content-type': 'application/json'
        },
        body: JSON.stringify(sub)
      }).then(postData => postData.json());
    });
  });
} else {
  console.error("Service worker is not supported in this browser");
}
