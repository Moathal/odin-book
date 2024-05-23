self.addEventListener("push", (event) => {
  const data = event.data.json();
  let title = data.title || "awesome webpush";
  let body = data.body || "awesome webpush is pushed";
  let icon = "/images/icon-192x192.png";
  let tag = data.type || "simple-push-demo-notification-tag";

  event.waitUntil(
    self.registration.showNotification(title, { body, icon, tag, data })
  );
});

self.addEventListener("notificationclick", (event) => {
  const data = event.notification.data;
  event.notification.close();


  event.waitUntil(clients.openWindow(data.url));
});