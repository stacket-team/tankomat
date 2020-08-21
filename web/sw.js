importScripts('https://storage.googleapis.com/workbox-cdn/releases/5.1.2/workbox-sw.js');



// self.addEventListener('install', e =>{
//   e.waitUntil(
//       caches.open('tankomat')
//       .then(cache => cache.addAll([
//               '/',
//               '/icons/logo-128.png',
//               '/icons/logo-256.png',
//               '/icons/logo-512.png',
//               '/index.html',
//               '/test.js',
//               'favicon.png',
//               'manifest.json',
//               'sw.js']
//               )
//           )
          
//       ) 
//   }
// );

// workbox.precache.precacheAndRoute([
//   {url: '/index.html', revision: '383676' }
//   // ... other entries ...
// ]);

workbox.routing.registerRoute(
  /\.(?:png|ico)$/,
  new workbox.strategies.CacheFirst({
    cacheName: 'tankomat-images'
  })
);

workbox.routing.registerRoute(
  ({request}) => request.destination === 'script',
  new workbox.strategies.StaleWhileRevalidate({
    cacheName: 'tankomat-script',
    plugins: [
      new weorkbox.expiration.Plugin({
        maxEntries: 1000,
        maxAgeSeconds: 31536000
      })
    ]
  })
);