import { createApp } from 'vue'
import { createPinia } from 'pinia'
import './style.css'
import App from './App.vue'

const app = createApp(App)
const pinia = createPinia()

app.use(pinia)

// Add a smooth loading transition
document.addEventListener('DOMContentLoaded', () => {
  // Add fade-in effect to the app
  const appElement = document.getElementById('app')
  if (appElement) {
    appElement.style.opacity = '0'
    appElement.style.transition = 'opacity 0.3s ease-in-out'
    
    // Mount the app
    app.mount('#app')
    
    // Trigger fade-in after mounting
    setTimeout(() => {
      appElement.style.opacity = '1'
    }, 100)
  } else {
    app.mount('#app')
  }
})


